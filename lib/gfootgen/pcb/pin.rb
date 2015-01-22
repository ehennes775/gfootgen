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

module Pcb

    #
    # represents a pcb through hole pin
    #
    class Pin < Terminal


        attr_accessor :center_y


        #
        # create a new instance
        #
        # [+:copper_diameter+]
        # [+:drill_diameter+]
        #
        def initialize params = {}

            super

            @center_x = Pcb::Coord.new
            @center_y = Pcb::Coord.new
            @copper_diameter = params[:copper_diameter]
            @drill_diameter = params[:drill_diameter]
        end


        #
        # calculate the extents of the copper pad
        #
        def extents

            box = Box.new(
                :x0 => @center_x,
                :y0 => @center_y,
                :x1 => @center_x,
                :y1 => @center_y
                )

            box.expand [@copper_diameter, @drill_diameter].max / 2.0
        end


        #
        # rotate the pad around the origin
        #
        # [angle] the angle to rotate, counterclockwise, in degrees
        #
        def rotate angle

            radians = Math::PI * angle / 180.0

            @center_x, @center_y =
                @center_x * Math::cos(radians) - @center_y * Math::sin(radians),
                @center_x * Math::sin(radians) + @center_y * Math::cos(radians)
        end


        #
        # convert the pin to a string
        #
        def to_s
            "\tPin["\
                "#{@center_x} "\
                "#{@center_y} "\
                "#{@copper_diameter} "\
                "#{@clearance} "\
                "#{@copper_diameter + @soldermask_relief * 2.0} "\
                "#{@drill_diameter} "\
                "\"#{@number}\" "\
                "\"#{@number}\" "\
                "\"\"]"
        end


        #
        # translate the pin by the given displacement
        #
        def translate dx, dy

            @center_x += dx
            @center_y += dy
        end

    end

end
