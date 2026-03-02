/// CREATE - obj_menu (usar DRAW GUI)
// NÃO usar display_set_gui_size aqui

// base lógica do menu (foi feito pra 320x180)
base_w = 320;
base_h = 180;

// escala automática baseada no GUI atual
gui_scale_x = display_get_gui_width()  / base_w;
gui_scale_y = display_get_gui_height() / base_h;
gui_scale   = min(gui_scale_x, gui_scale_y);

// ---- "aumentar na esquerda" ----
// 1.0 = normal (igual antes em 320x180)
// 1.25 ou 1.35 deixa maior só o menu
menu_zoom = 1.30; // AJUSTE AQUI

// estado do menu
menu_estado = 0; // 0=principal, 1=settings

// fontes
titulo_font = fnt_pixel;
op_font     = fnt_pixel;
sub_font    = fnt_pixel;

// escalas (sua fnt é 50)
titulo_scale = 0.22;
op_scale     = 0.20;
sub_scale    = 0.16;

// cores
cor_normal = make_color_rgb(220, 220, 220);
cor_hover  = c_white;

// layout (base 320x180)
menu_x = 36;
menu_y = 78;
espacamento = 22;

// opções
menu_texto = ["JOGAR", "CONFIGURAÇÕES", "SAIR"];
menu_index = 0;
menu_hover = -1;
menu_hover_anterior = -1;
menu_escala = array_create(array_length(menu_texto), 1.0);

// settings
settings_texto = ["VOLUME +", "VOLUME -", "VOLTAR"];
settings_index = 0;
settings_hover = -1;
settings_hover_anterior = -1;
settings_escala = array_create(array_length(settings_texto), 1.0);

// volume
if (!variable_global_exists("volume_geral")) global.volume_geral = 1;
audio_master_gain(global.volume_geral);

// painel slide (base 320x180)
submenu_w = 140;
submenu_vel = 0.18;
submenu_x = 320;              // começa fora (base)
submenu_in  = 320 - submenu_w; // entra
submenu_out = 320;            // sai
settings_x_pad = 10;
settings_y0 = 70;

// delay do jogar (ALARM)
start_pending = false;
start_room = Room1;          // TROQUE para sua room de gameplay/cutscene
start_delay_frames = 14;
fade_alpha = 0;