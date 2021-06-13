-- data:extend(
--   {
--     {
--       type = "font",
--       name = "fatcontroller_small",
--       parent = "default",
--       from = "default",
--     },
--   })

data.raw["gui-style"].default["fatcontroller_thin_flow"] = {
    type = "vertical_flow_style",
    vertical_spacing = 0,
}

data.raw["gui-style"].default["fatcontroller_thin_frame"] = {
    type = "frame_style",
    parent = "frame",
    top_padding = 2,
    bottom_padding = 2,
    horizontally_stretchable = "on"
}

data.raw["gui-style"].default["fatcontroller_main_flow_vertical"] = {
    type = "vertical_flow_style",
    top_padding = 0,
    bottom_padding = 0,
    left_padding = 5,
    right_padding = 5,
    vertical_spacing = 0,
}
data.raw["gui-style"].default["fatcontroller_main_flow_horizontal"] = {
    type = "horizontal_flow_style",
    top_padding = 0,
    bottom_padding = 0,
    left_padding = 5,
    right_padding = 5,
    horizontal_spacing = 0,
}

data.raw["gui-style"].default["fatcontroller_top_flow"] = {
    type = "horizontal_flow_style",
    parent = "fatcontroller_main_flow_horizontal",
    top_padding = 0,
    left_padding = 0
}

data.raw["gui-style"].default["fatcontroller_button_flow_horizontal"] = {
    type = "horizontal_flow_style",
    parent = "horizontal_flow",
    horizontal_spacing = 1
}

data.raw["gui-style"].default["fatcontroller_traininfo_button_flow_horizontal"] = {
    type = "horizontal_flow_style",
    parent = "fatcontroller_button_flow_horizontal",
    top_padding = 4
}

data.raw["gui-style"].default["fatcontroller_button_style"] = {
    type = "button_style",
    parent = "button",
    right_padding = 5,
    left_padding = 5
}
data.raw["gui-style"].default["fatcontroller_sprite_button_style"] = {
    type = "button_style",
    parent = "fatcontroller_button_style",
    width = 36,
    height = 36,
    right_padding = 0,
    left_padding = 0
}
data.raw["gui-style"].default["fatcontroller_indicator_style"] = {
    type = "progressbar_style",
    --parent = "progressbar",
    bar_width = 36,
    bar = {
        filename = "__core__/graphics/gui.png",
        position = {221, 0},
        size = {1, 1},
        scale = 1
    },
    bar_background = {
        filename = "__core__/graphics/gui.png",
        position = {225, 0},
        size = {1, 13},
        scale = 1
    },
    width = 14,
    height = 35,
    right_padding = 0,
    left_padding = 0,
    bottom_padding = 2
}

data.raw["gui-style"].default["fatcontroller_main_button_style"] = {
    type = "button_style",
    parent = "mod_gui_button"
}

data.raw["gui-style"].default["fatcontroller_disabled_button"] = {
    type = "button_style",
    parent = "fatcontroller_button_style",
    default_font_color = {r = 0.34, g = 0.34, b = 0.34},
    hovered_font_color = {r = 0.34, g = 0.34, b = 0.38},
    hovered_graphical_set = {
        type = "composition",
        filename = "__core__/graphics/gui.png",
        corner_size = {3, 3},
        position = {0, 0}
    },
    clicked_font_color = {r = 0.34, g = 0.34, b = 0.38},
    clicked_graphical_set = {
        type = "composition",
        filename = "__core__/graphics/gui.png",
        corner_size = {3, 3},
        position = {0, 0}
    }
}

data.raw["gui-style"].default["fatcontroller_selected_button"] = {
    type = "button_style",
    parent = "fatcontroller_button_style",
    default_graphical_set = {
        type = "composition",
        filename = "__core__/graphics/gui.png",
        corner_size = {3, 3},
        position = {0, 8}
    },
    hovered_font_color = {r = 1, g = 1, b = 1},
    hovered_graphical_set = {
        type = "composition",
        filename = "__core__/graphics/gui.png",
        corner_size = {3, 3},
        position = {0, 16}
    },
    clicked_graphical_set = {
        type = "composition",
        filename = "__core__/graphics/gui.png",
        corner_size = {3, 3},
        position = {0, 0}
    }
}

data.raw["gui-style"].default["fatcontroller_button_style_bold"] = {
    type = "button_style",
    parent = "button"
}

data.raw["gui-style"].default["fatcontroller_disabled_button_bold"] = {
    type = "button_style",
    parent = "fatcontroller_disabled_button",
    font = "default-semibold",
    default_font_color = {r = 0.5, g = 0.5, b = 0.5},
    hovered_font_color = {r = 0.5, g = 0.5, b = 0.5}
}

data.raw["gui-style"].default["fatcontroller_page_button"] = {
    type = "button_style",
    parent = "fatcontroller_button_style_bold",
    width = 25,
    height = 36,
    left_padding = 0,
    right_padding = 0,
    vertically_stretchable = "on"
}

data.raw["gui-style"].default["fatcontroller_pagenumber_button"] = {
    type = "button_style",
    parent = "fatcontroller_page_button",
    width = 46
}

data.raw["gui-style"].default["fatcontroller_page_button_selected"] = {
    type = "button_style",
    parent = "fatcontroller_selected_button",
    width = 25,
    height = 36,
    left_padding = 0,
    right_padding = 0,
    vertically_stretchable = "on"
}

data.raw["gui-style"].default["fatcontroller_label_style"] = {
    type = "label_style",
    parent = "label"
}

data.raw["gui-style"].default["fatcontroller_label_style_small"] = {
    type = "label_style",
    parent = "fatcontroller_label_style"
}

data.raw["gui-style"].default["fatcontroller_textfield_small"] = {
    type = "textbox_style",
    parent = "short_number_textfield",
    horizontal_align = "center"
}

data.raw["gui-style"].default["fatcontroller_icon_style"] = {
    type = "checkbox_style",
    parent = "checkbox",
    width = 32,
    height = 32,
    bottom_padding = 10,
}

data:extend({
    {
        type = "sprite",
        name = "fat_return_to_player",
        filename = "__TheFatController__/graphics/guiPlayer.png",
        priority = "extra-high-no-scale",
        width = 128,
        height = 128
    }
})

data:extend({
    {
        type = "sprite",
        name = "fat_timeAtSignal",
        filename = "__TheFatController__/graphics/icons/timeAtSignal.png",
        priority = "extra-high-no-scale",
        width = 32,
        height = 32
    }
})

data:extend({
    {
        type = "sprite",
        name = "fat_timeToStation",
        filename = "__TheFatController__/graphics/icons/timeToStation.png",
        priority = "extra-high-no-scale",
        width = 32,
        height = 32
    }
})

data:extend({
    {
        type = "sprite",
        name = "fat_noPath",
        filename = "__core__/graphics/icons/alerts/danger-icon.png",
        priority = "extra-high-no-scale",
        width = 64,
        height = 64
    }
})

data:extend({
    {
        type = "sprite",
        name = "fat_noFuel",
        filename = "__core__/graphics/icons/alerts/fuel-icon-red.png",
        priority = "extra-high-no-scale",
        width = 64,
        height = 64
    }
})
