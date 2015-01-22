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
    # base class for simple footprint builders
    #
    class SimpleFootprintBuilder < FootprintBuilder

        #
        # constructs the silkscreen outline this footprint
        #
        attr_reader :outline_builder


        #
        # constructs the package for this footprint
        #
        attr_reader :package_builder


        #
        # constructs the copper pads for this footprint
        #
        attr_reader :pad_builder


        #
        # initialize a new instance
        #
        def initialize params = {}

            super()

            @package_builder = params[:package_builder]
            @pad_builder = params[:pad_builder]
            @outline_builder = params[:outline_builder]
        end


        #
        # build the footprint
        #
        def create_element

            element = @general_builder.create_element

            element.package_box = @package_builder.create_box

            pads = @pad_builder.generate_objects
            element.concat_group pads

            pad_extents = element.objects.reduce([]) do |extents, object|
                extents << object.extents if object.respond_to? :extents
            end

            pad_box = Box.union *pad_extents

            silk = @outline_builder.generate_objects element, pad_box
            element.concat_group silk

            silk_extents = []

            element.objects.each do |object|
                if object.respond_to? :extents then
                    silk_extents << object.extents
                end
            end

            silk_box = silk_extents.reduce do |o1, o2|
                Box.union o1, o2
            end

            element.text_x = silk_box.x0
            element.text_y = silk_box.y1 + @outline_builder.label_offset

            element.concat_group @license_builder.generate_objects

            return element
        end

    end

end
