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
    # represents a silkscreen line inside a footprint
    #
    class ElementLine

        #
        # the default thickness for new instances
        #
        DEFAULT_THICKNESS = Coord.new 0.3, Coord::UNITS_MM


        #
        # the x coordinate of the first point
        #
        attr_accessor :x0


        #
        # the y coordinate of the first point
        #
        attr_accessor :y0


        #
        # the x coordinate of the second point
        #
        attr_accessor :x1


        #
        # the y coordinate of the second point
        #
        attr_accessor :y1


        #
        # the thickness of the line
        #
        attr_accessor :thickness


        #
        # create a new element line with the given parameters in symbol format:
        #
        # [+:x0] the x coordinate of the first point
        # [+:y0] the y coordinate of the first point
        # [+:x1] the x coordinate of the second point
        # [+:y1] the y coordinate of the second point
        # [+:thickness] the thickness of the line
        #
        def initialize params = {}

            @x0 = params[:x0] || 0.0
            @y0 = params[:y0] || 0.0
            @x1 = params[:x1] || 0.0
            @y1 = params[:y1] || 0.0
            @thickness = params[:thickness] || DEFAULT_THICKNESS
        end


        #
        # calculate the extents of the silkscreen centerline
        #
        # returns a box
        #
        def extents

            x0, x1 = [@x0, @x1].minmax
            y0, y1 = [@y0, @y1].minmax
            return Box.new :x0 => x0, :y0 => y0, :x1 => x1, :y1 => y1
        end


        #
        # convert this element line to a string
        #
        def to_s

            "\tElementLine[#{@x0} #{@y0} #{@x1} #{@y1} #{@thickness}]"
        end

    end

end
