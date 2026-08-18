local _ = require("gettext")
local WidgetContainer = require("ui/widget/container/widgetcontainer")
local UIManager = require("ui/uimanager")
local InfoMessage = require("ui/widget/infomessage")
local logger = require("logger")

local ObsidianExporter = WidgetContainer:extend({
	name = "obsidianexporter",
})

local HOME = os.getenv("HOME") or "/root"
local PYTHON = HOME .. "/Projects/vocab-tools/.venv/bin/python"
local CREATE_SCRIPT = HOME .. "/Projects/vocab-tools/word_to_obsidian.py"

function ObsidianExporter:init()
	-- "12_" is just a sort-order prefix among the other highlight buttons
	self.ui.highlight:addToHighlightDialog("12_to_obsidian", function(highlight_instance)
		return {
			text = _("To Obsidian"),
			callback = function()
				self:exportWord(highlight_instance.selected_text.text)
				highlight_instance:onClose()
			end,
		}
	end)
end

function ObsidianExporter:exportWord(text)
	local clean = text:gsub("^%s+", ""):gsub("%s+$", ""):gsub('"', '\\"')
	local cmd = string.format('"%s" "%s" "%s" &', PYTHON, CREATE_SCRIPT, clean)
	local ok = os.execute(cmd)
	logger.dbg("ObsidianExporter: ran", cmd, "->", ok)
	UIManager:show(InfoMessage:new({
		text = _("Exported: ") .. clean,
		timeout = 2,
	}))
end

return ObsidianExporter
