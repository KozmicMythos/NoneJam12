//retangulo
retangulo_colisao = collision_rectangle(x,y,x+319,y+178,obj_player,false,true);



//se o player entrar no range então muda a iluminação
mudando_iluminacao = function () {
    
          // área do triangulo (retângulo na prática)
        var col = collision_rectangle(x, y, x + 320, y + 180, obj_player, false, true);
        
          //se o player estiver dentro
        if (col != noone) {  
            if (instance_exists(obj_surface)) {
                with (obj_surface) {
                    iluminacao = lerp(iluminacao, 1.2, 0.1);
                }
            } 
        } else {
            // player saiu da area volta ao normal
            if (instance_exists(obj_surface)) {
                with (obj_surface) {
                    iluminacao = lerp(iluminacao, 0.4, 0.1);
                }
            }
        } 
}