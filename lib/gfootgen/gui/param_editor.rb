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
    # base class for widgets that edit groups of parameters
    #
    class ParamEditor < Editor

        type_register


        #
        #
        #
        def initialize builder, params, title

            super()

            @builder = nil

            @buffers = Hash[params.map { |attr, text, type|
                [attr, create_string_widget(type)]
                }]

            @labels = Hash[params.map { |attr, text, type|
                [attr, create_label(text)]
                }]

            widgets = params.map do |attr, text, type|
                [@labels[attr], @buffers[attr]]
            end

            add create_expander title, create_param_grid(widgets)

            self.builder = builder
        end


        #
        # assign a new builder to this editor
        #
        # Copies values from the builder into the widgets. Hides widgets that
        # are not required.
        #
        def builder= builder

            @builder = builder

            if @builder then
                @buffers.each do |attr, widget|
                    if @builder.respond_to? "#{attr}" then
                        widget.signal_blocked = true
                        widget.value = @builder.send "#{attr}"
                        widget.signal_blocked = false
                        widget.visible = true
                        @labels[attr].visible = true
                    else
                        widget.visible = false
                        @labels[attr].visible = false
                    end
                end
                self.visible = true
            else
                self.visible = false
            end
        end


        #
        # copy values from the widgets into the builder
        #
        def update

            @buffers.each do |key, widget|
                if @builder.respond_to? "#{key}=" then
                    begin
                        @builder.send "#{key}=", widget.value
                    rescue Pcb::Coord::ParseError
                        # todo: provide some error indication
                    end
                end
            end

            super
        end
    end

end
