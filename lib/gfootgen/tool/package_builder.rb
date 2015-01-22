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
    # builds a box representing the outline of the a package
    #
    class PackageBuilder

        #
        # default length for new instances
        #
        DEFAULT_LENGTH = Pcb::Coord::parse("5.2 mm")


        #
        # default width for new instances
        #
        DEAFULT_WIDTH = Pcb::Coord.parse("2.6 mm")


        #
        # the dimension of the package on the x axis
        #
        attr_accessor :package_length


        #
        # the dimension of the package on the y axis
        #
        attr_accessor :package_width


        #
        # initialize a new instance
        #
        # uses symbol format:
        #
        # [+:package_length+] the dimension of the package on the x axis
        # [+:package_width+] the dimension of the package on the y axis
        #
        def initialize params = {}

            @package_length = params[:package_length] || DEFAULT_LENGTH
            @package_width = params[:package_width] || DEAFULT_WIDTH
        end


        #
        # create a box representing the package
        #
        # the center of the box is located at the origin
        #
        def create_box

            Box.new(
                :x0 => @package_length / -2.0,
                :y0 => @package_width / -2.0,
                :x1 => @package_length / 2.0,
                :y1 => @package_width / 2.0
                )
        end

    end

end
