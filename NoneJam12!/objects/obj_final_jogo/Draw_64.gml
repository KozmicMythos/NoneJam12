/// DRAW GUI - obj_final_jogo

// reset geral do draw gui
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);

// desenha o texto principal + infos
contando_final();

// escala atual (para o hint)
gui_scale_x = display_get_gui_width()  / base_w;
gui_scale_y = display_get_gui_height() / base_h;
gui_scale   = min(gui_scale_x, gui_scale_y);

var uiS = gui_scale * final_zoom;

// hint ENTER com piscar
var x_center = display_get_gui_width() * 0.5;
var y_bottom = display_get_gui_height() - (22 * uiS);
var piscar = abs(sin(current_time / 600));

if (mostra_pressiona_botao) {

    draw_set_font(fnt_pixel);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    var esc_hint = esc_hint_base * uiS;

    draw_text_transformed_colour(
        x_center,
        y_bottom,
        "PRESSIONE ENTER",
        esc_hint, esc_hint, 0,
        c_white, c_white, c_white, c_white,
        piscar
    );

    // reset
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_font(-1);
}