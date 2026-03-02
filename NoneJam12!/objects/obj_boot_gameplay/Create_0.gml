/// CREATE - obj_boot_gameplay (coloque na room_gameplay)

// GUI sempre igual
display_set_gui_size(320, 180);

// ---- RESET UI/MAPA (mesmo que não seja global, fechamos via with) ----
if (instance_exists(obj_map)) {
    with (obj_map) {
        mostra_mapa = false;
        escala = 1;
        // se você tiver função init, chama aqui também:
        if (is_undefined(mapa_init) == false) mapa_init();
    }
}

// ---- RESET de player (evita “ângulo” ou flip herdado) ----
if (instance_exists(obj_player)) {
    with (obj_player) {
        image_angle = 0;
        // evita espelhamento acumulado
        image_xscale = abs(image_xscale);
        image_yscale = abs(image_yscale);
    }
}

// opcional: matar a si mesmo depois do reset
instance_destroy();