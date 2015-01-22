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

module Tool

    # An outline that creates a semicircle notch at the top
    class NotchOutline < Outline

        attr_accessor :diameter

        def initialize params = {}

            super()

            @diameter = Pcb::Coord.parse "1.5 mm"
        end

        def generate element, box, thickness

            #top left side
            yield Pcb::ElementLine.new(
                :x0 => box.x0,
                :y0 => box.y0,
                :x1 => (box.x0 + box.x1 - @diameter) / 2.0,
                :y1 => box.y0,
                :thickness => thickness
                )

            yield Pcb::ElementArc.new(
                :center_x => (box.x0 + box.x1) / 2.0,
                :center_y => box.y0,
                :radius_x => @diameter / 2.0,
                :radius_y => @diameter / 2.0,
                :start => 0.0,
                :sweep => 180.0,
                :thickness => thickness
                )

            #top right side
            yield Pcb::ElementLine.new(
                :x0 => (box.x0 + box.x1 + @diameter) / 2.0,
                :y0 => box.y0,
                :x1 => box.x1,
                :y1 => box.y0,
                :thickness => thickness
                )

            #right side
            yield Pcb::ElementLine.new(
                :x0 => box.x1,
                :y0 => box.y0,
                :x1 => box.x1,
                :y1 => box.y1,
                :thickness => thickness
                )

            #bottom side
            yield Pcb::ElementLine.new(
                :x0 => box.x1,
                :y0 => box.y1,
                :x1 => box.x0,
                :y1 => box.y1,
                :thickness => thickness
                )

            #left side
            yield Pcb::ElementLine.new(
                :x0 => box.x0,
                :y0 => box.y1,
                :x1 => box.x0,
                :y1 => box.y0,
                :thickness => thickness
                )

        end

        def == other

            other.instance_of?(NotchOutline) && @diameter == other.diameter
        end

    end

end
