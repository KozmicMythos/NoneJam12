/* DRAW - MENU 320x180

var gw = display_get_gui_width();
var gh = display_get_gui_height();

// Fundo
draw_set_color(make_color_rgb(15, 15, 25));
draw_rectangle(0, 0, gw, gh, false);

// Faixa lateral leve (opcional)
draw_set_color(make_color_rgb(25, 25, 35));
draw_rectangle(0, 0, 120, gh, false);

// Título
draw_set_font(titulo_font);
draw_set_color(c_white);
draw_text_transformed(18, 18, "MEU JOGO", titulo_scale, titulo_scale, 0);

// Conteúdo
draw_set_font(op_font);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

if (menu_estado == "principal") {

    for (var i = 0; i < array_length(menu_opcoes); i++) {
        var cor = (i == menu_index) ? cor_hover : cor_normal;
        draw_set_color(cor);

        var s = op_scale * menu_escala[i];
        draw_text_transformed(menu_x, menu_y + i * espacamento, menu_opcoes[i].texto, s, s, 0);
    }

} else if (menu_estado == "settings") {

    // overlay
    draw_set_color(make_color_rgb(5, 5, 10));
    draw_set_alpha(0.85);
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);

    // título settings
    draw_set_color(c_white);
    draw_text_transformed(18, 18, "CONFIG", titulo_scale, titulo_scale, 0);

    for (var i = 0; i < array_length(menu_settings); i++) {
        var cor = (i == settings_index) ? cor_hover : cor_normal;
        draw_set_color(cor);

        var s = op_scale * settings_escala[i];
        draw_text_transformed(menu_x, menu_y + i * espacamento, menu_settings[i].texto, s, s, 0);
    }

    // valor volume
    draw_set_font(sub_font);
    draw_set_color(make_color_rgb(255, 255, 180));
    draw_text_transformed(18, 152, "VOL: " + string_format(global.volume_geral * 100, 0, 0) + "%", 0.16, 0.16, 0);
    
}


// --- SUBMENU ---
if (menu_estado == "settings" || menu_estado == "creditos") {
    // fundo semi-transparente
    draw_set_color(make_color_rgb(5, 5, 10));
    draw_set_alpha(0.85);
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    draw_set_alpha(1);

    var lista = (menu_estado == "settings") ? menu_settings : menu_creditos;
    var escalas = (menu_estado == "settings") ? settings_escala : creditos_escala;
    var titulo = (menu_estado == "settings") ? "SETTINGS" : "CREDITS";

    draw_set_font(titulo_font);
    draw_set_color(c_white);
    draw_text(submenu_x, display_get_gui_height() * 0.2, titulo);

    draw_set_font(op_font);
    for (var i = 0; i < array_length(lista); i++) {
        var yy = display_get_gui_height() * 0.35 + i * 70;
        draw_text_transformed(submenu_x, yy, lista[i].texto, escalas[i], escalas[i], 0);
    }

    // Exibe valor atual do volume (em SETTINGS)
    if (menu_estado == "settings") {
        draw_set_font(sub_font);
        draw_set_color(make_color_rgb(255,255,180));
        draw_text(submenu_x, display_get_gui_height() * 0.75, "VOLUME ATUAL: " + string_format(global.volume_geral * 100, 0, 0) + "%");
    }
}