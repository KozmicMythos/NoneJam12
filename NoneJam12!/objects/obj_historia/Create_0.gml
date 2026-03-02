/// CREATE - obj_historia
// NÃO usar display_set_gui_size aqui

mostra_pressiona_botao = false;
timer_mostra = 150;

// base lógica (foi pensado em 320x180)
base_w = 320;
base_h = 180;

// calcula escala da GUI atual
gui_scale_x = display_get_gui_width()  / base_w;
gui_scale_y = display_get_gui_height() / base_h;
gui_scale   = min(gui_scale_x, gui_scale_y);

// tamanho do texto (ajuste aqui)
hist_zoom = 1.25; // deixa "um pouco grande"

// função de desenhar
contando_historia = function () {

    // atualiza escala (se mudar resolução)
    gui_scale_x = display_get_gui_width()  / base_w;
    gui_scale_y = display_get_gui_height() / base_h;
    gui_scale   = min(gui_scale_x, gui_scale_y);

    var uiS = gui_scale * hist_zoom;

    // reset geral (evita herdar estado)
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_font(-1);

    var gw = display_get_gui_width();
    var gh = display_get_gui_height();

    var texto = "Encontre seus irmãos.";

    // centro real da tela (GUI)
    var cx = gw * 0.5;
    var cy = gh * 0.5;

    // sua fonte é 50, então usamos uma escala "base" e multiplicamos pelo uiS
    var esc = 0.20;

    draw_set_font(fnt_pixel);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_text_transformed(cx, cy, texto, esc * uiS, esc * uiS, 0);

    // reset no fim
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_font(-1);
};