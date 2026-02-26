//checando se o player pode dar checkpoint
pode_point = true;

//checando para ver se já salvei nesse salve ou não
save = false;
//checando a distancia do player
player_check_save = function () {
    
    var player_dist = distance_to_object(obj_player) > 5
    
    
    if player_dist { 
        save = true;
    }
    
}

estado_salvando = new estado();
estado_parado   = new estado();



/// SALVANDO
estado_salvando.inicia = function (){ 
    image_speed = 1;
    
    if pode_point{
        pode_point = false;
        save_game();
        
        with(obj_player){
            jogo_salvo = true;
        }
    }
    
}

estado_salvando.roda = function () {
    
    
     
    if image_index > image_number - 1 {
        image_index = 0;
        troca_estado(estado_parado);
    }
    
    
    
}

estado_salvando.finaliza = function (){
    
    
}

//PARANDO DE SALVAR


estado_parado.inicia = function () {
    
    image_speed = 0;
}

estado_parado.roda = function () {
    
    //player_check_save();
    var _player = instance_place(x,y, obj_player);
    var _player_dist = distance_to_object(_player) > 35
    //se o player passar por mim eu salvo    
    if _player and pode_point {
        troca_estado(estado_salvando);
    }
    
    if _player_dist {
        pode_point = true;
    }
}

estado_parado.finaliza = function () {
    
    
}

inicia_estado(estado_parado);