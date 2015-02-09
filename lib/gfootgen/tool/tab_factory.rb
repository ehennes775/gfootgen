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
    # creates pads and tabs, for DPAK, D2PAK, SOT-223, etc...
    #
    class TabFactory < PadFactory

        #
        # the dimension of the tab on the x axis
        #
        attr_accessor :tab_length


        #
        # the dimension of the pad on the y axis
        #
        attr_accessor :tab_width


        #
        # initialize a new instance
        #
        def initialize params = {}

            super

            @tab_length = params[:tab_length] || Pcb::Coord::parse("2.5 mm")
            @tab_width = params[:tab_width] || Pcb::Coord.parse("1.7 mm")
        end


        #
        # create from a json object
        #
        def self.create_json o

            new(o_to_params(o))
        end


        #
        # create a tab
        #
        # [number] the pin number as a string
        #
        def create_tab number

            Pcb::Pad.new_lw(
                :length => @tab_length,
                :width => @tab_width,
                :clearance => @clearance,
                :soldermask_relief => @soldermask_relief,
                :number => number
                )

        end

        #
        # convert a json object into parameters for initialize
        #
        def self.o_to_params o

            h = super
            h[:tab_length] = Pcb::Coord.parse o["tab_length"]
            h[:tab_width]  = Pcb::Coord.parse o["tab_width"]
            h
        end

    end

end
