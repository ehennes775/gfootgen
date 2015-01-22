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
    # PCB attribute
    #
    class Attribute

        #
        # the name of the attribute, convertable to a string
        #
        attr_accessor :name


        #
        # the value of the attribute, convertable to a string
        #
        attr_accessor :value


        #
        # initialize an attribute
        #
        # [+name+] the name of the attribute
        # [+value+] the value of the attribute
        #
        def initialize name, value

            @name = name
            @value = value
        end


        #
        # convert this attribute to a string
        #
        def to_s
            "\tAttribute(\"#{@name}\" \"#{@value}\")"
        end

    end

end
