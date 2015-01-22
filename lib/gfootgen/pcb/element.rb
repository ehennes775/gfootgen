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

module Pcb

    #
    # represents a pcb footprint
    #
    class Element

        #
        # The direction for text: 0, 90, 180, or 270
        #
        TEXT_DIRECTION = 0


        #
        # The size for text as a percentage
        #
        TEXT_SIZE = 100


        #
        # The x insertion point for the footprint
        #
        INSERT_X = Pcb::Coord.new 0.0


        #
        # The y insertion point for the footprint
        #
        INSERT_Y = Pcb::Coord.new 0.0


        #
        # The description of the element
        #
        attr_accessor :description


        #
        # The name (refdes) of the element
        #
        attr_accessor :name


        #
        # The PCB objects in this element
        #
        attr_reader :objects


        #
        # The x location for the text (name, description, or value)
        #
        attr_accessor :text_x


        #
        # The y location for the text (name, description, or value)
        #
        attr_accessor :text_y


        #
        # The value of the element
        #
        attr_accessor :value


        #
        # a box representing an outline of the package
        #
        # this value does not get written to the output file, it is for
        # display to the user within the application
        #
        attr_accessor :package_box


        #
        # create a new element with the following parameters in symbol format
        #
        # [+:name+] the name of the footprint (refdes)
        # [+:description+] the description of the element
        # [+:value+] the value of the element
        # [+:text_x+] the text x insertion point
        # [+:text_y+] the text y insertion point
        #
        def initialize params = {}

            @name = params[:name] || ""
            @description = params[:description] || ""
            @value = params[:value] || ""

            @text_x = params[:text_x] || Pcb::Coord.new
            @text_y = params[:text_y] || Pcb::Coord.new

            @package_box = nil

            @objects = []
        end


        #
        # concat objects to this element
        #
        # if needed, this function will insert a blank line to separate groups
        #
        def concat_group objects

            if ((@objects.length > 0) and (objects.length > 0)) then
                @objects << Pcb::Blank.new
            end

            @objects.concat objects
        end


        #
        # convert this element line to a string
        #
        # the string matches the pcb footprint file format
        #
        def to_s
            string = "Element["

            string << "\"\" "
            string << "\"#{@description}\" "
            string << "\"#{@name}\" "
            string << "\"#{@value}\" "
            string << "#{INSERT_X} "
            string << "#{INSERT_Y} "
            string << "#{@text_x} "
            string << "#{@text_y} "
            string << "#{TEXT_DIRECTION} "
            string << "#{TEXT_SIZE} "
            string << "\"\"]\n(\n"

            for object in @objects do
                string << "#{object}\n"
            end

            string << "\t)"

            return string
        end

    end

end
