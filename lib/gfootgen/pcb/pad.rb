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
    # represents a pcb surface mount pad
    #
    class Pad < Terminal

        #
        # create a new instance using center, length and width
        #
        # [+:length+] the length of the pad - x axis
        # [+:width+] the width of the pad - y axis
        # [+:clearance+] the clearance - copper-to-copper
        # [+:soldermask_relief+] the soldermask relief
        # [+:number+] the pin number
        #
        def self.new_lw params = {}

            aperture = [params[:length], params[:width]].min

            x0 = (params[:length] - aperture) / -2.0
            y0 = (params[:width] - aperture) / -2.0
            x1 = (params[:length] - aperture) / 2.0
            y1 = (params[:width] - aperture) / 2.0

            return Pad.new(
                :x0 => x0,
                :y0 => y0,
                :x1 => x1,
                :y1 => y1,
                :aperture => aperture,
                :clearance => params[:clearance],
                :soldermask_relief => params[:soldermask_relief],
                :number => params[:number],
                :square => params[:square].nil? ? true : params[:square]
                )
        end


        #
        # create a new instance using two points and aperture
        #
        # [+:x0+] the x coordinate of the first point
        # [+:y0+] the y coordinate of the first point
        # [+:x1+] the x coordinate of the second point
        # [+:y1+] the y coordinate of the second point
        # [+:aperture+] the pad aperture
        # [+:number+] the pin number
        #
        def initialize params = {}

            super

            @x0 = params[:x0] || 0.0
            @y0 = params[:y0] || 0.0
            @x1 = params[:x1] || 0.0
            @y1 = params[:y1] || 0.0
            @aperture = params[:aperture] || 1.0
            @square = params[:square].nil? ? true : params[:square]
        end


        #
        # calculate the center y coordinate
        #
        def center_y
            return (@y0 + @y1) / 2.0
        end


        #
        # calculate the extents of the copper pad
        #
        def extents

            x0, x1 = [@x0, @x1].minmax
            y0, y1 = [@y0, @y1].minmax

            box = Box.new :x0 => x0, :y0 => y0, :x1 => x1, :y1 => y1

            box.expand @aperture / 2.0
        end


        #
        # rotate the pad around the origin
        #
        # [angle] the angle to rotate, counterclockwise, in degrees
        #
        def rotate angle

            radians = Math::PI * angle / 180.0

            @x0, @y0 =
                @x0 * Math::cos(radians) - @y0 * Math::sin(radians),
                @x0 * Math::sin(radians) + @y0 * Math::cos(radians)

            @x1, @y1 =
                @x1 * Math::cos(radians) - @y1 * Math::sin(radians),
                @x1 * Math::sin(radians) + @y1 * Math::cos(radians)
        end


        #
        # convert the pad to a string
        #
        def to_s
            "\tPad["\
                "#{@x0} "\
                "#{@y0} "\
                "#{@x1} "\
                "#{@y1} "\
                "#{@aperture} "\
                "#{@clearance * 2.0} "\
                " #{@aperture + @soldermask_relief * 2.0} "\
                "\"#{@number}\" "\
                "\"#{@number}\" "\
                "\"#{@square ? "square" : ""}\""\
                "]"
        end


        #
        # translate the pad by the given displacement
        #
        def translate dx, dy

            @x0 += dx
            @y0 += dy
            @x1 += dx
            @y1 += dy
        end

    end

end
