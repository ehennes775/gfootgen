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
    # provides an editor for pads and pins
    #
    class TerminalEditor < ParamEditor

        type_register

        PARAMS = [
            [
                :pad_length,
                "Pad Length",
                "The dimension of the pads on the x axis",
                Pcb::Coord
                ],
            [
                :pad_width,
                "Pad Width",
                "The dimension of the pads on the y axis",
                Pcb::Coord
                ],
            [
                :tab_length,
                "Tab Length",
                "The dimension of the tab on the x axis",
                Pcb::Coord
                ],
            [
                :tab_width,
                "Tab Width",
                "The dimension of the tab on the y axis",
                Pcb::Coord
                ],
            [
                :copper_diameter,
                "Copper Diameter",
                "The diameter of the copper pad on through-hole pins",
                Pcb::Coord
                ],
            [
                :drill_diameter,
                "Drill Diameter",
                "The diameter of the drill on through-hole pins",
                Pcb::Coord
                ],
            [
                :clearance,
                "Clearance",
                "The minimum dimension from copper pad to adjacent copper",
                Pcb::Coord
                ],
            [
                :soldermask_relief,
                "Soldermask Relief",
                "The dimension from copper pad to soldermask opening",
                Pcb::Coord
                ]
            ]


        def initialize title = "Pad/Pin Parameters"

            super nil, PARAMS, title
        end

    end

end
