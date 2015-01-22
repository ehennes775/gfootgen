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
    class OutlineBuilder

        attr_accessor :silkscreen_package_offset
        attr_accessor :silkscreen_pad_offset
        attr_accessor :silkscreen_thickness
        attr_accessor :silkscreen_outline
        attr_accessor :label_offset

        def initialize params = {}
            @silkscreen_package_offset = Pcb::Coord::parse("0.25 mm")
            @silkscreen_pad_offset     = Pcb::Coord::parse("0.25 mm")
            @silkscreen_thickness      = Pcb::Coord::parse("0.3 mm")
            @silkscreen_outline        = BoxOutline.new(
                :extend => 0.0,
                :polarity => false
                )
            @label_offset              = Pcb::Coord::parse("0.4 mm")
        end

        def generate_objects element, pad_box
            objects = []

            if not element.package_box then
                if not pad_box then
                    silk_box = nil
                else
                    silk_box = pad_box.expand(@silkscreen_pad_offset + @silkscreen_thickness / 2.0)
                end
            elsif not pad_box then
                silk_box = element.package_box.expand(@silkscreen_package_offset + @silkscreen_thickness / 2.0)
            else
                silk_box = Box::union(
                    element.package_box.expand(@silkscreen_package_offset + @silkscreen_thickness / 2.0),
                    pad_box.expand(@silkscreen_pad_offset + @silkscreen_thickness / 2.0)
                    )
            end

            if silk_box then
                silkscreen_outline.generate(element, silk_box, @silkscreen_thickness) do |object|
                    objects << object
                end
            end

            return objects
        end

    end

end
