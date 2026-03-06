local clap = require("clap")

local args = clap.parse({ ... })

local commands = {
	help = require("rv.commands.help"),
	open = require("rv.commands.open"),
}

if args:flag("help") then
	return commands.help(args)
end

commands.open(args)
