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
    # builds generic single-in-line through-hole footprints
    #
    class SilThtFootprintBuilder < SimpleFootprintBuilder

        type_register

        #
        # creates pins for the footprint
        #
        attr_accessor :terminal_factory


        #
        # initialize a new instance
        #
        def initialize

            @terminal_factory = PinFactory.new

            super(
                :package_builder => PackageBuilder.new,
                :pad_builder => SipPinBuilder.new(@terminal_factory),
                :outline_builder => OutlineBuilder.new
                )

            # give initial values for 8 pin header

            @general_builder.name = "J1"
            @general_builder.description = "Header, SIP, 8 pin"

            @outline_builder.silkscreen_outline = Tool::BoxOutline.new

            @package_builder.package_length = Pcb::Coord.parse "100 mil"
            @package_builder.package_width = Pcb::Coord.parse "800 mil"

            @outline_builder.silkscreen_package_offset = @outline_builder.silkscreen_thickness / -2.0
        end

    end

end
