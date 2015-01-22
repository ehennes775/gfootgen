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

    # An outline that creates a chamfer at the selected corners
    class ChamferOutline < Outline

        attr_accessor :lower_size


        attr_accessor :upper_size


        def initialize params = {}
            @upper_size = params[:upper_size] || 1.0
            @lower_size = params[:lower_size] || 1.0
        end


        def generate element, box, thickness

            upper_delta = thickness * @upper_size
            lower_delta = thickness * @lower_size

            #top side
            yield Pcb::ElementLine.new(
                :x0 => box.x0 + upper_delta,
                :y0 => box.y0,
                :x1 => box.x1,
                :y1 => box.y0,
                :thickness => thickness
                )

            #right side
            yield Pcb::ElementLine.new(
                :x0 => box.x1,
                :y0 => box.y0,
                :x1 => box.x1,
                :y1 => box.y1,
                :thickness => thickness
                )

            #bottom side
            yield Pcb::ElementLine.new(
                :x0 => box.x1,
                :y0 => box.y1,
                :x1 => box.x0 + lower_delta,
                :y1 => box.y1,
                :thickness => thickness
                )

            if @lower_size > 0 then
                yield Pcb::ElementLine.new(
                    :x0 => box.x0 + lower_delta,
                    :y0 => box.y1,
                    :x1 => box.x0,
                    :y1 => box.y1 - lower_delta,
                    :thickness => thickness
                    )
            end

            #left side
            yield Pcb::ElementLine.new(
                :x0 => box.x0,
                :y0 => box.y1 - lower_delta,
                :x1 => box.x0,
                :y1 => box.y0 + upper_delta,
                :thickness => thickness
                )

            if @upper_size > 0 then
                yield Pcb::ElementLine.new(
                    :x0 => box.x0,
                    :y0 => box.y0 + upper_delta,
                    :x1 => box.x0 + upper_delta,
                    :y1 => box.y0,
                    :thickness => thickness
                    )
            end
        end

        def == other

            other.instance_of?(ChamferOutline) && @upper_size == other.upper_size && @lower_size == other.lower_size
        end

    end

end
