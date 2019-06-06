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

module Gui

    #
    # stores a list of the available outlines
    #
    class OutlineCatalog < Gtk::ListStore

        type_register

        #
        # the column index containing the name
        #
        COLUMN_NAME = 0


        #
        # the column index containing outline object
        #
        COLUMN_OUTLINE = 1


        #
        #
        #
        def initialize data = nil

            super()

            set_column_types [String, Object]

            data.each { |args| add *args } unless data.nil?
        end


        #
        # add an outline to the list
        #
        def add name, outline

            iter = append

	    puts name

            set_value iter, COLUMN_NAME, name
            set_value iter, COLUMN_OUTLINE, outline
        end


        #
        # find an outline in the list
        #
        def find_outline outline

            each do |mode, path, iter|
                return iter if outline == get_value(iter, COLUMN_OUTLINE)
            end

            return nil
        end

    end

end
