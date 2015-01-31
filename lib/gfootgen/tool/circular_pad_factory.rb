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
    # creates circular pads
    #
    class CircularPadFactory < TerminalFactory

        #
        # the dimension of the pad on the x axis
        #
        attr_accessor :pad_diameter


        #
        # initialize a new instance
        #
        def initialize params = {}

            super

            @pad_diameter = params[:pad_diameter] || Pcb::Coord::parse("2.5 mm")
        end


        #
        # create a pad
        #
        # [number] the pin number as a string
        #
        def create_terminal number

            Pcb::Pad.new_lw(
                :length => @pad_diameter,
                :width => @pad_diameter,
                :clearance => @clearance,
                :soldermask_relief => @soldermask_relief,
                :number => number,
                :square => false
                )
        end

    end

end
