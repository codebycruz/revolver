# revolver

Revolver is an incredibly minimal reverse engineering tool written in LuaJIT.

It implements a simple ELF parser to read the text section of a binary, alongside an incredibly simple x86 disassembler to print out assembly.

[It is using the `lpm` package manager.](https://github.com/codebycruz/lpm)

## Support

- [x] Linux x86-64

## Usage

This will install it as a tool named `rv` in your PATH.

```sh
lpm install --git https://github.com/codebycruz/revolver
```
