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
    # abstract base class for pad and pin factories
    #
    class TerminalFactory

        #
        # the clearance, copper-to-copper, for created terminals
        #
        attr_accessor :clearance


        #
        # soldermask relief for created terminals
        #
        attr_accessor :soldermask_relief


        #
        # initialize a new instance
        #
        def initialize params = {}

            @clearance = params[:clearance] || Pcb::Terminal::DEFAULT_CLEARANCE
            @soldermask_relief = params[:soldermask_relief] || Pcb::Terminal::DEFAULT_SOLDERMASK_RELIEF
        end


        #
        # convert a json object into parameters for initialize
        #
        def self.o_to_params o

            {
                :clearance         => Pcb::Coord.parse(o["clearance"]),
                :soldermask_relief => Pcb::Coord.parse(o["soldermask_relief"])
            }
        end


        #
        # convert to a hash
        #
        def to_h

            {
                :clearance         => @clearance.to_s(true),
                :soldermask_relief => @soldermask_relief.to_s(true)
            }
        end


        #
        # convert to a json object
        #
        def to_json *a

            to_h.to_json *a
        end

    end

end
