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
    # creates terminals for dual-in-line surface mount footprints
    #
    class QuadPadBuilder < TerminalBuilder

        #
        # the number of pins on the left and right side of the footprint
        #
        attr_accessor :left_right_pins


        #
        # the distance between pads in the same row, center-to-center, on the
        # left and right sides of the footprint
        #
        attr_accessor :horizontal_pad_pitch


        #
        # the distance between left and right rows, center-to-center
        #
        attr_accessor :horizontal_pad_spacing


        #
        # the number of pins on the left and right side of the footprint
        #
        attr_accessor :top_bottom_pins


        #
        # the distance between pads in the same row, center-to-center, on the
        # top and bottom of the footprint
        #
        attr_accessor :vertical_pad_pitch


        #
        # the distance between top and bottom rows, center-to-center
        #
        attr_accessor :vertical_pad_spacing


        #
        # initialize a new instance
        #
        def initialize terminal_factory

            super()

            @terminal_factory = terminal_factory

            @horizontal_pad_pitch = Pcb::Coord.parse "1.27 mm"
            @vertical_pad_pitch = Pcb::Coord.parse "1.27 mm"

            @horizontal_pad_spacing = Pcb::Coord.parse "8.765 mm"
            @vertical_pad_spacing = Pcb::Coord.parse "8.765 mm"

            @left_right_pins = 5
            @top_bottom_pins = 5

            @pad_spacing = Pcb::Coord.parse "5.6 mm"

            @pad_length = Pcb::Coord.parse "2.035 mm"
            @pad_width = Pcb::Coord.parse "0.63 mm"
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

            @top_bottom_pins
        end


        #
        # calculate pitch between pads on the top and bottom of the footprint
        #
        # the i suffix ensures that this function is not seen with
        # introspection
        #
        def horizontal_pad_pitch_i

            @horizontal_pad_pitch
        end


        #
        # calculate spacing between pads on the left and right of the footprint
        #
        # the i suffix ensures that this function is not seen with
        # introspection
        #
        def horizontal_pad_spacing_i

            @horizontal_pad_spacing
        end


        #
        # calculate the number of pins on the left side of the device
        #
        def left_pins

            @left_right_pins
        end


        #
        # calculate the number of pins on the right side of the device
        #
        def right_pins

            @left_right_pins
        end


        #
        # calculate the number of pins on the top side of the device
        #
        def top_pins

            @top_bottom_pins
        end


        #
        # calculate pitch between pins on the left and right side of the
        # footprint
        #
        # the i suffix ensures that this function is not seen with
        # introspection
        #
        def vertical_pad_pitch_i

            @vertical_pad_pitch
        end


        #
        # calculate spacing between pads on the top and bottom of the footprint
        #
        # the i suffix ensures that this function is not seen with
        # introspection
        #
        def vertical_pad_spacing_i

            @vertical_pad_spacing
        end

    end

end
