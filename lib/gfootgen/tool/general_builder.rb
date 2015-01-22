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
    # builds the element and assigns the general attributes
    #
    class GeneralBuilder

        #
        # the name, or refdes, of the element
        #
        attr_accessor :name


        #
        # the description of the element
        #
        attr_accessor :description


        #
        # the value of the element
        #
        attr_accessor :value


        #
        # create a new element builder
        #
        def initialize params = {}
            @name = params[:name] || "D1"
            @description = params[:description] || "Diode, Molded, SMA"
            @value = params[:value] || ""
        end


        #
        # create the element
        #
        def create_element
            return Pcb::Element.new(
                :name => @name,
                :description => @description,
                :value => @value
                )
        end

    end

end
