portal_fechado = new estado();
portal_aberto  = new estado();


//portal abrinbdo
portal_fechado.inicia = function (){
    sprite_index = spr_portal_abrindo;
}

portal_fechado.roda = function (){
    
    if image_index > image_number - 1 {
        troca_estado(portal_aberto);
    }
    
}

portal_fechado.finaliza = function  (){
    
    
}

//portal abert
portal_aberto.inicia = function (){
    sprite_index = spr_portal_estavel;
}

portal_aberto.roda = function (){
    
    
}

portal_aberto.finaliza = function  (){
    
    
}

inicia_estado(portal_fechado);