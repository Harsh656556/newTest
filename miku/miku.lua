require 'cairo'


function conky_miku_animation()
    if conky_window == nil then return end

    -- The "Pro" way: Use Conky's internal update counter
    -- This is much more stable than os.clock()
    local updates = tonumber(conky_parse("${updates}"))
    local frame = updates % 14  -- Cycles 0-13 automatically

    local image_path = os.getenv("HOME") .. "/.config/conky/miku/Images/f" .. frame .. ".png"
    -- Setup Cairo Surface
    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    local cr = cairo_create(cs)

    -- Draw the image
    local image = cairo_image_surface_create_from_png(image_path)
    cairo_set_source_surface(cr, image, 0, 0)
    cairo_paint(cr)

    -- Cleanup
    cairo_surface_destroy(image)
    cairo_destroy(cr)
    cairo_surface_destroy(cs)
end
-- script.lua
function my_mouse_handler(event)
    if event.type == "button_down" and event.button == 1 then
        os.execute("spotify &")
        return true
    end
    return false
end

