#!/usr/bin/ruby
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

require 'gtk3'

require_relative 'gfootgen/box'
require_relative 'gfootgen/pcb'
require_relative 'gfootgen/tool'
require_relative 'gfootgen/gui'

if __FILE__ == $0
    Gtk.init
        window = Gui::MyWindow.new
    Gtk.main
end
