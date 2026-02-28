velh = 0;
velv = 0;
max_velv = 1;
max_velh = 1;
grav = 1

velocidade = 0.6;
direita  = velocidade;
esquerda = -velocidade;
direcao = choose(esquerda,direita);

lay_col  = layer_tilemap_get_id("Map");
colisor  = [obj_chao,obj_plataforma,lay_col,obj_check_escada];



//colisao com o chao
checa_chao = function () {
    
    chao = place_meeting(x, y + 1, colisor);  
  
    
 }

movimentacao_vertical = function () {
    
     //Se eu nao estiver no chão, eu caio
    
    if (!chao)
    { 
        if (velv < max_velv) velv += grav;  else velv = max_velv; 
        
    }
    else
    {
        if velv != 0  velv = 0;
    }
}



caminhando = function () {
    
    //o inimigo estará parado (começará em idle)
    //depois de um tempo o inimigo irá se mover
    //esse lado será randomizado
    //se escolher a esquerda ganhará velh negativo
    //irá parar quando encostar na parede
     
    var esq = place_meeting(x-7,y,colisor) or !place_meeting(x - 7, y + 1,colisor);
    var dir = place_meeting(x+7,y,colisor) or !place_meeting(x + 7, y + 1,colisor);

    
    switch (direcao) {
        
        case esquerda: 
            velh = esquerda;
            image_xscale = -1;
        
        if esq {
            direcao = direita;
            x += 2;
        }
            
        break;
        
        case direita:
            
        velh = direita;
        image_xscale = 1;
        
        if dir {
            direcao = esquerda;
            x -= 2;
        }
            
        break;
    }
    
}



//estados do bichinho 
estado_idle    = new estado();
estado_caminha = new estado();

max_timer = 34//random_range(100,70);
timer_caminha = max_timer;

max_timer_corre = 34;
timer_corre = max_timer;


estado_idle.inicia = function () {
    
    image_index = 0; 
    sprite_index = spr_inimigo_gosma_idle;
}

estado_idle.roda = function () {
    
    timer_caminha --;
    velh = 0;
    
    if timer_caminha <= 0 {
        troca_estado(estado_caminha);
        timer_caminha = max_timer;
    }
    
}
estado_idle.finaliza = function () {
    
    
}



estado_caminha.inicia = function  () { 
    
    sprite_index = spr_inimigo_gosma;
    image_index = 0;
}


estado_caminha.roda = function () {
    
    caminhando();
    timer_corre --;
    
    if timer_corre <= 0 {
        
        troca_estado(estado_idle);
        timer_corre = max_timer_corre;
        
    }
    //
    //if distance_to_object(obj_player) < 20 {
        //max_timer -= 100;
    //}
    
}

estado_caminha.finaliza = function () {
    
}

inicia_estado(estado_idle);