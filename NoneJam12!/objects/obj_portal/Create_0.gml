portal_nascendo  = new estado();
portal_aberto    = new estado();
portal_fechando  = new estado();

//timer para o portal jogar o player para fora
max_joga_player = 100;
joga_player = max_joga_player;

//Check de portal
pode_fechar = false;

//portal abrinbdo
portal_nascendo .inicia = function (){
    sprite_index = spr_portal_abrindo;
    image_index = 0;
}

portal_nascendo .roda = function (){
    
    if image_index > image_number - 1 {
        troca_estado(portal_aberto);
    }
    
}

portal_nascendo .finaliza = function  (){
    
    
}

//portal abert
portal_aberto.inicia = function (){
    sprite_index = spr_portal_estavel;
    image_index = 0;
}

portal_aberto.roda = function (){
    
    joga_player--;
    
    if joga_player <= 0 {
        if !instance_exists(obj_player){
            
            var _player = instance_create_depth(x,y,depth-1,obj_player);
            //var _player = instance_create_layer(x,y,"player",obj_player)
        }
    };
    
    if pode_fechar {
        
        troca_estado(portal_fechando);
        
    }
    
}

portal_aberto.finaliza = function  (){
    
    
}
//portal abert
portal_fechando.inicia = function (){
    
    sprite_index = spr_portal_fechando;
    image_index = 0;
    
}

portal_fechando.roda = function (){
    
    if image_index > image_number - 1 {
        instance_destroy()
    }
    
}

portal_fechando.finaliza = function  (){
    
    
}

inicia_estado(portal_nascendo);