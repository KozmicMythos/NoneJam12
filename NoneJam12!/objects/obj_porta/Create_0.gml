estado_porta = "fechada";

estados_da_porta = function () {
    
    switch (estado_porta) {
        
        case "fechada":
            
            image_index = 0;
            
            
            break;
        
        case "aberta":
            
            image_index = 1;
            
            vspeed = -0.7;
            
            
            break;
    	
    }
    
}