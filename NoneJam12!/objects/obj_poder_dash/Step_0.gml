var _player = instance_place(x,y,obj_player);

if _player {
    with(_player){
        
        can_dash = true;
        global.tem_dash = true;
        
    }
    instance_destroy();
    
}