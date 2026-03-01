mostra_pressiona_botao = false;

timer_mostra = 150;

contando_historia = function () {

    var gw = display_get_gui_width();
    var gh = display_get_gui_height();

    var texto = "Encontre seus irmãos.";

    var cx = gw * 0.5;
    var cy = gh * 0.5;

    var esc = 0.7;

    draw_set_alpha(1);
    draw_set_color(c_white);

    draw_set_font(fnt_pixel);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    // TEXTO EM LINHA ÚNICA (não usa line_sep nem line_w)
    draw_text_transformed(cx, cy, texto, esc, esc, 0);

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_font(-1);
};