//controle da plataforma

//Variaveis de controle do personagem
velh         = 0;
velv         = 0;
max_velh     = 1;
max_velv     = 5;
grav         = .2;
spd          = 1;

//velocidade que a plataforma sobe
vel_plataforma = 0.5;

//Colisores
lay_col  = layer_tilemap_get_id("Map");
colisor      = [lay_col];

chao = 0;
teto = 0;
//colisao com o chao
checa_chao = function () {
    
    chao = place_meeting(x, y + 10, colisor);  
    teto = place_meeting(x,y-25,colisor);
    //se eu estiver no chao e não estiver na escada, faço meu Y desenhar corretamente na tela
    //and !escada 
    if chao  { 
        y = round(y);
    };
    
}


estado_subindo  = new estado();
estado_descendo = new estado();

//SUBINDO!
estado_subindo.inicia = function (){
    
    
}

estado_subindo.roda = function () {
    
    
    velv = -vel_plataforma;
    
    if teto {
        troca_estado(estado_descendo);
    }
    
    
    
    
}

estado_subindo.finaliza = function () {
    
    
}

//DESCENDO!
estado_descendo.inicia = function (){
    
    
}

estado_descendo.roda = function () {
    
    //descendo
    velv = 0.4;
    
    if chao {
        troca_estado(estado_subindo);
    }
    
    
}

estado_descendo.finaliza = function () {
    
    
}

inicia_estado(estado_descendo);