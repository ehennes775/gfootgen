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
    # a base class for widgets that edit parameters
    #
    class ParamWidget < Gtk::Bin

        type_register

        #
        # emits this signal with the value in the widget changes
        #
        CHANGE_SIGNAL = signal_new "changed", GLib::Signal::RUN_FIRST, nil, nil


        #
        # inhibits "changed" signal emissions
        #
        # could not get signal handler blocking/unblocking API functions
        # working. so, this boolean is a workaround.
        #
        attr_accessor :signal_blocked


        #
        def initialize

            super

            @signal_blocked = false

            # could not get these API functions to work
            # signal_handler_block CHANGE_SIGNAL.id
            # signal_handler_unblock CHANGE_SIGNAL.id
        end


        #
        #
        #
        def create_entry buffer

            entry = Gtk::Entry.new

            entry.buffer = buffer
            entry.hexpand = true
            entry.xalign = 1.0

            return entry
        end


        #
        #
        #
        def signal_do_changed
        end

    end

end
