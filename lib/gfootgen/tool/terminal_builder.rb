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
    class TerminalBuilder

        #
        # create a new instance
        #
        def initialize params = {}
        end


        #
        # generate the pads for the chip
        #
        def generate_objects

            pads = []

            pin_number = 1

            # create pins on the left side of the footprint

            x0 = horizontal_pad_spacing_i / -2.0
            y0 = vertical_pad_pitch_i * ((left_pins - 1) / -2.0)

            for count in 1..left_pins do
                pad = create_pad pin_number.to_s
                pad.translate x0, y0
                pads << pad
                y0 += vertical_pad_pitch_i
                pin_number += 1
            end

            # create pins on the bottom side of the footprint

            x0 = horizontal_pad_pitch_i * ((top_pins - 1) / -2.0)
            y0 = vertical_pad_spacing_i / 2.0

            for count in 1..bottom_pins do
                pad = create_pad pin_number.to_s
                pad.rotate 90
                pad.translate x0, y0
                pads << pad
                x0 += horizontal_pad_pitch_i
                pin_number += 1
            end

            # create pins on the right side of the footprint

            x0 = horizontal_pad_spacing_i / 2.0
            y0 = vertical_pad_pitch_i * ((right_pins - 1) / 2.0)

            for count in 1..right_pins do
                pad = create_pad pin_number.to_s
                pad.rotate 180
                pad.translate x0, y0
                pads << pad
                y0 -= vertical_pad_pitch_i
                pin_number += 1
            end

            # create pins on the top side of the footprint

            x0 = horizontal_pad_pitch_i * ((top_pins - 1) / 2.0)
            y0 = vertical_pad_spacing_i / -2.0

            for count in 1..top_pins do
                pad = create_pad pin_number.to_s
                pad.rotate 270
                pad.translate x0, y0
                pads << pad
                x0 -= horizontal_pad_pitch_i
                pin_number += 1
            end

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
