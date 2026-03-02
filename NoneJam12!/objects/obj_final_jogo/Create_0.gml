/// CREATE - obj_final_jogo
// NÃO usar display_set_gui_size aqui

mostra_pressiona_botao = false;
timer_mostra = 150;

// base lógica (foi pensado em 320x180)
base_w = 320;
base_h = 180;

// escala automática
gui_scale_x = display_get_gui_width()  / base_w;
gui_scale_y = display_get_gui_height() / base_h;
gui_scale   = min(gui_scale_x, gui_scale_y);

// zoom geral da tela final (ajuste se quiser)
final_zoom = 1.25;

// escalas base (sua fnt_pixel = 50)
esc_titulo_base = 0.22;
esc_info_base   = 0.18;
esc_hint_base   = 0.16;

// garante variáveis globais
if (!variable_global_exists("ovinhos")) global.ovinhos = 0;

if (!variable_global_exists("ovo1")) global.ovo1 = 0;
if (!variable_global_exists("ovo2")) global.ovo2 = 0;
if (!variable_global_exists("ovo3")) global.ovo3 = 0;
if (!variable_global_exists("ovo4")) global.ovo4 = 0;
if (!variable_global_exists("ovo5")) global.ovo5 = 0;

// função que desenha tudo
contando_final = function () {

    // atualiza escala (se mudar resolução)
    gui_scale_x = display_get_gui_width()  / base_w;
    gui_scale_y = display_get_gui_height() / base_h;
    gui_scale   = min(gui_scale_x, gui_scale_y);

    var uiS = gui_scale * final_zoom;

    // reset geral
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_font(-1);

    var gw = display_get_gui_width();
    var gh = display_get_gui_height();

    var cx = gw * 0.5;
    var cy = gh * 0.5;

    // conta ovos salvos
    var ovos_salvos = 0;
    if (global.ovo1) ovos_salvos++;
    if (global.ovo2) ovos_salvos++;
    if (global.ovo3) ovos_salvos++;
    if (global.ovo4) ovos_salvos++;
    if (global.ovo5) ovos_salvos++;

    draw_set_font(fnt_pixel);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    // escalas finais
    var esc_titulo = esc_titulo_base * uiS;
    var esc_info   = esc_info_base   * uiS;

    // título
    draw_set_color(c_white);
    draw_text_transformed(cx, cy - (45 * uiS), "Obrigado por jogar", esc_titulo, esc_titulo, 0);

    // infos
    draw_set_color(make_color_rgb(255, 255, 180));
    draw_text_transformed(cx, cy + (10 * uiS), "Ovinhos coletados: " + string(global.ovinhos), esc_info, esc_info, 0);
    draw_text_transformed(cx, cy + (30 * uiS), "Ovos salvos: " + string(ovos_salvos) + "/5", esc_info, esc_info, 0);

    // reset
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_font(-1);
};