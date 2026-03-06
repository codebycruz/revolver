local ffi = require("ffi")

ffi.cdef [[
typedef struct {
  uint8_t  e_ident[16];
  uint16_t e_type, e_machine;
  uint32_t e_version;
  uint64_t e_entry, e_phoff, e_shoff;
  uint32_t e_flags;
  uint16_t e_ehsize, e_phentsize, e_phnum;
  uint16_t e_shentsize, e_shnum, e_shstrndx;
} Elf64_Ehdr;

typedef struct {
  uint32_t sh_name, sh_type, sh_flags;
  uint32_t _pad;
  uint64_t sh_addr, sh_offset, sh_size;
  uint32_t sh_link, sh_info;
  uint64_t sh_addralign, sh_entsize;
} Elf64_Shdr;
]]

---@class revolver.ffi.Elf64_Ehdr: ffi.cdata*
---@field e_ident number[]
---@field e_type number
---@field e_machine number
---@field e_version number
---@field e_entry number
---@field e_phoff number
---@field e_shoff number
---@field e_flags number
---@field e_ehsize number
---@field e_phentsize number
---@field e_phnum number
---@field e_shentsize number
---@field e_shnum number
---@field e_shstrndx number

---@class revolver.ffi.Elf64_Shdr: ffi.cdata*
---@field sh_name number
---@field sh_type number
---@field sh_flags number
---@field sh_addr number
---@field sh_offset number
---@field sh_size number
---@field sh_link number
---@field sh_info number
---@field sh_addralign number
---@field sh_entsize number

local elf = {}

--- Returns the text section of the given ELF file.
---@param content string The content of the ELF file.
function elf.text(content)
	local bytes = ffi.cast("const uint8_t*", content)

	---@type revolver.ffi.Elf64_Ehdr
	local header = ffi.cast("Elf64_Ehdr*", bytes)

	---@type revolver.ffi.Elf64_Shdr
	local shstrtab_hdr = ffi.cast("Elf64_Shdr*", bytes + header.e_shoff
		+ header.e_shstrndx * header.e_shentsize)

	local shstrtab = bytes + shstrtab_hdr.sh_offset

	for i = 0, header.e_shnum - 1 do
		---@type revolver.ffi.Elf64_Shdr
		local shdr = ffi.cast("Elf64_Shdr*", bytes + header.e_shoff
			+ i * header.e_shentsize)

		if ffi.string(shstrtab + shdr.sh_name) == ".text" then
			return ffi.string(bytes + shdr.sh_offset, shdr.sh_size)
		end
	end

	return nil
end

return elf
