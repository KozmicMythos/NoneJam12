estados = "parado";
lay_col  = layer_tilemap_get_id("Map");
range = 200;
tempo_destroi = 100;
destroi = false;
muda_estado = function () {
    
    
    switch (estados) {
        
        case "parado":
            
            y = ystart;
            hspeed = 0;
            if distance_to_object(obj_player) < range {
                
                estados = "correndo";
            }
            
            break;
        
        case "correndo":
            
            
            sprite_index = spr_inimigo_run;
            hspeed = -1;
            
            var _esquerda = place_meeting(x-1,y,lay_col)
            var _direita  = place_meeting(x+1,y,lay_col);
            
            if _esquerda or _direita { 
                estados = "parado";
                destroi = true;
            }
            
            if instance_place(x,y,obj_player){
                estados = "parado";
                destroi = true;
            }
            
            
            break;
        
    	
    }
    
}