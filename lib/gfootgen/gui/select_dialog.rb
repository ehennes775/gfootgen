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
    # a dialog to select a different footprint builder
    #
    class SelectDialog < Gtk::Dialog

        type_register


        #
        #
        #
        CATALOG = FootprintCatalog.new [
            [
                "Chip",
                "Generic 2 terminal SMT footprints",
                Tool::ChipFootprintBuilder.new
                ],
            [
                "DIL",
                "Dual-in-line SMT footprints",
                Tool::DilSmtFootprintBuilder.new
                ],
            [
                "DIP",
                "Dual-in-line through-hole footprints",
                Tool::DilThtFootprintBuilder.new
                ],
            [
                "DPAK",
                "DPAK SMT footprints",
                Tool::DpakFootprintBuilder.new
                ],
            [
                "Quad",
                "Quad SMT footprints",
                Tool::QuadSmtFootprintBuilder.new
                ]
            ]


        #
        #
        #
        def initialize params = {}

            super :title => "Select a Footprint"

            set_default_size 400, 200
            flags = Gtk::Dialog::Flags::DESTROY_WITH_PARENT
            set_modal true

            add_button "_OK", Gtk::ResponseType::ACCEPT
            add_button "_Cancel", Gtk::ResponseType::CANCEL

            @tree_view = Gtk::TreeView.new
            @tree_view.set_vexpand true
            @tree_view.set_model CATALOG
            @tree_view.visible = true

            @tree_view.selection.mode = Gtk::SelectionMode::BROWSE

            #self.content_area.set_border_width 20
            self.content_area.add @tree_view

            # create a column for the identifier

            column = Gtk::TreeViewColumn.new
            column.title = "Name"

            renderer = Gtk::CellRendererText.new
            renderer.alignment = Pango::Layout::Alignment::RIGHT

            column.pack_start renderer, true
            column.set_attributes renderer, {:text => FootprintCatalog::COLUMN_NAME}

            @tree_view.append_column column

            #create a column for the description

            column = Gtk::TreeViewColumn.new
            column.title = "Description"

            renderer = Gtk::CellRendererText.new
            renderer.alignment = Pango::Layout::Alignment::RIGHT

            column.pack_start renderer, true
            column.set_attributes renderer, {:text => FootprintCatalog::COLUMN_DESCRIPTION}

            @tree_view.append_column column
        end


        #
        # retrieve the selected footprint builder
        #
        def builder

            iter = @tree_view.selection.selected

            if iter then
                return CATALOG.get_value iter, FootprintCatalog::COLUMN_OBJECT
            else
                return nil
            end
        end

    end

end
