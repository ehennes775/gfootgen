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

require 'benchmark'
require 'test/unit'
require 'gfootgen/pcb'

class TestCoord < Test::Unit::TestCase

    #
    # digits to round floats for comparison to prevent rounding errors
    # interfering with ==
    #
    DIGITS = 10


    def test_initialization

        coord = Pcb::Coord.new

        assert_not_nil coord.value
        assert_not_nil coord.units

        assert coord.value.zero?
    end


    def test_parser

        coord = Pcb::Coord.parse "10 mm"

        assert coord.value = 10.0
        assert coord.units = Pcb::Coord::UNITS_MM

        coord = Pcb::Coord.parse "-50 mil"

        assert coord.value = 50.0
        assert coord.units = Pcb::Coord::UNITS_MIL

        coord = Pcb::Coord.parse "1.0 in"

        assert coord.value = 1.0
        assert coord.units = Pcb::Coord::UNITS_IN
    end


    def test_relational

        same0 = Pcb::Coord.parse "10 mm"
        same1 = Pcb::Coord.parse "10 mm"

        assert same0 == same1
        assert same0 <= same1
        assert same0 >= same1

        large = Pcb::Coord.parse "100 mil"
        small = Pcb::Coord.parse "10 mil"

        assert small < large
        assert large > small
        assert small <= large
        assert large >= small
    end


    def test_conversion

        c0 = Pcb::Coord.parse "25.4 mm"
        c1 = Pcb::Coord.parse "1 in"

        assert_equal c0.value, c1.convert(c0.units).value.round(DIGITS)
        assert_equal c1.value, c0.convert(c1.units).value.round(DIGITS)

        c0 = Pcb::Coord::parse "1000 mil"
        c1 = Pcb::Coord.parse "1 in"

        assert_equal c0.value, c1.convert(c0.units).value.round(DIGITS)
        assert_equal c1.value, c0.convert(c1.units).value.round(DIGITS)

        c0 = Pcb::Coord::parse "1 mil"
        c1 = Pcb::Coord.parse "0.0254 mm"

        assert_equal c0.value, c1.convert(c0.units).value.round(DIGITS)
        assert_equal c1.value, c0.convert(c1.units).value.round(DIGITS)
    end


    def test_conversion_benchmark

        count = 100000

        coord_mm = Pcb::Coord.parse "100 mm"
        coord_mil = Pcb::Coord.parse "100 mil"

        puts
        puts "Pcb::Coord converstion (count=#{count})"

        Benchmark.bm(10) do |x|
            x.report("mm to mm") { count.times {coord_mm.convert(Pcb::Coord::UNITS_MM)} }
            x.report("mm to mil") { count.times {coord_mm.convert(Pcb::Coord::UNITS_MIL)} }
            x.report("mil to mil") { count.times {coord_mil.convert(Pcb::Coord::UNITS_MIL)} }
            x.report("mil to mm") { count.times {coord_mil.convert(Pcb::Coord::UNITS_MM)} }
        end

    end

end
