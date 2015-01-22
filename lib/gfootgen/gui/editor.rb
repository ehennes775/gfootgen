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
    # base class for editor widgets
    #
    class Editor < Gtk::Bin

        type_register

        signal_new "change", GLib::Signal::RUN_FIRST, nil, nil

        BORDER_WIDTH = 10
        GRID_SPACING = 5
        LABEL_INDENT = 20

        def initialize
            super
        end


        #
        #
        #
        def create_string_widget type

            if type.equal? Pcb::Coord then

                widget = CoordWidget.new

            elsif type.equal? Tool::Outline then

                widget = OutlineWidget.new Tool::Outline.new

            elsif type.equal? Integer then

               widget = IntegerWidget.new

            else

                widget = StringWidget.new

            end

            widget.signal_connect "changed" do
                update
            end

            return widget
        end


        #
        #
        #
        def create_expander text, widget

            expander = Gtk::Expander.new(
                "<b>#{text}</b>",
                 true
                 )

            expander.use_markup = true
            expander.expanded = true

            expander.add widget

            return expander
        end


        #
        #
        #
        def create_grid

            grid = Gtk::Grid.new

            grid.column_spacing = GRID_SPACING
            grid.row_spacing = GRID_SPACING

            return grid
        end


        #
        #
        #
        def create_label text

            label = Gtk::Label.new(text)

            label.set_alignment 0.0, 0.5
            label.margin_left = LABEL_INDENT

            return label
        end


        #
        def create_param_grid widgets = []

            grid = create_grid

            widgets.each.with_index do |rwidgets, row|
                rwidgets.each.with_index do |widget, column|
                    grid.attach widget, column, row, 1, 1
                end
            end

            return grid
        end


        def signal_do_change
        end

        def update
            self.signal_emit("change")
        end

    end

end
