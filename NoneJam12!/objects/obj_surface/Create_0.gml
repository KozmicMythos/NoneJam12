//Criando a surface
surf = surface_create(room_width,room_height);

//variavel q controla a iluminação geral
iluminacao = 0.4;



//Criando um método para acessar a surface
//surface padrão

desenha_surface = function(){
	//se a minha surface n  existe, eu crio
	if !surface_exists(surf){		
		//Crio a surface
		surf = surface_create(room_width,room_height);
		//Definir meu alvo
		surface_set_target(surf);
		//Limpar surface
		draw_clear_alpha(c_black,0);
		//Resetando o alvo ( voltando a ver a surface correta)
		surface_reset_target();		
	}
	//se a surface existe então eu desenho ela
	else{
		draw_surface(surf,0,0);
	}
	
}

sistema_iluminacao = function(){
    
	var rand = random_range(0.6,0.7);
	if surface_exists(surf){
		
		surface_set_target(surf);
        //para mudar a densidade do preto da tela
		draw_clear_alpha(c_black,iluminacao);
		
		//mudar o blendmode do desenho
		gpu_set_blendmode(bm_subtract);
	
		#region iluminação
	    
		//desenhando a luz
		var tam = random_range(-0.2,0.3);	
		var alpha = random_range(0.4,0.5); 
		//gpu_set_blendmode(bm_add);
        
		
          //with(obj_player){    
            //draw_sprite_ext(sprite_index,image_index,x,y,image_xscale , image_yscale,image_angle,c_purple,0.5); 
        //}
         gpu_set_blendmode(bm_subtract);
       
        with(obj_player){
            // Efeito de piscar
            //var piscar = abs(sin(current_time / 500.0));
            draw_sprite_ext(spr_luz,image_index,x,y,image_xscale , image_yscale ,image_angle,image_blend,1); 
        }

        with(obj_save_station){
            // Efeito de piscar
            var piscar = abs(sin(current_time / 500.0));
            draw_sprite_ext(spr_luz,image_index,x,y - sprite_height + 10,image_xscale , image_yscale ,image_angle,image_blend,piscar); 
        }
        with(obj_placa){
            // Efeito de piscar
            var piscar = abs(sin(current_time / 500.0));
            draw_sprite_ext(spr_luz,image_index,x,y - sprite_height + 10,image_xscale , image_yscale ,image_angle,image_blend,image_alpha); 
        }

		
		#endregion
        
        #region  INIMIGOS
        
        /*
        with(obj_bichim_azul){
             draw_sprite_ext(spr_luz,image_index,x,y,image_xscale, image_yscale ,image_angle,image_blend,image_alpha);
        }
        with(obj_olho_dano) {
             draw_sprite_ext(spr_luz,image_index,x,y,image_xscale , image_yscale ,image_angle,image_blend,image_alpha);          
        }
        
        #endregion
		*/
		//resetando o blendmode
		gpu_set_blendmode(0);
       

		surface_reset_target();	
        
		
	}
}