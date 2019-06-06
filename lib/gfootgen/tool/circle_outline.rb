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

    # base class for outlines that create a circle
    class CircleOutline < Outline

        type_register

        BOX_OUTLINE = BoxOutline.new :extend => 0.0, :polarity => false

        def initialize params = {}
            super()
        end

        def calculate_center_y element, box, thickness
            return Pcb::Coord.new 0.0
        end

        def generate element, box, thickness

            BOX_OUTLINE.generate(element, box, thickness) do |object|
                yield object
            end

            center_x = box.x0 - thickness * 3.0
            center_y = self.calculate_center_y element, box, thickness

            yield Pcb::ElementArc.new(
                :center_x  => center_x,
                :center_y  => center_y,
                :radius_x  => thickness,
                :radius_y  => thickness,
                :start     => 0,
                :sweep     => 360,
                :thickness => thickness
                )
        end

    end

end
