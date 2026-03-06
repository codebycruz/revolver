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

	local MOD_REG    = 3 -- register operand, no memory access
	local MOD_DISP8  = 1 -- 8-bit displacement follows
	local MOD_DISP32 = 2 -- 32-bit displacement follows
	local RM_SIB     = 4 -- SIB byte follows
	local RM_DISP32  = 5 -- RIP-relative or disp32 with no base

	function parseModRM(ptr, i)
		local m = ffi.cast("ModRM*", ptr + i)[0]; i = i + 1

		if m.mod == MOD_REG then return i end

		if m.rm == RM_SIB then
			local sib = ffi.cast("ModRM*", ptr + i)[0]; i = i + 1
			if m.mod == 0 and sib.rm == RM_DISP32 then i = i + 4 end
		end

		if m.mod == MOD_DISP8 then
			i = i + 1
		elseif m.mod == MOD_DISP32 then
			i = i + 4
		elseif m.mod == 0 and m.rm == RM_DISP32 then
			i = i + 4
		end

		return i
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

---@param ptr ffi.cdata*
---@param i number
local function skipPrefixes(ptr, i)
	local is64 = false

	while true do
		local b = ptr[i]
		if prefixes[b] then
			i = i + 1
		elseif b >= 0x40 and b <= 0x4F then
			is64 = bit.band(b, 0b1000) ~= 0
			i = i + 1
		else
			break
		end
	end

	return i, is64
end

---@param ptr ffi.cdata*
---@return number # Length of instruction in bytes
---@return { name: string }?
local function decodeInstruction(ptr)
	local i, is64 = skipPrefixes(ptr, 0)

	local opcode_offset = i
	local op = ptr[i]; i = i + 1
	local enc

	if op == 0x0F then
		op = ptr[i]; i = i + 1
		enc = op2[op]
	else
		enc = op1[op]
	end

	-- Unrecognized op, hope its a single byte
	if not enc then
		return i
	end

	if enc.modrm then
		i = parseModRM(ptr, i)
	end

	local imm = enc.imm
	if is64 and imm == 4 then
		imm = 8
	end

	i = i + imm

	local name = enc.name
	if enc.group then
		local modrm = ffi.cast("ModRM*", ptr + opcode_offset + 1)[0]
		name = enc.group[modrm.reg + 1] or enc.name
	end

	return i, { name = name }
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
			ansi.printf(
				"{blue}%08X{reset}: {yellow}%s{gray} -- %s",
				i,
				table.concat(hex, " "),
				op.name
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
