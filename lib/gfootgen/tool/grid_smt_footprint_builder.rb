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
    # builds generic grid surface mount footprints
    #
    class GridSmtFootprintBuilder < SimpleFootprintBuilder

        type_register

        #
        # creates pads for the footprint
        #
        attr_accessor :terminal_factory


        #
        # initialize a new instance
        #
        def initialize

            @terminal_factory = CircularPadFactory.new(
                :pad_diameter => Pcb::Coord.parse("0.4 mm"),
                :soldermask_relief => Pcb::Coord.parse("0.05 mm")
                )

            super(
                :package_builder => PackageBuilder.new,
                :pad_builder => GridPadBuilder.new(@terminal_factory),
                :outline_builder => OutlineBuilder.new
                )

            # give initial values for a FT256 footprint

            @general_builder.name = "U1"
            @general_builder.description = "IC, FT256"

            @package_builder.package_length = Pcb::Coord.parse "17.0 mm"
            @package_builder.package_width = Pcb::Coord.parse "17.0 mm"

            @pad_builder.column_count = 16
            @pad_builder.row_count = 16
            @pad_builder.pad_pitch = Pcb::Coord.parse "1.0 mm"

            @outline_builder.silkscreen_outline = ChamferOutline.new(
                :lower_size => 0.0,
                :upper_size => 1.0
                )
        end

    end

end
