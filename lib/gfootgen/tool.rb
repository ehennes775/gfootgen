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

require_relative 'tool/serializable'

require_relative 'tool/outline'
require_relative 'tool/chamfer_outline'
require_relative 'tool/box_outline'
require_relative 'tool/circle_outline'
require_relative 'tool/left_side_circle_outline'
require_relative 'tool/notch_outline'
require_relative 'tool/pin_one_circle_outline'

require_relative 'tool/terminal_factory'
require_relative 'tool/circular_pad_factory'
require_relative 'tool/pad_factory'
require_relative 'tool/pin_factory'
require_relative 'tool/tab_factory'

require_relative 'tool/general_builder'
require_relative 'tool/license_builder'
require_relative 'tool/outline_builder'
require_relative 'tool/package_builder'

require_relative 'tool/terminal_builder'
require_relative 'tool/chip_pad_builder'
require_relative 'tool/dip_pin_builder'
require_relative 'tool/dpak_pad_builder'
require_relative 'tool/grid_pad_builder'
require_relative 'tool/quad_pad_builder'
require_relative 'tool/sip_pin_builder'

require_relative 'tool/footprint_builder'
require_relative 'tool/simple_footprint_builder'
require_relative 'tool/chip_footprint_builder'
require_relative 'tool/dil_smt_footprint_builder'
require_relative 'tool/dil_tht_footprint_builder'
require_relative 'tool/dpak_footprint_builder'
require_relative 'tool/grid_smt_footprint_builder'
require_relative 'tool/quad_smt_footprint_builder'
require_relative 'tool/sil_tht_footprint_builder'
