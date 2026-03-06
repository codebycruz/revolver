--- This file is MOSTLY generated.

---@alias rv.x86.Op { name: string, modrm: boolean, imm: integer, group: string[] }

--- 1 byte opcodes
---@type rv.x86.Op[]
local op1 = {}

--- 2 byte opcodes
---@type rv.x86.Op[]
local op2 = {}

-- one byte opcodes
op1[0x00] = { name = "add r/m r8", modrm = true, imm = 0 }
op1[0x01] = { name = "add r/m r", modrm = true, imm = 0 }
op1[0x02] = { name = "add r r/m8", modrm = true, imm = 0 }
op1[0x03] = { name = "add r r/m", modrm = true, imm = 0 }
op1[0x04] = { name = "add al imm8", modrm = false, imm = 1 }
op1[0x05] = { name = "add ax imm", modrm = false, imm = 4 }
op1[0x08] = { name = "or r/m r8", modrm = true, imm = 0 }
op1[0x09] = { name = "or r/m r", modrm = true, imm = 0 }
op1[0x0A] = { name = "or r r/m8", modrm = true, imm = 0 }
op1[0x0B] = { name = "or r r/m", modrm = true, imm = 0 }
op1[0x0C] = { name = "or al imm8", modrm = false, imm = 1 }
op1[0x0D] = { name = "or ax imm", modrm = false, imm = 4 }
op1[0x10] = { name = "adc r/m r8", modrm = true, imm = 0 }
op1[0x11] = { name = "adc r/m r", modrm = true, imm = 0 }
op1[0x12] = { name = "adc r r/m8", modrm = true, imm = 0 }
op1[0x13] = { name = "adc r r/m", modrm = true, imm = 0 }
op1[0x14] = { name = "adc al imm8", modrm = false, imm = 1 }
op1[0x15] = { name = "adc ax imm", modrm = false, imm = 4 }
op1[0x18] = { name = "sbb r/m r8", modrm = true, imm = 0 }
op1[0x19] = { name = "sbb r/m r", modrm = true, imm = 0 }
op1[0x1A] = { name = "sbb r r/m8", modrm = true, imm = 0 }
op1[0x1B] = { name = "sbb r r/m", modrm = true, imm = 0 }
op1[0x1C] = { name = "sbb al imm8", modrm = false, imm = 1 }
op1[0x1D] = { name = "sbb ax imm", modrm = false, imm = 4 }
op1[0x20] = { name = "and r/m r8", modrm = true, imm = 0 }
op1[0x21] = { name = "and r/m r", modrm = true, imm = 0 }
op1[0x22] = { name = "and r r/m8", modrm = true, imm = 0 }
op1[0x23] = { name = "and r r/m", modrm = true, imm = 0 }
op1[0x24] = { name = "and al imm8", modrm = false, imm = 1 }
op1[0x25] = { name = "and ax imm", modrm = false, imm = 4 }
op1[0x28] = { name = "sub r/m r8", modrm = true, imm = 0 }
op1[0x29] = { name = "sub r/m r", modrm = true, imm = 0 }
op1[0x2A] = { name = "sub r r/m8", modrm = true, imm = 0 }
op1[0x2B] = { name = "sub r r/m", modrm = true, imm = 0 }
op1[0x2C] = { name = "sub al imm8", modrm = false, imm = 1 }
op1[0x2D] = { name = "sub ax imm", modrm = false, imm = 4 }
op1[0x30] = { name = "xor r/m r8", modrm = true, imm = 0 }
op1[0x31] = { name = "xor r/m r", modrm = true, imm = 0 }
op1[0x32] = { name = "xor r r/m8", modrm = true, imm = 0 }
op1[0x33] = { name = "xor r r/m", modrm = true, imm = 0 }
op1[0x34] = { name = "xor al imm8", modrm = false, imm = 1 }
op1[0x35] = { name = "xor ax imm", modrm = false, imm = 4 }
op1[0x38] = { name = "cmp r/m r8", modrm = true, imm = 0 }
op1[0x39] = { name = "cmp r/m r", modrm = true, imm = 0 }
op1[0x3A] = { name = "cmp r r/m8", modrm = true, imm = 0 }
op1[0x3B] = { name = "cmp r r/m", modrm = true, imm = 0 }
op1[0x3C] = { name = "cmp al imm8", modrm = false, imm = 1 }
op1[0x3D] = { name = "cmp ax imm", modrm = false, imm = 4 }
op1[0x50] = { name = "push rax", modrm = false, imm = 0 }
op1[0x51] = { name = "push rcx", modrm = false, imm = 0 }
op1[0x52] = { name = "push rdx", modrm = false, imm = 0 }
op1[0x53] = { name = "push rbx", modrm = false, imm = 0 }
op1[0x54] = { name = "push rsp", modrm = false, imm = 0 }
op1[0x55] = { name = "push rbp", modrm = false, imm = 0 }
op1[0x56] = { name = "push rsi", modrm = false, imm = 0 }
op1[0x57] = { name = "push rdi", modrm = false, imm = 0 }
op1[0x58] = { name = "pop rax", modrm = false, imm = 0 }
op1[0x59] = { name = "pop rcx", modrm = false, imm = 0 }
op1[0x5A] = { name = "pop rdx", modrm = false, imm = 0 }
op1[0x5B] = { name = "pop rbx", modrm = false, imm = 0 }
op1[0x5C] = { name = "pop rsp", modrm = false, imm = 0 }
op1[0x5D] = { name = "pop rbp", modrm = false, imm = 0 }
op1[0x5E] = { name = "pop rsi", modrm = false, imm = 0 }
op1[0x5F] = { name = "pop rdi", modrm = false, imm = 0 }
op1[0x63] = { name = "movsxd r r/m", modrm = true, imm = 0 }
op1[0x68] = { name = "push imm32", modrm = false, imm = 4 }
op1[0x6A] = { name = "push imm8", modrm = false, imm = 1 }
op1[0x70] = { name = "jo rel8", modrm = false, imm = 1 }
op1[0x71] = { name = "jno rel8", modrm = false, imm = 1 }
op1[0x72] = { name = "jb rel8", modrm = false, imm = 1 }
op1[0x73] = { name = "jnb rel8", modrm = false, imm = 1 }
op1[0x74] = { name = "je rel8", modrm = false, imm = 1 }
op1[0x75] = { name = "jne rel8", modrm = false, imm = 1 }
op1[0x76] = { name = "jbe rel8", modrm = false, imm = 1 }
op1[0x77] = { name = "ja rel8", modrm = false, imm = 1 }
op1[0x78] = { name = "js rel8", modrm = false, imm = 1 }
op1[0x79] = { name = "jns rel8", modrm = false, imm = 1 }
op1[0x7A] = { name = "jp rel8", modrm = false, imm = 1 }
op1[0x7B] = { name = "jnp rel8", modrm = false, imm = 1 }
op1[0x7C] = { name = "jl rel8", modrm = false, imm = 1 }
op1[0x7D] = { name = "jge rel8", modrm = false, imm = 1 }
op1[0x7E] = { name = "jle rel8", modrm = false, imm = 1 }
op1[0x7F] = { name = "jg rel8", modrm = false, imm = 1 }
op1[0x80] = { name = "alu r/m8 imm8", modrm = true, imm = 1, group = { "add", "or", "adc", "sbb", "and", "sub", "xor", "cmp" } }
op1[0x81] = { name = "alu r/m imm32", modrm = true, imm = 4, group = { "add", "or", "adc", "sbb", "and", "sub", "xor", "cmp" } }
op1[0x83] = { name = "alu r/m imm8", modrm = true, imm = 1, group = { "add", "or", "adc", "sbb", "and", "sub", "xor", "cmp" } }
op1[0x84] = { name = "test r/m r8", modrm = true, imm = 0 }
op1[0x85] = { name = "test r/m r", modrm = true, imm = 0 }
op1[0x86] = { name = "xchg r/m r8", modrm = true, imm = 0 }
op1[0x87] = { name = "xchg r/m r", modrm = true, imm = 0 }
op1[0x88] = { name = "mov r/m r8", modrm = true, imm = 0 }
op1[0x89] = { name = "mov r/m r", modrm = true, imm = 0 }
op1[0x8A] = { name = "mov r r/m8", modrm = true, imm = 0 }
op1[0x8B] = { name = "mov r r/m", modrm = true, imm = 0 }
op1[0x8D] = { name = "lea r r/m", modrm = true, imm = 0 }
op1[0x90] = { name = "nop", modrm = false, imm = 0 }
op1[0x99] = { name = "cdq/cqo", modrm = false, imm = 0 }
op1[0xA8] = { name = "test al imm8", modrm = false, imm = 1 }
op1[0xA9] = { name = "test ax imm", modrm = false, imm = 4 }
op1[0xB0] = { name = "mov al imm8", modrm = false, imm = 1 }
op1[0xB1] = { name = "mov cl imm8", modrm = false, imm = 1 }
op1[0xB2] = { name = "mov dl imm8", modrm = false, imm = 1 }
op1[0xB3] = { name = "mov bl imm8", modrm = false, imm = 1 }
op1[0xB4] = { name = "mov ah imm8", modrm = false, imm = 1 }
op1[0xB5] = { name = "mov ch imm8", modrm = false, imm = 1 }
op1[0xB6] = { name = "mov dh imm8", modrm = false, imm = 1 }
op1[0xB7] = { name = "mov bh imm8", modrm = false, imm = 1 }
op1[0xB8] = { name = "mov rax imm", modrm = false, imm = 4 }
op1[0xB9] = { name = "mov rcx imm", modrm = false, imm = 4 }
op1[0xBA] = { name = "mov rdx imm", modrm = false, imm = 4 }
op1[0xBB] = { name = "mov rbx imm", modrm = false, imm = 4 }
op1[0xBC] = { name = "mov rsp imm", modrm = false, imm = 4 }
op1[0xBD] = { name = "mov rbp imm", modrm = false, imm = 4 }
op1[0xBE] = { name = "mov rsi imm", modrm = false, imm = 4 }
op1[0xBF] = { name = "mov rdi imm", modrm = false, imm = 4 }
op1[0xC0] = { name = "shift r/m8 imm8", modrm = true, imm = 1, group = { "rol", "ror", "rcl", "rcr", "shl", "shr", nil, "sar" } }
op1[0xC1] = { name = "shift r/m imm8", modrm = true, imm = 1, group = { "rol", "ror", "rcl", "rcr", "shl", "shr", nil, "sar" } }
op1[0xC3] = { name = "ret", modrm = false, imm = 0 }
op1[0xC6] = { name = "mov r/m8 imm8", modrm = true, imm = 1 }
op1[0xC7] = { name = "mov r/m imm32", modrm = true, imm = 4 }
op1[0xC9] = { name = "leave", modrm = false, imm = 0 }
op1[0xD0] = { name = "shift r/m8 1", modrm = true, imm = 0, group = { "rol", "ror", "rcl", "rcr", "shl", "shr", nil, "sar" } }
op1[0xD1] = { name = "shift r/m 1", modrm = true, imm = 0, group = { "rol", "ror", "rcl", "rcr", "shl", "shr", nil, "sar" } }
op1[0xD2] = { name = "shift r/m8 cl", modrm = true, imm = 0, group = { "rol", "ror", "rcl", "rcr", "shl", "shr", nil, "sar" } }
op1[0xD3] = { name = "shift r/m cl", modrm = true, imm = 0, group = { "rol", "ror", "rcl", "rcr", "shl", "shr", nil, "sar" } }
op1[0xE8] = { name = "call rel32", modrm = false, imm = 4 }
op1[0xE9] = { name = "jmp rel32", modrm = false, imm = 4 }
op1[0xEB] = { name = "jmp rel8", modrm = false, imm = 1 }
op1[0xF4] = { name = "hlt", modrm = false, imm = 0 }
op1[0xF6] = { name = "alu r/m8", modrm = true, imm = 0, group = { "test", nil, "not", "neg", "mul", "imul", "div", "idiv" } }
op1[0xF7] = { name = "alu r/m", modrm = true, imm = 0, group = { "test", nil, "not", "neg", "mul", "imul", "div", "idiv" } }
op1[0xFE] = { name = "inc/dec r/m8", modrm = true, imm = 0, group = { "inc", "dec" } }
op1[0xFF] = { name = "inc/dec/call/jmp/push r/m", modrm = true, imm = 0, group = { "inc", "dec", "call", nil, "jmp", nil, "push" } }

