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

    class BoxOutline < Outline

        type_register

        attr_accessor :extend
        attr_accessor :polarity

        def initialize params = {}

            super()

            @extend = params[:extend] || 0.0
            @polarity = params[:polarity] || false
        end

        def generate element, box, thickness

            delta = thickness * 2.0 * @extend

            #top side
            yield Pcb::ElementLine.new(
                :x0 => box.x0 - delta,
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
                :x1 => box.x0 - delta,
                :y1 => box.y1,
                :thickness => thickness
                )

            #left side
            yield Pcb::ElementLine.new(
                :x0 => box.x0,
                :y0 => box.y1,
                :x1 => box.x0,
                :y1 => box.y0,
                :thickness => thickness
                )

            if @polarity then
                # polarity line
                yield Pcb::ElementLine.new(
                    :x0 => box.x0 - thickness * 2.0,
                    :y0 => box.y1,
                    :x1 => box.x0 - thickness * 2.0,
                    :y1 => box.y0,
                    :thickness => thickness
                    )
            end
        end

        def == other

            other.instance_of?(BoxOutline) && @extend == other.extend && @polarity == other.polarity
        end


    end

end
