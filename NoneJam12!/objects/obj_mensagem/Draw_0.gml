draw_self();
var enter = keyboard_check(vk_enter) || gamepad_button_check(0,gp_face1);
//nao mostro minha sprite ao menos que o player chegue perto
if distance_to_object(obj_player) < distancia{
    draw_sprite(sprite_index,image_index,obj_player.x,obj_player.y - 12); 
    with(obj_player){
        troca_estado(estado_texto); 
    }
    
    if enter { 
        instance_destroy();   
    }
        //if texto == "quarto_texto"{
            //if !instance_exists(obj_soundtrack) {
                //instance_create_layer(x,y,layer,obj_soundtrack);
            //}
        //}
        //
        //audio_play_sound(snd_enter,0,0); 
        //instance_destroy();
        //}
}