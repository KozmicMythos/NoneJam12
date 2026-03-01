max_timer = 120;
timer = max_timer

max_timer_explode = 100;
timer_explode = max_timer_explode;

nasceu = false;

pode_morrer = false;

randomise();
direc = choose(-.15,.15);
hspeed = 0;

muda_sprite = function () { 
    
    if pode_morrer {  
        if image_index > image_number - 1 {  
            instance_destroy();
        }
    }
    
}

aproxima_player = function () {
    
    var player = distance_to_object(obj_player);
    var direc  = point_direction(x,y,obj_player.x,obj_player.y);
    
    if player < 150 { 
        direction = direc; 
    }
    
}