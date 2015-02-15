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
    # abstract base class for persistant objects
    #
    class Serializable

        #
        # an empty hash of serializable attributes
        #
        @serial_attr = {}


        #
        # add a serializable attribute to a class
        #
        def self.attr_serializable symbol, type

            attr_accessor symbol
            @serial_attr[symbol] = type
        end


        #
        # adjust subclasses to be serializable
        #
        def self.inherited subclass

            subclass.instance_variable_set :@serial_attr, @serial_attr.clone
        end


        #
        # create an instance of a subclass using json input
        #
        def self.create_json o

            params = {}

            @serial_attr.each do |symbol, type|
                params[symbol] = type.create_json o[symbol.to_s]
            end

            self.new params
        end


        #
        # initialize a new instance
        #
        def initialize
        end


        #
        # convert to a hash
        #
        def to_h

            instance_variables.reduce({}) do |hash, name|

                getter = name[1..-1].to_sym

                hash[getter] = send getter if respond_to? getter

                hash
            end
        end


        #
        # convert to a json object
        #
        def to_json *a

            to_h.to_json *a
        end

    end

end
