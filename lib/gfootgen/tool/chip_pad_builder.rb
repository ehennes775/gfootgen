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
    #
    #
    class ChipPadBuilder < TerminalBuilder

        #
        # the spacing between the pads on the x axis - center to center
        #
        attr_accessor :pad_spacing


        #
        # create a new instance
        #
        def initialize terminal_factory

            super()

            @terminal_factory = terminal_factory

            @pad_pitch = Pcb::Coord.new
            @pad_spacing = Pcb::Coord.parse("4.0 mm")
        end


        #
        # create a new pin
        #
        # [number] the pin number as a string
        #
        def create_pad number

            @terminal_factory.create_terminal number
        end


        #
        # calculate pitch between pads on the top and bottom of the footprint
        #
        # the i suffix ensures that this function is not seen with
        # introspection
        #
        def horizontal_pad_pitch_i

            @pad_pitch
        end


        #
        # calculate spacing between pads on the left and right of the footprint
        #
        # the i suffix ensures that this function is not seen with
        # introspection
        #
        def horizontal_pad_spacing_i

            @pad_spacing
        end


        #
        # calculate the number of pins on the left side of the device
        #
        def left_pins

            1
        end


        #
        # calculate the number of pins on the right side of the device
        #
        def right_pins

            1
        end


        #
        # calculate pitch between pins on the left and right side of the
        # footprint
        #
        # the i suffix ensures that this function is not seen with
        # introspection
        #
        def vertical_pad_pitch_i

            @pad_pitch
        end


        #
        # calculate spacing between pads on the top and bottom of the footprint
        #
        # the i suffix ensures that this function is not seen with
        # introspection
        #
        def vertical_pad_spacing_i

            @pad_spacing
        end

    end

end
