# --
# gfootgen - Footprint Generator for PCB
# Copyright (C) 2015 Edward C Hennessy
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# ++

module Gui

    #
    #
    #
    class PadEditor < ParamEditor

        type_register

        PARAMS = [
            [:copper_diameter,        "Copper Diameter",               Pcb::Coord],
            [:drill_diameter,         "Drill Diameter",                Pcb::Coord],
            [:pad_length,             "Pad Length",                    Pcb::Coord],
            [:pad_width,              "Pad Width",                     Pcb::Coord],
            [:tab_length,             "Tab Length",                    Pcb::Coord],
            [:tab_width,              "Tab Width",                     Pcb::Coord],
            [:pad_spacing,            "Pad Spacing (BSC)",             Pcb::Coord],
            [:horizontal_pad_spacing, "Pad Spacing (BSC), Horizontal", Pcb::Coord],
            [:vertical_pad_spacing,   "Pad Spacing (BSC), Vertical",   Pcb::Coord],
            [:pad_pitch,              "Pad Pitch (BSC)",               Pcb::Coord],
            [:horizontal_pad_pitch,   "Pad Pitch (BSC), Horizontal",   Pcb::Coord],
            [:vertical_pad_pitch,     "Pad Pitch (BSC), Vertical",     Pcb::Coord],
            [:pin_count,              "Pin Count",                     Integer   ],
            [:left_right_pins,        "Left and Right Pin Count",      Integer   ],
            [:top_bottom_pins,        "Top and Bottom Pin Count",      Integer   ],
            [:clearance,              "Clearance",                     Pcb::Coord],
            [:soldermask_relief,      "Soldermask Relief",             Pcb::Coord]
            ]

        def initialize builder = nil

            super builder, PARAMS, "Layout Parameters"
        end

    end

end