-- two byte opcodes (0F prefix)
op2[0x05] = { name = "syscall", modrm = false, imm = 0 }
op2[0x1E] = { name = "endbr/nop", modrm = true, imm = 0 }
op2[0x1F] = { name = "nop", modrm = true, imm = 0 }
op2[0x40] = { name = "cmovo r r/m", modrm = true, imm = 0 }
op2[0x41] = { name = "cmovno r r/m", modrm = true, imm = 0 }
op2[0x42] = { name = "cmovb r r/m", modrm = true, imm = 0 }
op2[0x43] = { name = "cmovnb r r/m", modrm = true, imm = 0 }
op2[0x44] = { name = "cmove r r/m", modrm = true, imm = 0 }
op2[0x45] = { name = "cmovne r r/m", modrm = true, imm = 0 }
op2[0x46] = { name = "cmovbe r r/m", modrm = true, imm = 0 }
op2[0x47] = { name = "cmova r r/m", modrm = true, imm = 0 }
op2[0x48] = { name = "cmovs r r/m", modrm = true, imm = 0 }
op2[0x49] = { name = "cmovns r r/m", modrm = true, imm = 0 }
op2[0x4A] = { name = "cmovp r r/m", modrm = true, imm = 0 }
op2[0x4B] = { name = "cmovnp r r/m", modrm = true, imm = 0 }
op2[0x4C] = { name = "cmovl r r/m", modrm = true, imm = 0 }
op2[0x4D] = { name = "cmovge r r/m", modrm = true, imm = 0 }
op2[0x4E] = { name = "cmovle r r/m", modrm = true, imm = 0 }
op2[0x4F] = { name = "cmovg r r/m", modrm = true, imm = 0 }
op2[0x80] = { name = "jo rel32", modrm = false, imm = 4 }
op2[0x81] = { name = "jno rel32", modrm = false, imm = 4 }
op2[0x82] = { name = "jb rel32", modrm = false, imm = 4 }
op2[0x83] = { name = "jnb rel32", modrm = false, imm = 4 }
op2[0x84] = { name = "je rel32", modrm = false, imm = 4 }
op2[0x85] = { name = "jne rel32", modrm = false, imm = 4 }
op2[0x86] = { name = "jbe rel32", modrm = false, imm = 4 }
op2[0x87] = { name = "ja rel32", modrm = false, imm = 4 }
op2[0x88] = { name = "js rel32", modrm = false, imm = 4 }
op2[0x89] = { name = "jns rel32", modrm = false, imm = 4 }
op2[0x8A] = { name = "jp rel32", modrm = false, imm = 4 }
op2[0x8B] = { name = "jnp rel32", modrm = false, imm = 4 }
op2[0x8C] = { name = "jl rel32", modrm = false, imm = 4 }
op2[0x8D] = { name = "jge rel32", modrm = false, imm = 4 }
op2[0x8E] = { name = "jle rel32", modrm = false, imm = 4 }
op2[0x8F] = { name = "jg rel32", modrm = false, imm = 4 }
op2[0x90] = { name = "seto r/m8", modrm = true, imm = 0 }
op2[0x91] = { name = "setno r/m8", modrm = true, imm = 0 }
op2[0x92] = { name = "setb r/m8", modrm = true, imm = 0 }
op2[0x93] = { name = "setnb r/m8", modrm = true, imm = 0 }
op2[0x94] = { name = "sete r/m8", modrm = true, imm = 0 }
op2[0x95] = { name = "setne r/m8", modrm = true, imm = 0 }
op2[0x96] = { name = "setbe r/m8", modrm = true, imm = 0 }
op2[0x97] = { name = "seta r/m8", modrm = true, imm = 0 }
op2[0x98] = { name = "sets r/m8", modrm = true, imm = 0 }
op2[0x99] = { name = "setns r/m8", modrm = true, imm = 0 }
op2[0x9A] = { name = "setp r/m8", modrm = true, imm = 0 }
op2[0x9B] = { name = "setnp r/m8", modrm = true, imm = 0 }
op2[0x9C] = { name = "setl r/m8", modrm = true, imm = 0 }
op2[0x9D] = { name = "setge r/m8", modrm = true, imm = 0 }
op2[0x9E] = { name = "setle r/m8", modrm = true, imm = 0 }
op2[0x9F] = { name = "setg r/m8", modrm = true, imm = 0 }
op2[0xAF] = { name = "imul r r/m", modrm = true, imm = 0 }
op2[0xB6] = { name = "movzx r r/m8", modrm = true, imm = 0 }
op2[0xB7] = { name = "movzx r r/m16", modrm = true, imm = 0 }
op2[0xBE] = { name = "movsx r r/m8", modrm = true, imm = 0 }
op2[0xBF] = { name = "movsx r r/m16", modrm = true, imm = 0 }

return { op1 = op1, op2 = op2 }
