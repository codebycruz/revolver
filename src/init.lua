local clap = require("clap")

local args = clap.parse({ ... })

local commands = {
	help = require("revolver.commands.help"),
	open = require("revolver.commands.open"),
}

if args:flag("help") then
	return commands.help(args)
end

commands.open(args)
