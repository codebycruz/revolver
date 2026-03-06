local ffi = require("ffi")

local ansi = require("ansi")
local elf = require("rv.elf")
local x86 = require("rv.x86")

---@param args clap.Args
local function open(args)
	local filename = args:pop()
	if not filename then
		ansi.printf("usage: rv {cyan}<filename>")
		return
	end

	local handle = io.open(filename, "rb")
	if not handle then
		ansi.printf("error: could not open file {cyan}%s", filename)
		return
	end

	---@type string
	local content = handle:read("*a")
	handle:close()

	local out = elf.text(content)
	local disasm = x86.disassemble(out)
end

return open
