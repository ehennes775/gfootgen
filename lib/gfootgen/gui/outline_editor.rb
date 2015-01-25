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
    class OutlineEditor < ParamEditor

        type_register

        PARAMS = [
            [
                :silkscreen_package_offset,
                "Silkscreen Package Offset",
                "The additional distance from the edge of the package to the inner edge of the silkscreen.",
                Pcb::Coord
                ],
            [
                :silkscreen_pad_offset,
                "Silkscreen Pad Offset",
                "The additional distance from the edge of the copper pad to the inner edge of the silkscreen.",
                Pcb::Coord
                ],
            [
                :silkscreen_thickness,
                "Silkscreen Thickness",
                "The silkscreen line thickness.",
                Pcb::Coord
                ],
            [
                :silkscreen_outline,
                "Silkscreen Outline",
                nil,
                Tool::Outline
                ],
            [
                :label_offset,
                "Label Offset",
                "The dimension between the centerline of the silkscreen border to the insertion point of the label text.",
                Pcb::Coord
                ]
            ]


        def initialize builder = nil

            super builder, PARAMS, "Silkscreen Parameters"
        end

    end

end
