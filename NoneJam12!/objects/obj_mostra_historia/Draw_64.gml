/// DRAW GUI - obj_mostra_historia

var gw = display_get_gui_width();
var gh = display_get_gui_height();

// fundo escurecido (opcional)
if (mostrar_fundo) {
    draw_set_alpha(alpha * fundo_alpha_max);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gw, gh, false);
}

// texto central
draw_set_font(fonte);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_alpha(alpha);
draw_set_color(cor_texto);

// posição no centro
var cx = gw * 0.5;
var cy = gh * 0.5;

draw_text_transformed(cx, cy, texto_historia, texto_scale, texto_scale, 0);

// reset alpha
draw_set_alpha(1);