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
    # builds generic SMT footprints that have a tab
    #
    # DPAK, D2PAK, SOT223
    #
    class DpakFootprintBuilder < SimpleFootprintBuilder

        #
        # creates the terminals on the left
        #
        attr_accessor :terminal_factory


        #
        # creates the large tab on the right
        #
        attr_accessor :tab_factory


        #
        # initialize a new instance
        #
        def initialize

            @terminal_factory = TabFactory.new(
                :pad_length => Pcb::Coord.parse("2.2 mm"),
                :pad_width => Pcb::Coord.parse("0.6 mm"),
                :tab_length => Pcb::Coord.parse("2.2 mm"),
                :tab_width => Pcb::Coord.parse("3.5 mm")
                )

            super(
                :package_builder => PackageBuilder.new,
                :pad_builder => DpakPadBuilder.new(
                    :terminal_factory => @terminal_factory
                    ),
                :outline_builder => OutlineBuilder.new
                )

            @general_builder.name = "U1"
            @general_builder.description = "IC, SOT-223, 6 pin"

            @pad_builder.pin_count = 6
            @pad_builder.pad_pitch = Pcb::Coord.parse "1.27 mm"
            @pad_builder.pad_spacing = Pcb::Coord.parse "6.2 mm"

            @package_builder.package_length = Pcb::Coord.parse "3.5 mm"
            @package_builder.package_width = Pcb::Coord.parse "6.5 mm"
        end

    end

end
