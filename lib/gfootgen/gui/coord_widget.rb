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
    # a widget for entering a PCB coordinate or dimension
    #
    class CoordWidget < ParamWidget

        type_register

        #
        def initialize value = Pcb::Coord.new

            super()

            @buffer = Gtk::EntryBuffer.new value.to_s true

            add create_entry @buffer

            @buffer.signal_connect "notify::text" do
                if not @signal_blocked then
                    begin
                        Pcb::Coord.parse @buffer.text
                        self.signal_emit("changed")
                    rescue Pcb::Coord::ParseError
                    end
                end
            end
        end


        #
        # get the coordinate
        #
        def value

            return Pcb::Coord.parse @buffer.text
        end


        #
        # set the coordinate
        #
        def value= value

            @buffer.text = value.to_s true
        end

    end

end
