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
    # base class for footprint builders
    #
    class FootprintBuilder < GLib::Object

        type_register

        #
        # builds the element with the general attributes for this footprint
        #
        attr_reader :general_builder


        #
        # builds the license attributes for this footprint
        #
        attr_reader :license_builder


        #
        # initialize a new instance
        #
        def initialize

            super()

            @general_builder = GeneralBuilder.new
            @license_builder = LicenseBuilder.new
        end

    end

end
