/// CREATE - MENU (usar DRAW GUI)

display_set_gui_size(320, 180);

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

// layout
menu_x = 36;
menu_y = 78;
espacamento = 22;

// opções
menu_texto = ["JOGAR", "CONFIGURAÇÕES", "SAIR"];
menu_index = 0;
menu_hover = -1;
menu_hover_anterior = -1; // <- pro som do hover
menu_escala = array_create(array_length(menu_texto), 1.0);

// settings
settings_texto = ["VOLUME +", "VOLUME -", "VOLTAR"];
settings_index = 0;
settings_hover = -1;
settings_hover_anterior = -1; // <- pro som do hover
settings_escala = array_create(array_length(settings_texto), 1.0);

// volume
if (!variable_global_exists("volume_geral")) global.volume_geral = 1;
audio_master_gain(global.volume_geral);

// painel slide
submenu_w = 140;
submenu_vel = 0.18;
submenu_x = 320;                   // começa fora
submenu_in  = 320 - submenu_w;      // posição quando entra
submenu_out = 320;                 // posição quando sai
settings_x_pad = 10;
settings_y0 = 70;

// delay do jogar (ALARM)
start_pending = false;
start_room = room_cutscene;  // TROQUE se quiser outra room
start_delay_frames = 14;     // ajuste
fade_alpha = 0;