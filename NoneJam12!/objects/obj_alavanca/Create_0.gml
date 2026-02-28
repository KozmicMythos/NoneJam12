timer_volta = 100;

estado_alavanca = "parado";

inicia_efeito_squash();

ativando_alavanca = function () {
    
   switch (estado_alavanca) {
       
       case "parado":
           
           image_speed = 0;
            
              if keyboard_check(vk_enter) and place_meeting(x,y,obj_player){
                efeito_squash(1.2,0.8);
                estado_alavanca = "ativando";
                //escolhendo a porta para abrir
                with(obj_porta){
                    
                    porta_abrindo = true;
                    //ARRUMAR ISSO DPS
                    if porta_id == "porta_1" { 
                        estado_porta = "aberta"; 
                    }
                    if porta_id == "porta_2"{
                        estado_porta = "aberta"; 
                    }
                }
            }
           
           break;
       
       case "ativando":
               
           image_speed = 1;
           
           if image_index > image_number - 1 {
                efeito_squash(1.2,0.8)
               estado_alavanca = "ativado";
           }
        
           break;
    
        case "ativado":
            
            image_speed = 0;
            
            image_index = image_number - 1;
            
            break; 
   	
   }
}