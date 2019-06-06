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
    # list of the available footprint builders
    #
    class FootprintCatalog < Gtk::ListStore

        type_register


        # the index of the column containing the name
        COLUMN_NAME = 0


        # the index of the column containing a description
        COLUMN_DESCRIPTION = 1


        # the index of the column containing the footprint builder object
        COLUMN_OBJECT = 2


        #
        #
        #
        def initialize data = nil

            super()

            set_column_types [String, String, Object]

            data.each { |args| add *args } unless data.nil?
        end


        #
        #
        #
        def add name, description, builder

            iter = append

            set_value iter, COLUMN_NAME, name
            set_value iter, COLUMN_DESCRIPTION, description
            set_value iter, COLUMN_OBJECT, builder
        end

    end

end
