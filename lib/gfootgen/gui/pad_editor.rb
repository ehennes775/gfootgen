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
            [
                :pad_spacing,
                "Pad Spacing (BSC)",
                "The dimension between pads on opposite rows, center-to-center",
                Pcb::Coord
                ],
            [
                :horizontal_pad_spacing,
                "Pad Spacing (BSC), Horizontal",
                "The dimension between pads in left and right rows, center-to-center",
                Pcb::Coord
                ],
            [
                :vertical_pad_spacing,
                "Pad Spacing (BSC), Vertical",
                "The dimension between pads in top and bottom rows, center-to-center",
                Pcb::Coord
                ],
            [
                :pad_pitch,
                "Pad Pitch (BSC)",
                "The dimension between pads in the same row, center-to-center",
                Pcb::Coord
                ],
            [
                :horizontal_pad_pitch,
                "Pad Pitch (BSC), Horizontal",
                "The dimension between pads in the same left or right row, center-to-center",
                Pcb::Coord
                ],
            [
                :vertical_pad_pitch,
                "Pad Pitch (BSC), Vertical",
                "The dimension between pads in the same top or bottom row, center-to-center",
                Pcb::Coord
                ],
            [
                :pin_count,
                "Pin Count",
                "The total number of pads/pins on the footprint",
                Integer
                ],
            [
                :left_right_pins,
                "Left and Right Pin Count",
                "The number of pins on the left or right side of the footprint",
                Integer
                ],
            [
                :top_bottom_pins,
                "Top and Bottom Pin Count",
                "The number of pins on the top or bottom of the footprint",
                Integer
                ]
            ]


        def initialize builder = nil

            super builder, PARAMS, "Layout Parameters"
        end

    end

end
