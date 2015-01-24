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
    # provides an editor for the license attributes of a footprint
    #
    class LicenseEditor < ParamEditor

        type_register

        PARAMS = [
            [:author,       "Author",               String ],
            [:copyright,    "Copyright",            String ],
            [:dist_license, "Distribution License", String ],
            [:use_license,  "Use License",          String ]
            ]

        def initialize builder = nil

            super builder, PARAMS, "License"
        end

    end

end