/// STEP - obj_final_jogo

timer_mostra--;

if (timer_mostra <= 0) {
    mostra_pressiona_botao = true;
}

if (mostra_pressiona_botao) {
    if (keyboard_check_pressed(vk_enter)) {
        room_goto(room_menu);
    }
}