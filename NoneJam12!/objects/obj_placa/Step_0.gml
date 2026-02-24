//Check de colisao com player
var _player = place_meeting(x,y,obj_player);

//Se eu colidi com o player ue crio a caixa
if _player { 
    if !instance_exists(caixa_dialogo){
        //criando a caixa
        caixa_dialogo = instance_create_layer(x,y - 20,"dialogo",obj_caixa_dialogo);
        //dando o texto 
        caixa_dialogo.texto = texto;

    }; 
}else{
    //se a caixa existe
    if instance_exists(caixa_dialogo){
        //eu destruo ela
        caixa_dialogo.me_destruir = true;
    }
    
}
