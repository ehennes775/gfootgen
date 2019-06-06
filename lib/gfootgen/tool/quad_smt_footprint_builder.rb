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
    # builds generic quad SMT footprints
    #
    class QuadSmtFootprintBuilder < SimpleFootprintBuilder

        type_register

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
                :pad_builder => QuadPadBuilder.new(@terminal_factory),
                :outline_builder => OutlineBuilder.new
                )

            # give initial values for a PLCC-20

            @general_builder.name = "U1"
            @general_builder.description = "IC, PLCC-20"

            @package_builder.package_length = Pcb::Coord.parse "8.89 mm"
            @package_builder.package_width = Pcb::Coord.parse "8.89 mm"

            @outline_builder.silkscreen_outline = ChamferOutline.new(
                :lower_size => 0.0,
                :upper_size => 1.0
                )
        end

    end

end
