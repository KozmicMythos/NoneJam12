
muda_sprite();

if image_index > image_number - 1{ 
    vspeed = -0.3;  
    image_speed = 0;
    hspeed = direc;
    timer --;
    if timer <= 0 {
        nasceu = true;
    }
}

if nasceu { 
    timer_explode--; 
    if timer_explode <=  0 {   
        pode_morrer = true;
        timer_explode = max_timer_explode; 
        //trocando a sprite
        sprite_index = spr_olho_explode; 
        image_index = 0;
        image_speed = 1; 
    }   
}

//distancia do player
var dist = distance_to_object(obj_player);

if pode_morrer && image_index > image_number - 1 {   
    if dist < 70 && image_index > image_number - 2{
        //audio_play_sound(snd_bolha,0,false);
    }
    instance_destroy();
}


