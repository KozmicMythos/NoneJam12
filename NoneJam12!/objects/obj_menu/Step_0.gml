/// STEP - MENU (mouse em GUI)

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// fade durante delay do jogar
if (start_pending) fade_alpha = lerp(fade_alpha, 1, 0.25);
else              fade_alpha = lerp(fade_alpha, 0, 0.25);

// anima painel
var alvo = (menu_estado == 1) ? submenu_in : submenu_out;
submenu_x = lerp(submenu_x, alvo, submenu_vel);

// -------------------------
// MENU PRINCIPAL
// -------------------------
if (menu_estado == 0) {

    // guarda hover anterior pra tocar som só quando muda
    menu_hover_anterior = menu_hover;

    menu_hover = -1;
    draw_set_font(op_font);

    for (var i = 0; i < array_length(menu_texto); i++) {

        var t  = menu_texto[i];
        var yy = menu_y + i * espacamento;

        var ww = string_width(t)  * op_scale * menu_escala[i];
        var hh = string_height(t) * op_scale * menu_escala[i];

        var x0 = menu_x;
        var y0 = yy - hh * 0.2;
        var x1 = x0 + ww;
        var y1 = yy + hh;

        if (point_in_rectangle(mx, my, x0, y0, x1, y1)) {
            menu_hover = i;

            // som 1x quando entra no item
            if (menu_hover != menu_hover_anterior) {
                audio_play_sound(snd_menu, 0, false);
            }

            menu_index = i;

            if (!start_pending && mouse_check_button_pressed(mb_left)) {
                // bounce
                menu_escala[i] = 1.20;

                // ações
                switch (i) {
                    case 0: // JOGAR
                        start_pending = true;
                        alarm[0] = start_delay_frames; // precisa do Alarm 0
                    break;

                    case 1: // CONFIG
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

    // guarda hover anterior pra tocar som só quando muda
    settings_hover_anterior = settings_hover;

    if (keyboard_check_pressed(vk_escape)) menu_estado = 0;

    settings_hover = -1;
    draw_set_font(op_font);

    for (var i = 0; i < array_length(settings_texto); i++) {

        var t  = settings_texto[i];
        var yy = settings_y0 + i * espacamento;

        var ww = string_width(t)  * op_scale * settings_escala[i];
        var hh = string_height(t) * op_scale * settings_escala[i];

        var x0 = submenu_x + settings_x_pad;
        var y0 = yy - hh * 0.2;
        var x1 = x0 + ww;
        var y1 = yy + hh;

        if (point_in_rectangle(mx, my, x0, y0, x1, y1)) {
            settings_hover = i;

            // som 1x quando entra no item
            if (settings_hover != settings_hover_anterior) {
                audio_play_sound(snd_menu, 0, false);
            }

            settings_index = i;

            if (mouse_check_button_pressed(mb_left)) {
                settings_escala[i] = 1.20;

                switch (i) {
                    case 0: // +
                        global.volume_geral = clamp(global.volume_geral + 0.1, 0, 1);
                        audio_master_gain(global.volume_geral);
                    break;

                    case 1: // -
                        global.volume_geral = clamp(global.volume_geral - 0.1, 0, 1);
                        audio_master_gain(global.volume_geral);
                    break;

                    case 2: // voltar
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