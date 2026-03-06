local ffi = require("ffi")
local ansi = require("ansi")

local x86 = {}

local ops = require("rv.x86.ops")
local op1 = ops.op1
local op2 = ops.op2

---@type fun(ptr: ffi.cdata*, i: number): number
local parseModRM

do
	ffi.cdef [[
		typedef struct {
			uint8_t rm  : 3;
			uint8_t reg : 3;
			uint8_t mod : 2;
		} ModRM;
	]]

	---@class rv.x86.ModRM: ffi.cdata*
	---@field rm number
	---@field reg number
	---@field mod number

	local MOD_REG    = 3 -- register operand, no memory access
	local MOD_DISP8  = 1 -- 8-bit displacement follows
	local MOD_DISP32 = 2 -- 32-bit displacement follows
	local RM_SIB     = 4 -- SIB byte follows
	local RM_DISP32  = 5 -- RIP-relative or disp32 with no base

	---@param ptr ffi.cdata*
	---@param i number
	---@return number, rv.x86.ModRM, number? # new index, modrm struct, optional displacement
	function parseModRM(ptr, i)
		---@type rv.x86.ModRM
		local m = ffi.cast("ModRM*", ptr + i)[0]; i = i + 1

		---@type number?
		local disp = nil

		if m.mod == MOD_REG then return i, m, nil end

		if m.rm == RM_SIB then
			local sib = ffi.cast("ModRM*", ptr + i)[0]; i = i + 1
			if m.mod == 0 and sib.rm == RM_DISP32 then
				disp = ffi.cast("int32_t*", ptr + i)[0]
				i = i + 4
			end
		end

		if m.mod == MOD_DISP8 then
			disp = ffi.cast("int8_t*", ptr + i)[0]
			i = i + 1
		elseif m.mod == MOD_DISP32 then
			disp = ffi.cast("int32_t*", ptr + i)[0]
			i = i + 4
		elseif m.mod == 0 and m.rm == RM_DISP32 then
			disp = ffi.cast("int32_t*", ptr + i)[0]
			i = i + 4
		end

		return i, m, disp
	end
end

local prefixes = {
	[0xF0] = "LOCK: atomic memory operation",
	[0xF2] = "REPNE/REPNZ: repeat while not equal",
	[0xF3] = "REP/REPE/REPZ: repeat while equal",
	[0x2E] = "CS: segment override (also branch not taken hint)",
	[0x36] = "SS: segment override",
	[0x3E] = "DS: segment override (also branch taken hint)",
	[0x26] = "ES: segment override",
	[0x64] = "FS: segment override (thread local storage on Linux)",
	[0x65] = "GS: segment override (thread local storage on Windows)",
	[0x66] = "operand size override (32-bit <-> 16-bit)",
	[0x67] = "address size override (64-bit <-> 32-bit)",
}

---@alias rv.x86.Rex { w: boolean, r: boolean, x: boolean, b: boolean }

---@param ptr ffi.cdata*
---@param i number
local function parsePrefixes(ptr, i)
	---@type rv.x86.Rex
	local rex = {}

	while true do
		local b = ptr[i]
		if prefixes[b] then
			i = i + 1
		elseif b >= 0x40 and b <= 0x4F then
			rex.w = bit.band(b, 0b1000) ~= 0
			rex.r = bit.band(b, 0b0100) ~= 0
			rex.x = bit.band(b, 0b0010) ~= 0
			rex.b = bit.band(b, 0b0001) ~= 0

			i = i + 1
		else
			break
		end
	end

	return i, rex
end

---@param ptr ffi.cdata*
---@param offset number
---@param size number
local function readImm(ptr, offset, size)
	if size == 1 then
		return tostring(ffi.cast("int8_t*", ptr + offset)[0])
	elseif size == 4 then
		return tostring(ffi.cast("int32_t*", ptr + offset)[0])
	elseif size == 8 then
		return tostring(ffi.cast("int64_t*", ptr + offset)[0])
	end
end

---@param instr ffi.cdata*
---@param start number
---@param imm number
---@return string?
local function immToAscii(instr, imm, start)
	if imm > 0 then
		local printable = true
		for j = 0, imm - 1 do
			local b = instr[start + j]
			if b < 0x20 or b > 0x7E then
				printable = false
				break
			end
		end

		if printable then
			local chars = {}
			for j = 0, imm - 1 do
				chars[j + 1] = string.char(instr[start + j])
			end

			return table.concat(chars)
		end
	end
end

