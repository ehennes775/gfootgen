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
    # a graphical widget for viewing a PCB element
    #
    class ElementViewer < Gtk::Bin

        type_register


        #
        # the color used for exposed copper
        #
        COLOR_COPPER = [0.7, 0.7, 0.7]


        #
        # the color used for the reference data
        #
        COLOR_REFERENCE = [0.5, 0.0, 0.0]


        #
        # the color used for the package outline
        #
        COLOR_PACKAGE = [0.0, 0.0, 0.5]


        #
        # the color used for silkscreen
        #
        COLOR_SILKSCREEN = [0.0, 0.0, 0.0]


        #
        #
        #
        def element
            @element
        end


        #
        #
        #
        def element= element
            @element = element
            @canvas.queue_draw
        end


        #
        #
        #
        def initialize

            super

            @canvas = Gtk::DrawingArea.new

            @canvas.signal_connect "draw" do |widget, context|
                on_draw widget, context
            end

            add @canvas
        end


        #
        #
        #
        def on_draw widget, context

            if @element then

                r_limit = 10000.0
                r_scale = 100.0

                recording_surface = Cairo::RecordingSurface.new(
                    0.0,
                    0.0,
                    r_limit,
                    r_limit,
                    Cairo::Content::COLOR
                    )

                temp_context = Cairo::Context.new recording_surface
                temp_context.translate r_limit / 2.0, r_limit / 2.0
                temp_context.scale r_scale, r_scale

                @element.draw temp_context

                ink = recording_surface.ink_extents

                context.translate(
                    widget.allocation.width / 2.0,
                    widget.allocation.height / 2.0
                    )

                scale = [
                    0.9 * widget.allocation.width / ink[2],
                    0.9 * widget.allocation.height / ink[3]
                    ].min

                context.scale r_scale * scale, r_scale * scale

                context.translate(
                    ((r_limit - ink[2]) / 2.0 - ink[0]) / r_scale,
                    ((r_limit - ink[3]) / 2.0 - ink[1]) / r_scale
                    )

                @element.draw context
            end
        end


        #
        #
        #
        class ::Pcb::Element
            def draw context
                @objects.each do |object|
                    object.draw context
                end

                #draw the outline of the package

                if @package_box then
                    context.set_source_rgb *COLOR_PACKAGE
                    context.move_to @package_box.x0.to_f, @package_box.y0.to_f
                    context.line_to @package_box.x1.to_f, @package_box.y0.to_f
                    context.line_to @package_box.x1.to_f, @package_box.y1.to_f
                    context.line_to @package_box.x0.to_f, @package_box.y1.to_f
                    context.set_line_width 0.05
                    context.close_path
                    context.stroke
                end

                # use cairo toy text API for a quick refdes

                extents = context.text_extents @name
                context.set_source_rgb *COLOR_SILKSCREEN
                context.move_to @text_x.to_f, @text_y.to_f + extents.height * 0.1
                context.scale 0.1, 0.1
                context.show_text @name

                # draw the origin marker

                context.set_source_rgb *COLOR_REFERENCE
                context.move_to -1.0, 0.0
                context.line_to 0.0, 1.0
                context.line_to 1.0, 0.0
                context.line_to 0.0, -1.0
                context.set_line_width 0.5
                context.close_path
                context.stroke
            end
        end


        #
        #
        #
        class ::Pcb::Attribute

            def draw context
            end
        end


        #
        #
        #
        class ::Pcb::Blank

            def draw context
            end
        end


        #
        #
        #
        class ::Pcb::ElementArc

            def draw context
                context.arc_negative(
                    @center_x.to_f,
                    @center_y.to_f,
                    @radius_x.to_f,
                    Math::PI * (@start - 180) / 180.0,
                    (Math::PI * (@start - 180) / 180.0) - (Math::PI * @sweep / 180.0)
                    )

                context.set_line_width @thickness.to_f

                context.set_line_cap Cairo::LINE_CAP_ROUND
                context.set_source_rgb *COLOR_SILKSCREEN

                context.stroke
            end
        end


        #
        #
        #
        class ::Pcb::ElementLine

            def draw context
                context.move_to @x0.to_f, @y0.to_f
                context.line_to @x1.to_f, @y1.to_f
                context.set_line_width @thickness.to_f

                context.set_line_cap Cairo::LINE_CAP_ROUND
                context.set_source_rgb *COLOR_SILKSCREEN

                context.stroke
            end
        end


        #
        #
        #
        class ::Pcb::Pad
            def draw context

                context.move_to @x0.to_f, @y0.to_f

                if [@x0.to_f, @y0.to_f] == [@x1.to_f, @y1.to_f] then
                    context.line_to @x1.to_f + 0.0001, @y1.to_f
                else
                    context.line_to @x1.to_f, @y1.to_f
                end

                context.set_line_cap Cairo::LINE_CAP_SQUARE

                context.set_line_width (@aperture + @soldermask_relief * 2.0).to_f
                context.set_source_rgb 0.3, 0.3, 0.3
                context.stroke_preserve

                context.set_line_width @aperture.to_f
                context.set_source_rgb *COLOR_COPPER
                context.stroke

                context.save

                extents = context.text_extents @number
                context.set_source_rgb 0.5, 0.0, 0.0
                context.move_to(
                    (@x0.to_f + @x1.to_f - extents.width * 0.1) / 2.0,
                    (@y0.to_f + @y1.to_f + extents.height * 0.1) / 2.0
                    )
                context.scale 0.1, 0.1
                context.show_text @number

                context.restore
            end
        end


        #
        #
        #
        class ::Pcb::Pin

            def draw context

                context.arc_negative(
                    @center_x.to_f,
                    @center_y.to_f,
                    (@copper_diameter + @soldermask_relief * 2.0).to_f / 2.0,
                    0.0,
                    -2.0 * Math::PI
                    )

                context.set_source_rgb 0.3, 0.3, 0.3
                context.fill

                context.arc_negative(
                    @center_x.to_f,
                    @center_y.to_f,
                    @copper_diameter.to_f / 2.0,
                    0.0,
                    -2.0 * Math::PI
                    )

                context.set_source_rgb *COLOR_COPPER
                context.fill

                context.arc_negative(
                    @center_x.to_f,
                    @center_y.to_f,
                    @drill_diameter.to_f / 2.0,
                    0.0,
                    -2.0 * Math::PI
                    )

                context.set_source_rgb 0.0, 0.0, 0.0
                context.fill

                context.save

                extents = context.text_extents @number
                context.set_source_rgb *COLOR_REFERENCE
                context.move_to(
                    @center_x.to_f - extents.width * 0.1 / 2.0,
                    @center_y.to_f + extents.height * 0.1 / 2.0
                    )
                context.scale 0.1, 0.1
                context.show_text @number

                context.restore
            end
        end

    end

end
