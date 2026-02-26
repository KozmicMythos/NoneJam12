var _player = instance_place(x,y,obj_player);

if _player {
    with(_player){
        
        can_double_jump = true;
        global.tem_double_jump = true;
        
    }
    instance_destroy();
    
}