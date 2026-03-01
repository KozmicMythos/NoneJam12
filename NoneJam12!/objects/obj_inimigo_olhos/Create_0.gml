max_tempo = irandom_range(120,160);
tempo = max_tempo;
image_index = random(image_number);

cria_zoio = function () {
    
    var player_dist = distance_to_object(obj_player);
    
    if player_dist < 200 {
        tempo--;
    
        if tempo <= 0 {
            //criando os zoio
            var _xx = choose(2,-7);
            //var zoio = instance_create_layer(x,y- 10,"inimigos",obj_olho_dano);
            var zoio = instance_create_depth(x,y-sprite_height/2 + _xx,depth -1 , obj_olho_dano)
            //zoio.vspeed = -0.1;
            tempo = max_tempo;
            with (zoio){
                if image_index > image_number - 1 { 
                   // vspeed = -0.1;
                }
            }
            
        }
    }
    
    
}