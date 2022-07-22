/*
 * Copyright (C) 2016, 2022 Robin Gareus <robin@gareus.org>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include <cairo/cairo.h>
#include <math.h>
#include <stdio.h>

#ifndef M_PI
# define M_PI 3.14159265358979323846
#endif

static const float c_bg[4] = { .2, .2, .2 ,1 };
static const float c_fg[4] = { .9, .9, .9 ,1 };

static cairo_pattern_t* pat_bg = NULL;

static void
add_shine (cairo_t* cr, int w, int h, float f)
{
	float cx = w * .5;
	float cy = h * .5;

	float off = 1.f - 2.f * fabs (.5 - f);
	off *= .033;

	cairo_pattern_t* pat = cairo_pattern_create_linear (0.0, 0.0, 3.0, h);
	cairo_pattern_add_color_stop_rgba (pat, 0.00,  .0, .0, .0, 0.0);
	cairo_pattern_add_color_stop_rgba (pat, 0.32 - off,  .75, .75, .75, 0.0);
	cairo_pattern_add_color_stop_rgba (pat, 0.39 - off,  .75, .75, .75, 0.1);
	cairo_pattern_add_color_stop_rgba (pat, 0.45 - off,  .3, .3, .3, 0.0);
	cairo_pattern_add_color_stop_rgba (pat, 1.00,  .0, .0, .0, 0.0);

	cairo_translate (cr, -cx, -cy);

	cairo_rectangle (cr, 0, 0, w, h);
	cairo_set_source (cr, pat);
	cairo_fill (cr);
	cairo_pattern_destroy (pat);
}

static void
create_bg_pattern (int w, int h)
{
	float cx     = w / 2.;
	float cy     = h / 2.;
	float radius = floor ((cx > cy ? cy : cx) - 1.5);

	cairo_pattern_t* pat = cairo_pattern_create_linear (0.0, 0.0, 0.0, h);

	const float pat_left   = (cx - radius) / (float)w;
	const float pat_right  = (cx + radius) / (float)w;
	const float pat_top    = (cy - radius) / (float)h;
	const float pat_bottom = (cy + radius) / (float)h;

#define PAT_XOFF(VAL) (pat_left + 0.35 * 2.0 * radius)
#define SHADE_RGB(COL, X) COL[0] * (X), COL[1] * (X), COL[2] * (X)

	cairo_pattern_add_color_stop_rgb (pat, pat_top,    SHADE_RGB(c_bg, 2.4));
	cairo_pattern_add_color_stop_rgb (pat, pat_bottom, SHADE_RGB(c_bg, .95));

	/* light from top-left */
	cairo_pattern_t* shade_pattern = cairo_pattern_create_linear (0.0, 0.0, w, 0.0);

	cairo_pattern_add_color_stop_rgba (shade_pattern, pat_left,       0.0, 0.0, 0.0, 0.15);
	cairo_pattern_add_color_stop_rgba (shade_pattern, PAT_XOFF(0.35), 1.0, 1.0, 1.0, 0.10);
	cairo_pattern_add_color_stop_rgba (shade_pattern, PAT_XOFF(0.53), 0.0, 0.0, 0.0, 0.05);
	cairo_pattern_add_color_stop_rgba (shade_pattern, pat_right,      0.0, 0.0, 0.0, 0.25);

	cairo_surface_t* surface = cairo_image_surface_create (CAIRO_FORMAT_ARGB32, w, h);
	cairo_t* tc              = cairo_create (surface);

	cairo_set_operator (tc, CAIRO_OPERATOR_SOURCE);
	cairo_set_source (tc, pat);
	cairo_rectangle (tc, 0, 0, w, h);
	cairo_fill (tc);

	cairo_set_operator (tc, CAIRO_OPERATOR_OVER);
	cairo_set_source (tc, shade_pattern);
	cairo_rectangle (tc, 0, 0, w, h);
	cairo_fill (tc);
	cairo_pattern_destroy (shade_pattern);

	pat_bg = cairo_pattern_create_for_surface (surface);
	cairo_destroy (tc);
	cairo_surface_destroy (surface);
}

static void
draw_knob (cairo_t* cr, int w, int h, float v)
{
	float cx     = w / 2.;
	float cy     = h / 2.;
	float radius = floor ((cx > cy ? cy : cx) - 1.5);
	cairo_set_source (cr, pat_bg);

	cairo_arc (cr, cx, cy, radius, 0, 2.0 * M_PI);
	cairo_fill_preserve (cr);
	cairo_set_line_width (cr, .75);
	cairo_set_source_rgba (cr, .0, .0, .0, 1.0);
	cairo_stroke (cr);

	cairo_set_source_rgb (cr, c_fg[0], c_fg[1], c_fg[2]);

	float ang = (.75 * M_PI) + (1.5 * M_PI) * v;

	/* line from center */
	cairo_set_line_width (cr, 1.5);
	cairo_move_to (cr, cx, cy);
	float wid = M_PI * 2 / 180.0;
	cairo_arc (cr, cx, cy, radius, ang - wid, ang + wid);
	cairo_stroke (cr);
}

static void
draw_knob_steps (cairo_t* cr, int w, int h, int n_steps)
{
	create_bg_pattern (w, h);

	for (int i = 0; i < n_steps; ++i) {
		cairo_save (cr);
		cairo_translate (cr, i * w, 0);
		draw_knob (cr, w, h, i / (float)n_steps);
		add_shine (cr, w, h, (i % 7) / 6.0);
		cairo_restore (cr);
	}
	cairo_pattern_destroy (pat_bg);
}

int
main (int argc, char** argv)
{
	int w       = 44;
	int h       = 44;
	int n_steps = 70;

	cairo_surface_t* cs = cairo_image_surface_create (CAIRO_FORMAT_ARGB32, n_steps * w, h);
	cairo_t* cr = cairo_create (cs);

	draw_knob_steps (cr, w, h, n_steps);

	cairo_surface_write_to_png (cs, "knob.png");
	cairo_destroy (cr);
	cairo_surface_destroy (cs);
	return 0;
}
