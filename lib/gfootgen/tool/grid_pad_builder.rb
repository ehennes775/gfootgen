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
    # creates pads for BGAs or PGAs
    #
    class GridPadBuilder < TerminalBuilder


        #
        # the letters used for row identification
        #
        LETTERS = "ABCDEFGHJKLMNPRTUVWY"


        #
        # the total number of pads along the x axis
        #
        attr_accessor :column_count


        #
        # the distance between pads, center to center
        #
        attr_accessor :pad_pitch


        #
        # the total number of pads along the y axis
        #
        attr_accessor :row_count


        #
        # initialize a new instance
        #
        def initialize terminal_factory

            super()

            @terminal_factory = terminal_factory

            @column_count = 16
            @row_count = 16
            @pad_pitch = Pcb::Coord.parse "100 mil"
        end


        #
        # create a new pin
        #
        # [column] the one based index of the column
        # [row] the one based index of the row
        #
        def create_pad column, row

            alpha_row = create_alpha_row row

            @terminal_factory.create_terminal "#{alpha_row}#{column}"
        end


        #
        # convert a numeric row number into an alphabetic representation
        #
        def create_alpha_row row

            value = row - 1

            result = LETTERS[value % LETTERS.length]
            value /= LETTERS.length

            while value > 0 do
                result.prepend LETTERS[value % LETTERS.length]
                value /= LETTERS.length
            end

            return result
        end


        #
        # generate the pads for the BGA
        #
        def generate_objects

            pads = []

            y0 = @pad_pitch * ((@row_count - 1) / -2.0)

            for rcount in 1..@row_count do

                x0 = @pad_pitch * ((@column_count - 1) / -2.0)

                for ccount in 1..@column_count do
                    pad = create_pad ccount, rcount
                    pad.translate x0, y0
                    pads << pad
                    x0 += @pad_pitch
                end

                y0 += @pad_pitch
            end

            return pads
        end

    end

end
