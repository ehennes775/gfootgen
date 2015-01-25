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
    # An outline that positions the circle at pin one
    #
    class PinOneCircleOutline < CircleOutline

        def initialize params = {}

            super
        end

        def calculate_center_y element, box, thickness

            element.objects.each do |object|
                if object.kind_of? Pcb::Terminal and object.number == "1" then
                    return object.center_y
                end
            end

            return super
        end

        def == other

            other.instance_of?(PinOneCircleOutline)
        end

    end

end
