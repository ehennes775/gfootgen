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
    # a pcb coordinte
    #
    class Coord

        include Comparable


        #
        # raised when there is an error parsing a coordinate
        #
        class ParseError < RuntimeError
        end


        #
        # the number of digits to round floating point numbers for string
        # conversion
        #
        ROUND_DIGITS = 10


        #
        # the string for specifying inch units
        #
        UNITS_IN = "in"


        #
        # the string for specifying mil units
        #
        UNITS_MIL = "mil"


        #
        # the string for specifying mm units
        #
        UNITS_MM = "mm"


        #
        #
        #
        def self.create_key from, to
            "#{from}->#{to}"
        end


        #
        # a table for converting from one units to another
        #
        CONVERSION_TABLE = {
            create_key(UNITS_IN,  UNITS_IN ) => 1.0,
            create_key(UNITS_MIL, UNITS_MIL) => 1.0,
            create_key(UNITS_MM,  UNITS_MM ) => 1.0,
            create_key(UNITS_IN,  UNITS_MIL) => 1000.0,
            create_key(UNITS_IN,  UNITS_MM)  => 25.4,
            create_key(UNITS_MM,  UNITS_IN ) => 1.0 / 25.4,
            create_key(UNITS_MM,  UNITS_MIL) => 1.0 / 0.0254,
            create_key(UNITS_MIL, UNITS_IN)  => 1.0 / 1000.0,
            create_key(UNITS_MIL, UNITS_MM)  => 0.0254
            }


        #
        # a string containing the units for this coordinate
        #
        attr_accessor :units


        #
        # a numeric type containing the value of this coordinate
        #
        attr_accessor :value


        #
        # create a new instance
        #
        def initialize value = 0.0, units = UNITS_MM

            @value = value
            @units = units
        end


        #
        # parse a coordinate from the given string
        #
        def self.parse string

            if string =~ /mm$/ then
                Coord.new string.to_f, UNITS_MM
            elsif string =~ /mil$/ then
                Coord.new string.to_f, UNITS_MIL
            elsif string =~ /in$/ then
                Coord.new string.to_f, UNITS_IN
            else
                raise ParseError
            end
        end


        #
        # compare two coordinates
        #
        def <=> other
            value <=> other.convert(@units).value
        end


        #
        # add two coordinates
        #
        def + other
            Coord.new (@value + other.convert(@units).value), @units
        end


        #
        # subtract two coordinates
        #
        def - other
            Coord.new (@value - other.convert(@units).value), @units
        end


        #
        # divide this coordinate by a scalar
        #
        def / other
            Coord.new (@value / other), @units
        end


        #
        # multiply this coordinate by a scalar
        #
        # returns a new coordinate for the product
        #
        def * other
            Coord.new (@value * other), @units
        end


        #
        # convert this coordinate to a coordinate with the given units
        #
        def convert target
            if @units == target
                self
            else
                factor = CONVERSION_TABLE[Coord.create_key @units, target]
                Coord.new @value * factor, target
            end
        end


        #
        # convert to a floating point in the given units
        #
        def to_f units = UNITS_MM
            convert(units).value.to_f
        end


        #
        # convert to a json object
        #
        def to_json *a

            to_s(true).to_json *a
        end


        #
        # convert the coordinate to a string
        #
        # if the parameter is true, a space is added for the UI
        # if the parameter is false, no space is added for the file format
        #
        def to_s space = false

            "#{@value.round ROUND_DIGITS}#{space ? ' ':''}#{@units}"
        end

    end

end
