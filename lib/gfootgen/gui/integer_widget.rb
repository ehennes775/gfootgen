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
    # a widget for editing integer values
    #
    class IntegerWidget < ParamWidget

        type_register


        #
        def initialize value = 0

            super()

            @buffer = Gtk::EntryBuffer.new value.to_s

            add create_entry @buffer

            @buffer.signal_connect "notify::text" do
                if not @signal_blocked then
                    self.signal_emit("changed")
                end
            end
        end


        #
        # get the integer
        #
        def value

            return @buffer.text.to_i
        end


        #
        # set the integer
        #
        def value= value

            @buffer.text = value.to_s
        end
    end

end
