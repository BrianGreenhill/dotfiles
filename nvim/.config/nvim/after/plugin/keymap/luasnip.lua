local Remap = require("greenhill.keymap")
local inoremap = Remap.inoremap
local snoremap = Remap.snoremap

local ls = require("luasnip")

local expand_or_jumpable = function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end

local jumpable = function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end

-- <c-k> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
inoremap("<c-k>", function()
	expand_or_jumpable()
end)
snoremap("<c-k>", function()
	expand_or_jumpable()
end)

-- <c-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
inoremap("<c-k>", function()
	jumpable()
end)
snoremap("<c-k>", function()
	jumpable()
end)
