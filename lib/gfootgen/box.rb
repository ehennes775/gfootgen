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

#
# Stores an axis-aligned box
#
class Box

    #
    # the x coordinate of a corner of the box
    #
    attr_accessor :x0


    #
    # the y coordinate of a corner of the box
    #
    attr_accessor :y0


    #
    # the x coordinate of the opposite corner the box
    #
    attr_accessor :x1


    #
    # the y coordinate of the opposite corner the box
    #
    attr_accessor :y1


    #
    # Create a new box with the following parameters
    #
    # +:x0+ the x coordinate of one corner of the box
    # +:y0+ the y coordinate of one corner of the box
    # +:x1+ the x coordinate of the opposite corner of the box
    # +:y1+ the y coordinate of the opposite corner of the box
    #
    def initialize params = {}

        x0 = params[:x0] || 0.0
        y0 = params[:y0] || 0.0
        x1 = params[:x1] || 0.0
        y1 = params[:y1] || 0.0

        @x0, @x1 = [x0, x1].minmax
        @y0, @y1 = [y0, y1].minmax
    end


    #
    # Creates a larger box, using this box
    #
    # Returns a copy of this box, expanded on each side by the given amount.
    # The overall width and height of the box each increase by twice the given
    # amount.
    #
    def expand delta

        Box.new(
            :x0 => @x0 - delta,
            :y0 => @y0 - delta,
            :x1 => @x1 + delta,
            :y1 => @y1 + delta
            )
    end


    #
    # Calculates the union of zero or more boxes
    #
    # If no boxes are given, this function returns nil.
    #
    def self.union *boxes

        boxes.reduce(nil) do |extents, box|
            if extents.nil?
                box
            else
                x0, x1 = [extents.x0, extents.x1, box.x0, box.x1].minmax
                y0, y1 = [extents.y0, extents.y1, box.y0, box.y1].minmax
                Box.new :x0 => x0, :y0 => y0, :x1 => x1, :y1 => y1
            end
        end
    end

end