local regs = {
	[8] = { "rax", "rcx", "rdx", "rbx", "rsp", "rbp", "rsi", "rdi",
		"r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15" },
	[4] = { "eax", "ecx", "edx", "ebx", "esp", "ebp", "esi", "edi",
		"r8d", "r9d", "r10d", "r11d", "r12d", "r13d", "r14d", "r15d" },
	[2] = { "ax", "cx", "dx", "bx", "sp", "bp", "si", "di",
		"r8w", "r9w", "r10w", "r11w", "r12w", "r13w", "r14w", "r15w" },
	[1] = { "al", "cl", "dl", "bl", "ah", "ch", "dh", "bh",
		"r8b", "r9b", "r10b", "r11b", "r12b", "r13b", "r14b", "r15b" },
}

---@param op rv.x86.Op
---@param modrm rv.x86.ModRM
---@param rex rv.x86.Rex
---@param disp number?
---@return string?, string?
local function decodeOperands(op, modrm, rex, disp)
	local size   = (rex.w or op.is64) and 8 or 4
	local regIdx = modrm.reg + (rex.r and 8 or 0)
	local rmIdx  = modrm.rm + (rex.b and 8 or 0)

	local reg    = regs[size][regIdx + 1]

	local rm
	if modrm.mod == 3 then
		rm = regs[size][rmIdx + 1]
	elseif modrm.mod == 0 and modrm.rm == 5 then
		-- RIP-relative
		rm = string.format("[rip%+d]", disp or 0)
	else
		local base = regs[8][rmIdx + 1]
		if disp and disp ~= 0 then
			rm = string.format("[%s%+d]", base, disp)
		else
			rm = "[" .. base .. "]"
		end
	end

	return reg, rm
end

---@param opcode number
---@param reg string?
---@param rm string?
---@return string?, string?
local function operandOrder(opcode, reg, rm)
	if bit.band(opcode, 0x02) ~= 0 then
		return reg, rm -- reg destination
	else
		return rm, reg -- rm destination
	end
end

---@param ptr ffi.cdata*
---@return number # Length of instruction in bytes
---@return { name: string, ascii: string?, dst: string?, src: string? }?
local function decodeInstruction(ptr)
	local i, rex = parsePrefixes(ptr, 0)

	local opcodeOffset = i

	---@type number
	local opcode = ptr[i]; i = i + 1

	local enc
	if opcode == 0x0F then
		opcode = ptr[i]; i = i + 1
		enc = op2[opcode]
	else
		enc = op1[opcode]
	end

	-- Unrecognized op, hope its a single byte
	if not enc then
		return i
	end

	local imm = enc.imm
	if rex.w and imm == 4 then
		imm = 8
	end

	local name = enc.name

	local reg, rm
	local src, dst

	---@type rv.x86.ModRM?
	local modrm

	if enc.modrm then
		local disp
		i, modrm, disp = parseModRM(ptr, i)

		reg, rm = decodeOperands(enc, modrm, rex, disp)
		dst, src = operandOrder(opcode, reg, rm)

		if enc.imm > 0 then
			src = readImm(ptr, i, imm)
		end

		if enc.grp then
			name = enc.grp[modrm.reg + 1] or enc.name
		end
	end

	local ascii = immToAscii(ptr, imm, i)
	i = i + imm

	if name == "nop" then
		-- Special case for multi-byte NOPs which have ModRM and immediate bytes that don't actually do anything
		dst, src, ascii = nil, nil, nil
	end

	return i, { name = name, ascii = ascii, dst = dst, src = src }
end

---@param content string
function x86.disassemble(content)
	local bytes = ffi.cast("const uint8_t*", content)
	local i = 0

	while i < #content do
		local len, op = decodeInstruction(bytes + i)

		local hex = {}
		for j = 1, len do
			hex[j] = string.format("%02X", bytes[i + j - 1])
		end

		if op then
			local operands = { op.dst }
			if op.src then operands[#operands + 1] = op.src end

			local operandStr = #operands > 0 and (" " .. table.concat(operands, ", ")) or ""
			local asciiStr   = op.ascii and ('  "' .. op.ascii .. '"') or ""

			ansi.printf(
				"{blue}%08X{reset}: {yellow}%s{gray} -- %s{reset}%s{green}%s",
				i,
				table.concat(hex, " "),
				op.name,
				operandStr,
				asciiStr
			)
		else
			ansi.printf(
				"{blue}%08X{reset}: {yellow}%s{gray}",
				i,
				table.concat(hex, " ")
			)
		end

		i = i + len
	end
end

return x86
