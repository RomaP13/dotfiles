-- Stop swayimg from trying to auto-float or override geometry
-- (This forces it to behave like a standard tiling Sway window)
swayimg.enable_overlay(false)

-- Fix the resize crash: Only call viewer scaling if viewer mode is active
swayimg.on_window_resize(function()
	if swayimg.get_mode() == "viewer" then
		swayimg.viewer.set_fix_scale("optimal")
	end
end)

-- 'Return' (Enter): Print path to stdout and close immediately
swayimg.gallery.on_key("Return", function()
	local image = swayimg.gallery.get_image()
	if image then
		print(image.path)
	end
	swayimg.exit()
end)

-- Bind Escape/q to exit out of gallery mode cleanly without selecting anything
swayimg.gallery.on_key("Escape", function()
	swayimg.exit()
end)

swayimg.gallery.on_key("q", function()
	swayimg.exit()
end)

swayimg.viewer.on_key("Escape", function()
	swayimg.exit()
end)

swayimg.viewer.on_key("q", function()
	swayimg.exit()
end)
