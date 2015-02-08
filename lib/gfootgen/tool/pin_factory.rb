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
    # creates through-hole pins
    #
    class PinFactory < TerminalFactory

        DEFAULT_COPPER_DIAMETER = Pcb::Coord.parse "70 mil"

        DEFAULT_DRILL_DIAMETER = Pcb::Coord.parse "40 mil"

        attr_accessor :copper_diameter

        attr_accessor :drill_diameter

        #
        # initialize a new instance
        #
        def initialize params = {}

            super

            @copper_diameter = params[:copper_diameter] || DEFAULT_COPPER_DIAMETER
            @drill_diameter = params[:drill_diameter] || DEFAULT_DRILL_DIAMETER
        end


        #
        # create from a json object
        #
        def self.create_json o

            new(o_to_params(o))
        end


        #
        # create a pin
        #
        # [number] the pin number as a string
        #
        def create_terminal number

            Pcb::Pin.new(
                :copper_diameter => @copper_diameter,
                :clearance => @clearance,
                :soldermask_relief => @soldermask_relief,
                :drill_diameter => @drill_diameter,
                :number => number
                )

        end


        #
        # convert a json object into parameters for initialize
        #
        def self.o_to_params o

            h = super
            h[:copper_diameter] = Pcb::Coord.parse o["copper_diameter"]
            h[:drill_diameter]  = Pcb::Coord.parse o["drill_diameter"]
            h
        end


        #
        # convert to a hash
        #
        def to_h

            h = super
            h[:copper_diameter] = @copper_diameter
            h[:drill_diameter]  = @drill_diameter
            h
        end

    end

end
