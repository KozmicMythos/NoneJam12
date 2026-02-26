var player = instance_place(x,y,obj_player);

if player { 
    //fazendo o ovo subir
    sobe = true;
    
    with(player){
        pegou_ovo = true;
    }
       
}
       
if sobe {
    y-= 0.5;
    image_alpha -= 0.02; 
}

if image_alpha <= 0 { 
    instance_destroy();
} 

