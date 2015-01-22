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
    # represents a silkscreen arc inside a footprint
    #
    class ElementArc

        #
        # the default thickness for new instances
        #
        DEFAULT_THICKNESS = Coord.new 0.3, Coord::UNITS_MM


        #
        # the x coordinate of the center
        #
        attr_accessor :center_x


        #
        # the y coordinate of the center
        #
        attr_accessor :center_y


        #
        # the radius of the arc along the x axis
        #
        attr_accessor :radius_x


        #
        # the radius of the arc along the y axis
        #
        attr_accessor :radius_y


        #
        # the start angle of the arc, in degrees
        #
        # 0 degrees matches the negative x axis
        # 90 degrees matches the positive y axis
        #
        attr_accessor :start


        #
        # the sweep of the arc, in degrees
        #
        # positive angles sweep counterclockwise
        #
        attr_accessor :sweep


        #
        # the thickness of the line
        #
        attr_accessor :thickness


        #
        # create a new element arc with the following parameters in symbol
        # format
        #
        # [+:center_x+] the x coordinate of the center
        # [+:center_y+] the y coordinate of the center
        # [+:radius_x+] the radius of the arc along the x axis
        # [+:radius_y+] the radius of the arc along the y axis
        # [+:start+] the starting angle of the arc, in degrees - optional
        # [+:sweep+] the sweep of the arc, in degrees - optional
        # [+:thickness+] the thickness of the line - optional
        #
        def initialize params = {}

            @center_x = params[:center_x]
            @center_y = params[:center_y]
            @radius_x = params[:radius_x]
            @radius_y = params[:radius_y]
            @start = params[:start] || 0.0
            @sweep = params[:sweep] || 360.0
            @thickness = params[:thickness] || DEFAULT_THICKNESS
        end


        #
        # convert this element line to a string
        #
        def to_s

            "\tElementArc[#{@center_x} #{@center_y} #{@radius_x} "\
            "#{@radius_y} #{@start} #{@sweep} #{@thickness}]"
        end

    end

end
