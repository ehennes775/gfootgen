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
    # creates terminals
    #
    class DipPinBuilder < TerminalBuilder

        #
        # the total number of pins on the footprint
        #
        attr_accessor :pin_count


        #
        # the distance between pads in the same row, center-to-center
        #
        attr_accessor :pad_pitch


        #
        # the distance between the two rows, center-to-center
        #
        attr_accessor :pad_spacing


        #
        # initialize a new instance
        #
        def initialize terminal_factory

            super()

            @terminal_factory = terminal_factory

            @pin_count = 8
            @pad_pitch = Pcb::Coord.parse "100 mil"
            @pad_spacing = Pcb::Coord.parse "300 mil"
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
        # calculate the number of pins on the bottom side of the device
        #
        def bottom_pins

            0
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
        # calculate the number of pins on the left side of the footprint
        #
        def left_pins

            @pin_count - @pin_count / 2
        end


        #
        # calculate the number of pins on the right side of the footprint
        #
        def right_pins

            @pin_count - left_pins
        end

        #
        # calculate the number of pins on the top side of the device
        #
        def top_pins

            0
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
