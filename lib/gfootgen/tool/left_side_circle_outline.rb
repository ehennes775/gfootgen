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

    #
    # An outline that positions the circle somewhere along the left side
    #
    class LeftSideCircleOutline < CircleOutline

        attr_accessor :position

        def initialize params = {}
            super
            @position = params[:position] || 0.5
        end


        def calculate_center_y element, box, thickness
            top_y = box.y0 + thickness * 1.0
            bottom_y = box.y1 - thickness * 1.0

            return (bottom_y - top_y) * @position + top_y
        end

        def == other

            other.instance_of?(LeftSideCircleOutline) && @position == other.position
        end

    end

end
