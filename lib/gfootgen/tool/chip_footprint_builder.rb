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
    # builds generic 2-pin SMT footprints
    #
    class ChipFootprintBuilder < SimpleFootprintBuilder

        #
        # creates pads for the footprint
        #
        attr_accessor :terminal_factory


        #
        # initialize a new instance
        #
        def initialize

            @terminal_factory = PadFactory.new

            super(
                :package_builder => PackageBuilder.new,
                :pad_builder => ChipPadBuilder.new(@terminal_factory),
                :outline_builder => OutlineBuilder.new
                )

            @outline_builder.silkscreen_outline = Tool::BoxOutline.new(
                :extend => 1.0,
                :polarity => true
                )
        end

    end

end
