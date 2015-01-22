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
require_relative 'gui/footprint_catalog'
require_relative 'gui/outline_catalog'

require_relative 'gui/param_widget'
require_relative 'gui/coord_widget'
require_relative 'gui/integer_widget'
require_relative 'gui/outline_widget'
require_relative 'gui/string_widget'

require_relative 'gui/editor'
require_relative 'gui/param_editor'
require_relative 'gui/general_editor'
require_relative 'gui/license_editor'
require_relative 'gui/outline_editor'
require_relative 'gui/package_editor'
require_relative 'gui/pad_editor'
require_relative 'gui/terminal_editor'

require_relative 'gui/element_viewer'
require_relative 'gui/select_dialog'

module Gui

    #
    #
    #
    class MyEditor < Editor

        type_register


        #
        #
        #
        def initialize builder = nil

            super()

            @builder = builder || Tool::ChipFootprintBuilder.new

            @editors = {
                :general_editor  => GeneralEditor.new,
                :package_editor  => PackageEditor.new,
                :terminal_editor => TerminalEditor.new,
                :tab_editor      => TerminalEditor.new("Tab Parameters"),
                :pad_editor      => PadEditor.new,
                :outline_editor  => OutlineEditor.new,
                :license_editor  => LicenseEditor.new
                }


            @editors.each do |symbol, editor|
                editor.signal_connect "change" do
                    update
                end
            end

            set_border_width BORDER_WIDTH

            grid = create_grid
            grid.orientation = Gtk::Orientation::VERTICAL

            @editors.each do |symbol, editor|
                grid.add editor
            end

            add grid

            self.builder = @builder
        end

        def builder
            @builder
        end


            STUFF = [
                [:general_editor,  :general_builder],
                [:package_editor,  :package_builder],
                [:terminal_editor, :terminal_factory],
                [:tab_editor,      :tab_factory],
                [:pad_editor,      :pad_builder],
                [:outline_editor,  :outline_builder],
                [:license_editor,  :license_builder]
                ]

        def builder= builder

            @builder = builder

            STUFF.each do |editor_symbol, builder_symbol|

                if builder && builder.respond_to?("#{builder_symbol}") then
                    @editors[editor_symbol].builder = @builder.send "#{builder_symbol}"
                else
                    @editors[editor_symbol].builder = nil
                end
            end

            on_change
        end

        #
        #
        #
        def createEntryBuffer contents = ""

            buffer = Gtk::EntryBuffer.new contents

            buffer.signal_connect "notify::text" do
                on_change
            end

            return buffer
        end


        #
        #
        #
        def create_outline_combo

            @outline_combo = OutlineCombo.new

            @outline_combo.signal_connect "changed" do
                on_change
            end

            return @outline_combo
        end


        #
        #
        #
        def create_footprint

            return @builder.create_element
        end


        #
        #
        #
        def on_change
            self.signal_emit("change")
        end

    end



    ##
    #
    #
    class MyWindow < Gtk::Window

        type_register

        #
        # application name in the title bar
        #
        TITLE = "Footprint Generator"


        ##
        #
        #
        def initialize

            super

            signal_connect "destroy" do
                Gtk.main_quit
            end

            #set_default_size 300, 200

            set_window_position Gtk::Window::Position::CENTER

            @scroll = Gtk::ScrolledWindow.new

            @change_dialog = SelectDialog.new
            @change_dialog.transient_for = self

            @export_dialog = create_export_dialog
            @export_dialog.transient_for = self

            @text_buffer = Gtk::TextBuffer.new
            @graphic_widgets = []

            grid = Gtk::Grid.new
            grid.set_orientation Gtk::Orientation::VERTICAL
            grid.set_hexpand true
            grid.set_vexpand true
            add grid

            grid.add create_main_widget
            grid.add create_button_box

            self.editor = MyEditor.new

            show_all

            # update widget visibility afte show_all
            @editor.builder = @editor.builder
        end



        def editor= editor

            if @editor then
                @editor.destroy
                @editor = nil
            end

            if @scroll.child
                @scroll.child.destroy
            end

            @editor = editor

            @editor.show_all
            @scroll.add @editor

            if editor then
                @editor.signal_connect "change" do
                    on_update
                end

                on_update
            end

        end


        ##
        #
        #
        def create_button_box

            grid = Gtk::Grid.new

            left_box = Gtk::ButtonBox.new :horizontal

            left_box.set_border_width 20
            left_box.layout_style = Gtk::ButtonBox::Style::START
            left_box.set_hexpand true

            left_box.add create_change_button

            grid.add left_box

            right_box = Gtk::ButtonBox.new :horizontal

            right_box.set_border_width 20
            right_box.layout_style = Gtk::ButtonBox::Style::END
            right_box.set_hexpand true

            right_box.add create_export_button

            grid.add right_box

            return grid
        end


        def create_change_button

            button = Gtk::Button.new :label => "Change..."

            button.signal_connect "clicked" do
                on_change_footprint
            end

            return button
        end


        ##
        #
        #
        def create_export_button

            button = Gtk::Button.new :label => "Export..."

            button.signal_connect "clicked" do
                on_export_footprint
            end

            return button
        end


        ##
        #
        #
        def create_export_dialog

            dialog = Gtk::FileChooserDialog.new(
                :title => "Export Footprint",
                :parent => self,
                :action => Gtk::FileChooser::Action::SAVE
                )

            dialog.add_button "_OK", Gtk::ResponseType::ACCEPT
            dialog.add_button "_Cancel", Gtk::ResponseType::CANCEL

            dialog.do_overwrite_confirmation = true

            return dialog
        end


        ##
        #
        #
        def create_graphic_viewer

            viewer = ElementViewer.new

            viewer.set_size_request 675, 600

            @graphic_widgets << viewer

            return viewer
        end


        ##
        #
        #
        def create_main_widget

            paned = Gtk::Paned.new :horizontal

            @scroll.set_size_request 450, 600

            paned.add1 @scroll
            paned.add2 create_viewers

            return paned
        end


        ##
        #
        #
        def create_text_viewer

            viewer = Gtk::TextView.new @text_buffer

            viewer.can_focus = false
            viewer.editable = false

            scroll = Gtk::ScrolledWindow.new

            scroll.add viewer

            return scroll
        end


        #
        #
        #
        def create_viewers

            viewers = Gtk::Notebook.new
            viewers.set_border_width 10
            viewers.set_vexpand true

            viewers.append_page create_text_viewer, Gtk::Label.new("Text")
            viewers.append_page create_graphic_viewer, Gtk::Label.new("Graphic")

            return viewers
        end


        #
        # run the dilog box for the user to change the footprint
        #
        def on_change_footprint

            if @change_dialog.run == Gtk::ResponseType::ACCEPT then
                @editor.builder = @change_dialog.builder
            end

            ensure
                @change_dialog.hide
        end


        #
        # export a footprint to a file
        #
        def on_export_footprint

            contents = @editor.create_footprint.to_s

            if @export_dialog.run == Gtk::ResponseType::ACCEPT then

                file = Gio::File.new_for_uri @export_dialog.uri

                file.replace do |output|
                    output.write contents
                end
            end

            rescue Gio::IO::Error => error
                show_exception "File Error", error

            ensure
                @export_dialog.hide
        end


        #
        # update all observers with a new footprint
        #
        def on_update

            element = @editor.create_footprint

            # update the text based widgets
            @text_buffer.set_text element.to_s

            # update the graphic widgets
            for widget in @graphic_widgets do
                widget.element = element
            end

            # update the window title
            if (element.description.length > 0) then
                set_title "#{TITLE} - #{element.description}"
            else
                set_title "#{TITLE}"
            end
        end


        #
        # show a dialog box for an exception
        #
        def show_exception title, error

            dialog = Gtk::MessageDialog.new(
                :parent => self,
                :flags => 0,
                :type => Gtk::MessageType::ERROR,
                :buttons_type => Gtk::MessageDialog::ButtonsType::OK,
                :message => title
                )

            begin
                dialog.secondary_text = error.message

                dialog.run

                ensure
                    dialog.destroy
            end
        end

    end

end
