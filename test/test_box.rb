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
require 'gfootgen/box'

class TestBox < Test::Unit::TestCase


    def test_initialization

        box = Box.new

        assert_not_nil box.x0
        assert_not_nil box.y0
        assert_not_nil box.x1
        assert_not_nil box.y1

        assert_equal box.x0, box.x1
        assert_equal box.y0, box.y1
    end


    def test_normalization

        x0, x1 = 5.0, 10.0
        y0, y1 = 5.0, 10.0

        box = Box.new :x0 => x0, :y0 => y0, :x1 => x1, :y1 => y1

        assert box.x0 <= box.x1
        assert box.y0 <= box.y1

        x0, x1 = x1, x0
        y0, y1 = y1, y0

        box = Box.new :x0 => x0, :y0 => y0, :x1 => x1, :y1 => y1

        assert box.x0 <= box.x1
        assert box.y0 <= box.y1
    end


    def test_expansion

        x0, x1 = 5.0, 10.0
        y0, y1 = 5.0, 10.0

        box = Box.new :x0 => x0, :y0 => y0, :x1 => x1, :y1 => y1

        w0 = box.x1 - box.x0
        h0 = box.y1 - box.y0

        box2 = box.expand 50.0

        w1 = box2.x1 - box2.x0
        h1 = box2.y1 - box2.y0

        assert_equal (w0 + 2.0 * 50.0), w1
        assert_equal (h0 + 2.0 * 50.0), h1
    end


    def test_union

        boxes = 100.times.collect do
            x0, x1 = Random::rand, Random::rand
            y0, y1 = Random::rand, Random::rand

            Box.new :x0 => x0, :y0 => y0, :x1 => x1, :y1 => y1
        end

        union = Box::union *boxes

        boxes.each do |box|
            assert union.x0 <= box.x0
            assert union.x1 >= box.x1
            assert union.y0 <= box.y0
            assert union.y1 >= box.y1
        end
    end


    def test_union_benchmark

        count = 1000

        boxes = count.times.collect do
            x0, x1 = Random::rand, Random::rand
            y0, y1 = Random::rand, Random::rand

            Box.new :x0 => x0, :y0 => y0, :x1 => x1, :y1 => y1
        end

        puts
        puts "Box::union benchmark (count=#{count}})"

        Benchmark.bm do |x|
            x.report { Box::union *boxes }
            x.report { Box::union *boxes }
            x.report { Box::union *boxes }
            x.report { Box::union *boxes }
        end
    end

end
