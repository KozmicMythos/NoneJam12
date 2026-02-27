var _player = instance_place(x,y,obj_player);

if _player {
    mostra_texto = true;
    sobe = true;
    with(_player){ 
        can_dash = true;
        global.tem_dash = true;
        troca_estado(estado_texto); 
    }
 //   instance_destroy(); 
}
if sobe {
    vel = 1;
}else{
    vel = 0;
}

if sobe {
    sobe_timer--;
    y-= vel;
    //image_alpha -= 0.02; 
    if sobe_timer <= 0 {
        sobe = false;
        image_alpha -= 0.02; 
    }
}

if image_alpha <= 0 { 
    instance_destroy();
} 
