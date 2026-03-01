/// DRAW GUI - MENU

var gw = display_get_gui_width();
var gh = display_get_gui_height();

// fundo
draw_set_color(make_color_rgb(15, 15, 25));
draw_rectangle(0, 0, gw, gh, false);

// faixa lateral
draw_set_color(make_color_rgb(25, 25, 35));
draw_rectangle(0, 0, 120, gh, false);

// título
draw_set_font(titulo_font);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(fnt_texto)
draw_text_transformed(5, 18, "BLUWE", titulo_scale * 3, titulo_scale * 3, 0);
draw_set_font(fnt_pixel)


// menu principal
draw_set_font(op_font);
for (var i = 0; i < array_length(menu_texto); i++) {
    var cor = (i == menu_index) ? cor_hover : cor_normal;
    draw_set_color(cor);

    var s = op_scale * menu_escala[i];
    draw_text_transformed(menu_x, menu_y + i * espacamento, menu_texto[i], s, s, 0);
}

// painel settings (aparece entrando/saindo)
if (menu_estado == 1 || submenu_x < 319) {

    draw_set_alpha(0.95);
    draw_set_color(make_color_rgb(10, 10, 18));
    draw_rectangle(submenu_x, 0, submenu_x + submenu_w, gh, false);
    draw_set_alpha(1);

    draw_set_font(titulo_font);
    draw_set_color(c_white);
    draw_text_transformed(submenu_x + settings_x_pad, 18, "SOM", titulo_scale, titulo_scale, 0);

    draw_set_font(op_font);
    for (var i = 0; i < array_length(settings_texto); i++) {
        var cor2 = (i == settings_index) ? cor_hover : cor_normal;
        draw_set_color(cor2);

        var s2 = op_scale * settings_escala[i];
        draw_text_transformed(submenu_x + settings_x_pad, settings_y0 + i * espacamento, settings_texto[i], s2, s2, 0);
    }

    draw_set_font(sub_font);
    draw_set_color(make_color_rgb(255, 255, 180));
    draw_text_transformed(submenu_x + settings_x_pad, 152,
        "VOL: " + string_format(global.volume_geral * 100, 0, 0) + "%",
        sub_scale, sub_scale, 0
    );
}

// fade do delay jogar
if (fade_alpha > 0.01) {
    draw_set_alpha(fade_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);
}