estado_porta = "fechada";

//timer para ela sumir
porta_some = 120;
porta_abrindo = false;
estados_da_porta = function () {
    
    switch (estado_porta) {
        
        case "fechada":
            
            image_index = 0;
            
            
            break;
        
        case "aberta":
            
            screenshake(2);
            image_index = 1;
            
            vspeed = -0.7; 
            
            porta_some--;
            
            if porta_some <= 0 {
                instance_destroy();
            }
            
            break;
    	
    }
    
}