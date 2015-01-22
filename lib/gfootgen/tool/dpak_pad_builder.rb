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
    class DpakPadBuilder < TerminalBuilder

        #
        # the total number of pins including the tab
        #
        attr_accessor :pin_count


        #
        # the distance between pads in the same row, center-to-center
        #
        attr_accessor :pad_pitch


        #
        # the distance between pads on the left and right, center-to-center
        #
        attr_accessor :pad_spacing


        #
        # initialize a new instance
        #
        def initialize params = {}

            super()

            @terminal_factory = params[:terminal_factory]

            @pin_count = 3
            @pad_pitch = Pcb::Coord.parse "5.08 mm"
            @pad_spacing = Pcb::Coord.parse "9.65 mm"
        end


        #
        # create a new pad
        #
        # [number] the pin number as a string
        #
        def create_pad number

            @terminal_factory.create_terminal number
        end


        #
        # generate the pads for the chip
        #
        def generate_objects

            pads = []

            left_pins = [@pin_count - 1, 0].max

            x0 = (@terminal_factory.pad_length - @terminal_factory.tab_length) / 4.0 - @pad_spacing / 2.0
            y0 = @pad_pitch * ((left_pins - 1) / -2.0)
            dy = @pad_pitch

            for number in 1..left_pins do
                pad = create_pad number.to_s
                pad.translate x0, y0
                pads << pad
                y0 += dy
            end

            x0 += @pad_spacing

            tab = @terminal_factory.create_tab (left_pins + 1).to_s
            tab.translate x0, Pcb::Coord.new

            pads << tab

            return pads
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
