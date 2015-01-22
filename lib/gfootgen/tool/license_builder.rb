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
    # builds the license attributes for a footprint
    #
    class LicenseBuilder

        #
        # map this object symbol to the attribute key in the file format
        #
        TABLE = {
            :author       => "author",
            :copyright    => "copyright",
            :dist_license => "dist-license",
            :use_license  => "use-license"
            }


        #
        # the footprint author's name
        #
        attr_accessor :author


        #
        # the footprint copyright
        #
        attr_accessor :copyright


        #
        # the footprint distribution license
        #
        attr_accessor :dist_license


        #
        # the footprint use license
        #
        attr_accessor :use_license


        #
        # initialize a new instance with the following parameters
        #
        # parameters are optional and use an empty string for default
        #
        # [+:author+] the footprint author's name
        # [+:copyright+] the footprint copyright
        # [+:dist_license+] the footprint distribution license
        # [+:use_license+] the footprint use license
        #
        def initialize params = {}

            @author = params[:author] || ""
            @copyright = params[:copyright] || ""
            @dist_license = params[:dist_license] || ""
            @use_license = params[:use_license] || ""
        end


        #
        # generate the license objects to add to an element
        #
        def generate_objects

            objects = []

            TABLE.each do |symbol, key|

                value = send "#{symbol}"

                if value.length > 0
                    objects << Pcb::Attribute.new(key, value)
                end
            end

            return objects
        end

    end

end
