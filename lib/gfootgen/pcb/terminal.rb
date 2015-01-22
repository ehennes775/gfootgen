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
    # base class for pads and pins
    #
    class Terminal

        #
        # the default clearance for new instances
        #
        # the minimum distance copper-to-copper
        #
        DEFAULT_CLEARANCE = Pcb::Coord.new 0.25, Pcb::Coord::UNITS_MM


        #
        # the default soldermask relief for new instances
        #
        DEFAULT_SOLDERMASK_RELIEF = DEFAULT_CLEARANCE / 2.0


        #
        # the pin number as a string
        #
        attr_accessor :number


        #
        # create a new instance
        #
        # [+:clearance+] the clearance - copper-to-copper
        # [+:soldermask_relief+] the soldermask relief
        #
        def initialize params = {}

            @clearance = params[:clearance] || DEFAULT_CLEARANCE
            @soldermask_relief = params[:soldermask_relief] || DEFAULT_SOLDERMASK_RELIEF
            @number = params[:number] || ""
        end

    end

end
