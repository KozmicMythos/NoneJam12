max_timer = irandom_range(270,300);
tempo = max_timer;
tamanho = 2;
espaco = 2;

//estados
estado_idle  = new estado();
estado_atack = new estado();


atacando = function () {
    
    var _bola = irandom_range(5,7)
    if image_index > image_number - 1 {
        repeat (_bola) { 
            //var bola = instance_create_layer(x,y - 35,layer,obj_bola_verde); 
            var bola = instance_create_depth(x,y - 35,depth - 1,obj_bola_verde);
            bola.vspeed = random_range(-1.7,- 1.3);
            bola.hspeed = random_range(-0.6,0.7); 
            bola.gravity = 0.06;
            tempo = max_timer;
            troca_estado(estado_idle);
        }
    }
    
    if image_index > image_number - 1 {
        troca_estado(estado_idle);
    }
    
}

estado_idle.inicia = function () {
    
    sprite_index = spr_inimigo_planta_idle
    image_index = 0;
    
}

estado_idle.roda = function () {
    //diminuindo o timer    
    tempo--;
    if tempo <= 0 {
        troca_estado(estado_atack);
       } 
    
    

    
}

estado_idle.finaliza = function () {
    
    
}


estado_atack.inicia = function () {
    
    sprite_index = spr_inimigo_planta_atk;
    image_index = 0;
    
}

estado_atack.roda = function () {
    
    atacando();
    
}

estado_atack.finaliza = function () {
    
    
}


inicia_estado(estado_idle);

