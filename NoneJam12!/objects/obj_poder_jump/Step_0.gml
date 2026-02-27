// pega o player (usa place_meeting pra não falhar por ser "um ponto")
if (!pegou && place_meeting(x, y, obj_player)) {
    pegou = true;
    mostra_texto = true;
    sobe = true;

    var _player = instance_place(x, y, obj_player);
    if (_player != noone) {
        efeito_squash(.6,1.2)
        with (_player) {
            can_double_jump = true;
            global.tem_double_jump= true;
            troca_estado(estado_texto);
        }
    }
}

// movimento de subir por um tempo
if (sobe) {
    sobe_timer--;
    y -= vel;
    efeito_squash(.6,1.2)
    if (sobe_timer <= 0) {
        sobe = false; // para de subir
    }
} else if (pegou) and (pode_sumir) {
    // depois que parou de subir, começa a sumir continuamente
    image_alpha -= fade_speed;
    if (image_alpha <= 0) {
        instance_destroy();
    }
};

retorna_squash()