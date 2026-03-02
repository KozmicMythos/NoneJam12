var player_dist = distance_to_object(obj_player);

// Começa a se mover se o player estiver perto (ajuste o valor)
if (player_dist < distancia && !morrendo) {
    speed = velocidade_base;
} else {
    speed = 0;
}

if (!morrendo) {
    contador--;
    
    // Só morre e gera outro bug se o player estiver próximo
    if (contador <= 0 && player_dist < distancia) {
        morrendo = true;
        instance_create_layer(x, y, layer, obj_bichinho_luz);
        contador = max_contador;
    }
}

if morrendo {
    image_alpha-= 0.09; 
}

if image_alpha <= 0 instance_destroy();