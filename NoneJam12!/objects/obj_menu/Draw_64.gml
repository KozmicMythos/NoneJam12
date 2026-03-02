/// DRAW GUI - obj_menu

var gw = display_get_gui_width();
var gh = display_get_gui_height();

// reset de estado (não “vaza” pra outros Draw GUI)
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);

// fundo
draw_set_color(make_color_rgb(15, 15, 25));
draw_rectangle(0, 0, gw, gh, false);

// faixa lateral (aumenta junto com o menu_zoom)
var faixa_w = 120 * gui_scale * menu_zoom;
draw_set_color(make_color_rgb(25, 25, 35));
draw_rectangle(0, 0, faixa_w, gh, false);

// título
draw_set_font(fnt_texto);
draw_set_color(c_white);
draw_text_transformed(5 * gui_scale * menu_zoom, 18 * gui_scale * menu_zoom,
                      "BLUWE",
                      titulo_scale * 3 * gui_scale * menu_zoom,
                      titulo_scale * 3 * gui_scale * menu_zoom,
                      0);
draw_set_font(fnt_pixel);

var uiS = gui_scale * menu_zoom;

draw_set_font(op_font);
for (var i = 0; i < array_length(menu_texto); i++) {

    var corr = (i == menu_index) ? cor_hover : cor_normal;
    draw_set_color(corr);

    var s = op_scale * menu_escala[i];

    var px = menu_x * uiS;
    var py = (menu_y + i * espacamento) * uiS;

    draw_text_transformed(px, py,
                          menu_texto[i],
                          s * uiS,
                          s * uiS,
                          0);
}

// painel settings
if (menu_estado == 1 || submenu_x < 319) {

    var sub_x = submenu_x * gui_scale; // painel não precisa do menu_zoom, fica consistente
    var sub_w = submenu_w * gui_scale;

    draw_set_alpha(0.95);
    draw_set_color(make_color_rgb(10, 10, 18));
    draw_rectangle(sub_x, 0, sub_x + sub_w, gh, false);
    draw_set_alpha(1);

    draw_set_font(titulo_font);
    draw_set_color(c_white);
    draw_text_transformed((submenu_x + settings_x_pad) * gui_scale, 18 * gui_scale,
                          "SOM",
                          titulo_scale * gui_scale,
                          titulo_scale * gui_scale,
                          0);

    draw_set_font(op_font);
    for (var j = 0; j < array_length(settings_texto); j++) {

        var cor2 = (j == settings_index) ? cor_hover : cor_normal;
        draw_set_color(cor2);

        var s2 = op_scale * settings_escala[j];

        var sx = (submenu_x + settings_x_pad) * gui_scale;
        var sy = (settings_y0 + j * espacamento) * gui_scale;

        draw_text_transformed(sx, sy,
                              settings_texto[j],
                              s2 * gui_scale,
                              s2 * gui_scale,
                              0);
    }

    draw_set_font(sub_font);
    draw_set_color(make_color_rgb(255, 255, 180));
    draw_text_transformed((submenu_x + settings_x_pad) * gui_scale, 152 * gui_scale,
        "VOL: " + string_format(global.volume_geral * 100, 0, 0) + "%",
        sub_scale * gui_scale,
        sub_scale * gui_scale,
        0
    );
}

// fade do delay jogar
if (fade_alpha > 0.01) {
    draw_set_alpha(fade_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);
}