/// STEP - obj_menu

// atualiza escala
gui_scale_x = display_get_gui_width()  / base_w;
gui_scale_y = display_get_gui_height() / base_h;
gui_scale   = min(gui_scale_x, gui_scale_y);

// fatores
var uiS_menu = gui_scale * menu_zoom; // só o menu principal é "maior"
var uiS_base = gui_scale;             // painel settings fica normal

// mouse em GUI
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// mouse convertido para cada espaço
var mx_menu_base = mx / uiS_menu;
var my_menu_base = my / uiS_menu;

var mx_base = mx / uiS_base;
var my_base = my / uiS_base;

// fade durante delay do jogar
if (start_pending) fade_alpha = lerp(fade_alpha, 1, 0.25);
else              fade_alpha = lerp(fade_alpha, 0, 0.25);

// anima painel (coordenada BASE 320x180)
var alvo = (menu_estado == 1) ? submenu_in : submenu_out;
submenu_x = lerp(submenu_x, alvo, submenu_vel);

// -------------------------
// MENU PRINCIPAL
// -------------------------
if (menu_estado == 0) {

    menu_hover_anterior = menu_hover;
    menu_hover = -1;

    for (var i = 0; i < array_length(menu_texto); i++) {

        var t  = menu_texto[i];
        var yy = menu_y + i * espacamento;

        // bounds em BASE (mouse do menu já está em base via uiS_menu)
        var ww = string_width(t)  * (op_scale * menu_escala[i]);
        var hh = string_height(t) * (op_scale * menu_escala[i]);

        var x0 = menu_x;
        var y0 = yy - hh * 0.2;
        var x1 = x0 + ww;
        var y1 = yy + hh;

        if (point_in_rectangle(mx_menu_base, my_menu_base, x0, y0, x1, y1)) {
            menu_hover = i;

            if (menu_hover != menu_hover_anterior) {
                audio_play_sound(snd_menu, 0, false);
            }

            menu_index = i;

            if (!start_pending && mouse_check_button_pressed(mb_left)) {

              //  audio_play_sound(snd_click, 0, false);
                menu_escala[i] = 1.20;

                switch (i) {
                    case 0: // JOGAR
                        start_pending = true;
                        alarm[0] = start_delay_frames;
                    break;

                    case 1: // CONFIGURAÇÕES
                        menu_estado = 1;
                    break;

                    case 2: // SAIR
                        game_end();
                    break;
                }
            }
        }

        var alvo_esc = (i == menu_index) ? 1.10 : 1.0;
        menu_escala[i] = lerp(menu_escala[i], alvo_esc, 0.25);
    }

    // teclado (bloqueia durante delay)
    if (!start_pending) {
        if (keyboard_check_pressed(vk_down)) {
            menu_index = clamp(menu_index + 1, 0, array_length(menu_texto) - 1);
            audio_play_sound(snd_menu, 0, false);
        }
        if (keyboard_check_pressed(vk_up)) {
            menu_index = clamp(menu_index - 1, 0, array_length(menu_texto) - 1);
            audio_play_sound(snd_menu, 0, false);
        }

        if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
         //   audio_play_sound(snd_click, 0, false);

            switch (menu_index) {
                case 0:
                    start_pending = true;
                    alarm[0] = start_delay_frames;
                break;
                case 1:
                    menu_estado = 1;
                break;
                case 2:
                    game_end();
                break;
            }
        }
    }
}

// -------------------------
// SETTINGS (PAINEL)
// -------------------------
if (menu_estado == 1) {

    settings_hover_anterior = settings_hover;

    if (keyboard_check_pressed(vk_escape)) menu_estado = 0;

    settings_hover = -1;

    for (var i = 0; i < array_length(settings_texto); i++) {

        var t  = settings_texto[i];
        var yy = settings_y0 + i * espacamento;

        // bounds em BASE normal (mouse_base = mx/gui_scale)
        var ww = string_width(t)  * (op_scale * settings_escala[i]);
        var hh = string_height(t) * (op_scale * settings_escala[i]);

        var x0 = submenu_x + settings_x_pad;
        var y0 = yy - hh * 0.2;
        var x1 = x0 + ww;
        var y1 = yy + hh;

        if (point_in_rectangle(mx_base, my_base, x0, y0, x1, y1)) {

            settings_hover = i;

            if (settings_hover != settings_hover_anterior) {
                audio_play_sound(snd_menu, 0, false);
            }

            settings_index = i;

            if (mouse_check_button_pressed(mb_left)) {

                //audio_play_sound(snd_cli, 0, false);
                settings_escala[i] = 1.20;

                switch (i) {
                    case 0:
                        global.volume_geral = clamp(global.volume_geral + 0.1, 0, 1);
                        audio_master_gain(global.volume_geral);
                    break;

                    case 1:
                        global.volume_geral = clamp(global.volume_geral - 0.1, 0, 1);
                        audio_master_gain(global.volume_geral);
                    break;

                    case 2:
                        menu_estado = 0;
                    break;
                }
            }
        }

        var alvo_esc2 = (i == settings_index) ? 1.10 : 1.0;
        settings_escala[i] = lerp(settings_escala[i], alvo_esc2, 0.25);
    }

    // teclado
    if (keyboard_check_pressed(vk_down)) {
        settings_index = clamp(settings_index + 1, 0, array_length(settings_texto) - 1);
        audio_play_sound(snd_menu, 0, false);
    }
    if (keyboard_check_pressed(vk_up)) {
        settings_index = clamp(settings_index - 1, 0, array_length(settings_texto) - 1);
        audio_play_sound(snd_menu, 0, false);
    }

    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
//        audio_play_sound(snd_click, 0, false);

        switch (settings_index) {
            case 0:
                global.volume_geral = clamp(global.volume_geral + 0.1, 0, 1);
                audio_master_gain(global.volume_geral);
            break;
            case 1:
                global.volume_geral = clamp(global.volume_geral - 0.1, 0, 1);
                audio_master_gain(global.volume_geral);
            break;
            case 2:
                menu_estado = 0;
            break;
        }
    }
}