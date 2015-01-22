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
    # a widget for selecting the silkscreen outline
    #
    class OutlineWidget < ParamWidget

        type_register


        CATALOG = OutlineCatalog.new [
            [
                "Non-polarized",
                Tool::BoxOutline.new(:extend => 0.0, :polarity => false)
                ],
            [
                "Polarized Line A",
                Tool::BoxOutline.new(:extend => 1.0, :polarity => true)
                ],
            [
                "Polarized Line B",
                Tool::BoxOutline.new(:extend => 0.0, :polarity => true)
                ],
            [
                "Polarized Notch",
                Tool::NotchOutline.new
                ],
            [
                "Polarized Chamfer A",
                Tool::ChamferOutline.new(:upper_size => 1.0, :lower_size => 0.0)
                ],
            [
                "Polarized Chamfer B",
                Tool::ChamferOutline.new(:upper_size => 0.0, :lower_size => 1.0)
                ],
            [
                "Polarized Chamfer C",
                Tool::ChamferOutline.new(:upper_size => 1.0, :lower_size => 1.0)
                ],
            [
                "Polarized Circle Pin 1",
                Tool::PinOneCircleOutline.new
                ],
            [
                "Polarized Circle Top",
                Tool::LeftSideCircleOutline.new(:position => 0.0)
                ],
            [
                "Polarized Circle Center",
                Tool::LeftSideCircleOutline.new(:position => 0.5)
                ],
            [
                "Polarized Circle Bottom",
                Tool::LeftSideCircleOutline.new(:position => 1.0)
                ]
            ]


        #
        DEFAULT_OUTLINE = Tool::BoxOutline.new(
            :extend => 0.0,
            :polarity => false
            )


        #
        def initialize value

            super()

            @combo = Gtk::ComboBox.new :model => CATALOG

            renderer = Gtk::CellRendererText.new
            renderer.alignment = Pango::Layout::Alignment::RIGHT

            @combo.pack_start renderer, true
            @combo.set_attributes renderer, {:text => OutlineCatalog::COLUMN_NAME}

            @combo.set_active 0

            add @combo

            @combo.signal_connect "changed" do
                if not @signal_blocked then
                    self.signal_emit("changed")
                end
            end
        end


        #
        def value

            iter = @combo.active_iter

            if iter then
                return CATALOG.get_value iter, OutlineCatalog::COLUMN_OUTLINE
            else
                return DEFAULT_OUTLINE
            end
        end


        #
        def value= value

            iter = CATALOG.find_outline value
            @combo.active_iter = iter unless iter.nil?
        end

    end

end
