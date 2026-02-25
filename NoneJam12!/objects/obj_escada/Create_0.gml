
cria_colisor = function () {
    
    var colisor = place_meeting(x,y-1,obj_check_escada);
    var escada  = place_meeting(x,y-1,obj_escada);
    
    if !colisor and !escada{
        var colisores = instance_create_layer(x,y-15,"player",obj_check_escada);   
    }
    
};

