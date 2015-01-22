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
    # builds generic dual-in-line surface mount footprints
    #
    class DilSmtFootprintBuilder < SimpleFootprintBuilder

        #
        # creates pads for the footprint
        #
        attr_accessor :terminal_factory


        #
        # initialize a new instance
        #
        def initialize

            @terminal_factory = PadFactory.new(
                :pad_length => Pcb::Coord.parse("1.75 mm"),
                :pad_width => Pcb::Coord.parse("0.65 mm")
                )

            super(
                :package_builder => PackageBuilder.new,
                :pad_builder => DipPinBuilder.new(@terminal_factory),
                :outline_builder => OutlineBuilder.new
                )

            # give initial values for a SOIC-8 footprint

            @general_builder.name = "U1"
            @general_builder.description = "IC, SOIC-8"

            @package_builder.package_length = Pcb::Coord.parse "4.0 mm"
            @package_builder.package_width = Pcb::Coord.parse "5.0 mm"

            @pad_builder.pin_count = 8
            @pad_builder.pad_pitch = Pcb::Coord.parse "1.27 mm"
            @pad_builder.pad_spacing = Pcb::Coord.parse "5.6 mm"

            @outline_builder.silkscreen_outline = Tool::NotchOutline.new
        end

    end

end
