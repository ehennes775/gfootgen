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

require 'json'
require 'test/unit'
require 'gfootgen/tool'
require 'gfootgen/pcb'

class TestPadFactory < Test::Unit::TestCase


    ATTRIBUTES = [
        "clearance",
        "soldermask_relief",
        "pad_length",
        "pad_width"
        ]


    def create_factory

        Tool::PadFactory.new(
            :clearance => Pcb::Coord.parse("1 mm"),
            :soldermask_relief => Pcb::Coord.parse("2 mm"),
            :pad_length => Pcb::Coord.parse("3 mm"),
            :pad_width => Pcb::Coord.parse("4 mm")
            )
    end


    def test_deserialization

        factory1 = create_factory
        object1 = JSON.parse JSON.pretty_generate(factory1)

        factory2 = Tool::PadFactory.create_json object1
        object2 = JSON.parse JSON.pretty_generate(factory2)

        assert object1 == object2
    end


    def test_serialization

        text = JSON.pretty_generate(create_factory)

        object = JSON.parse text

        ATTRIBUTES.each do |name|

            assert object.has_key?(name)
        end
    end


    def test_missing_key

        text = JSON.pretty_generate(create_factory)

        ATTRIBUTES.each do |name|

            object = JSON.parse text

            object.delete name

            assert_raise Pcb::Coord::ParseError do

                Tool::PinFactory.create_json object
            end
        end
    end

end
