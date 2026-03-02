
//NOVO MAPA

if mostra_mapa {
    
    /*
    var mini_tile = tile_size * escala;
    var mini_tela = tela_altura * escala;
    
    // Offset centralizado no jogador
    var tela_central_x = obj_player.x div tela_size;
    var tela_central_y = obj_player.y div tela_altura ;
    var offset_x = tela_central_x * mini_tela - display_get_gui_width() / 2 + mini_tela / 2;
    var offset_y = tela_central_y * mini_tela - display_get_gui_height() / 2 + mini_tela / 2;
    */
    var mini_tile = tile_size * escala;

    // tamanho da tela (320x180) no minimapa, em pixels
    var mini_screen_w = tela_size   * escala;
    var mini_screen_h = tela_altura * escala;
    
    // qual tela o player está
    var tela_central_x = floor(obj_player.x / tela_size);
    var tela_central_y = floor(obj_player.y / tela_altura);
    
    // centro da GUI
    var gui_cx = display_get_gui_width()  * 0.5;
    var gui_cy = display_get_gui_height() * 0.5;
    
    // centro da tela atual, em coordenadas do "mundo do minimapa"
    var screen_center_x = (tela_central_x * mini_screen_w) + (mini_screen_w * 0.5);
    var screen_center_y = (tela_central_y * mini_screen_h) + (mini_screen_h * 0.5);
    
    // offset final (tudo que você desenhar em "mundo minimapa" - offset = GUI)
    var offset_x = screen_center_x - gui_cx;
    var offset_y = screen_center_y - gui_cy;
    
    //fazendo o mapa ficar escuro // Criando um quadrado para deixar um efeito escuro
    draw_set_alpha(0.7)
    draw_set_color(c_black)
    draw_rectangle(0,0,1520,1520,false);
    draw_set_color(c_white)
    draw_set_alpha(1);
    
    //pegando a metade da tela
    image_speed = 0.05; 
    draw_sprite_ext(spr_mapa_indicador,image_index,gui_cx,660,3,3,0,image_blend,1);
    for (var tx = 0; tx < cols; tx++) {
        for (var ty = 0; ty < lins; ty++) {
            if descoberto[tx][ty] {
                // Dentro da tela descoberta, desenhar os tiles reais
                for (var i = 0; i < tiles_x; i++) {
                    for (var j = 0; j < tiles_y; j++) {
                        var real_x = tx * tiles_x + i;
                        var real_y = ty * tiles_y + j;

                        var tile = level[real_x][real_y];

                        if tile != 0 {
                            var draw_x = real_x * mini_tile - offset_x;
                            var draw_y = real_y * mini_tile - offset_y;

                            // Checa se está visível na GUI
                            if draw_x + mini_tile > 0 && draw_y + mini_tile > 0 &&
                               draw_x < display_get_gui_width() && draw_y < display_get_gui_height() {
                                draw_set_color(cor); 
                                draw_rectangle(draw_x, draw_y, draw_x + mini_tile, draw_y + mini_tile, false);
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    //desenhando a escada
     // Lista de objetos e seus sprites correspondentes
            var obj_list = [
                [obj_escada, spr_escada],
                [obj_save_station, spr_save_station],
                [obj_placa,spr_placa]
            ];
            
            // Pegando os valores do minimapa antes do 'with'
            var _escala    = escala;
            var _offset_x  = offset_x;
            var _offset_y  = offset_y;
            var _tela_size = tela_size;
            var _tela_altura = tela_altura;
            
            // Loop nos objetos
            for (var i = 0; i < array_length(obj_list); i++) {
                var obj_ref   = obj_list[i][0]; // o objeto
                var spr_ref   = obj_list[i][1]; // o sprite correspondente
                
                
                with (obj_ref) {
                    var tx = x div _tela_size;
                    var ty = y div _tela_altura;
            
                    if (other.descoberto[tx][ty]) {
                        var mx = x * _escala - _offset_x;
                        var my = y * _escala - _offset_y;
            
                        //draw_sprite(spr_ref, image_index, mx , my ); 
                        draw_sprite_ext(spr_ref, image_index, mx , my ,image_xscale * _escala,image_yscale * _escala,image_angle,image_blend,image_alpha); 
                    }
                }
            } 
               // Desenhando o player no minimapa
               if instance_exists(obj_player) {
                   // Posição da nave no mapa
                   var nave_x = obj_player.x;
                   var nave_y = obj_player.y;
               
                   // Qual tela a nave está?
                   var tela_nave_x = nave_x div tela_size;
                   var tela_nave_y = nave_y div tela_altura;
               
                   if (tela_nave_x >= 0 && tela_nave_x < cols && tela_nave_y >= 0 && tela_nave_y < lins)
                   {
                       if descoberto[tela_nave_x][tela_nave_y] {
                           
                           var nx = nave_x * escala - offset_x;
                           var ny = nave_y * escala - offset_y;
                   
                           
                           var _lado = obj_player.dir;
                           draw_set_color(c_blue); 
                           draw_sprite_ext( spr_player, image_index, nx, ny, image_xscale * escala * _lado, image_yscale * escala, image_angle, image_blend, image_alpha );
                           draw_set_color(c_white)
                        }
                      } 
                    } 
    
        
           
     }


    /*
    // Desenhar a nave (ou outros objetos) no minimapa
    if instance_exists(obj_plantas) {
        // Posição da nave no mapa
        var nave_x = obj_plantas.x;
        var nave_y = obj_plantas.y;
    
        // Qual tela a nave está?
        var tela_nave_x = nave_x div tela_size;
        var tela_nave_y = nave_y div tela_size;
    
        // Só mostra se a tela foi descoberta
        if descoberto[tela_nave_x][tela_nave_y] {
            // Posição da nave no minimapa
            var nx = nave_x * escala - offset_x;
            var ny = nave_y * escala - offset_y;
    
            // Efeito de piscar
            var piscar = abs(sin(current_time / 200.0));
    
            //draw_set_alpha(piscar);
            draw_set_color(c_blue);
            draw_sprite(spr_planta_1,0,nx,ny)
            //draw_circle(nx, ny - 5, 5, false); // ícone da nave (círculo)
            draw_set_alpha(1);
            draw_set_color(c_white);
            
            }
            
    }
    
        /* Desenhar a nave (ou outros objetos) no minimapa
        if instance_exists(obj_plantas) {
            // Posição da nave no mapa
            var nave_x = obj_plantas.x;
            var nave_y = obj_plantas.y;
        
            // Qual tela a nave está?
            var tela_nave_x = nave_x div tela_size;
            var tela_nave_y = nave_y div tela_size;
        
            // Só mostra se a tela foi descoberta
            if descoberto[tela_nave_x][tela_nave_y] {
                // Posição da nave no minimapa
                var nx = nave_x * escala - offset_x;
                var ny = nave_y * escala - offset_y;
        
                // Efeito de piscar
                var piscar = abs(sin(current_time / 200.0));
        
                //draw_set_alpha(piscar);
                draw_set_color(c_blue);
                //draw_sprite(spr_planta_1,image_index,nx,ny)
               // draw_circle(nx, ny - 5, 5, false); // ícone da nave (círculo)
                draw_set_alpha(1);
                
                }
                
        }
            // ========================
            // DESENHAR OBJETOS NO MAPA
            // ========================
            // Lista de objetos e seus sprites correspondentes
            var obj_list = [
                [obj_checkpoint, spr_checkpoint],
                [obj_plantas, spr_planta_1], 
                [obj_garra,spr_garra] 
            ];
            
            // Pegando os valores do minimapa antes do 'with'
            var _escala    = escala;
            var _offset_x  = offset_x;
            var _offset_y  = offset_y;
            var _tela_size = tela_size;
            
            // Loop nos objetos
            for (var i = 0; i < array_length(obj_list); i++) {
                var obj_ref   = obj_list[i][0]; // o objeto
                var spr_ref   = obj_list[i][1]; // o sprite correspondente
                
                with (obj_ref) {
                    var tx = x div _tela_size;
                    var ty = y div _tela_size;
            
                    if (other.descoberto[tx][ty]) {
                        var mx = x * _escala - _offset_x;
                        var my = y * _escala - _offset_y;
            
                        //draw_sprite(spr_ref, image_index, mx , my ); 
                        draw_sprite_ext(spr_ref, image_index, mx , my ,image_xscale * _escala,image_yscale * _escala,image_angle,image_blend,image_alpha); 
                    }
                }
            }
        //Desenhando o player no final de tudo

        #region Player
            
            // Desenha o jogador no centro
            var px = obj_player.x * escala - offset_x;
            var py = obj_player.y * escala - offset_y;
        
            draw_set_color(c_red);
            //draw_sprite(spr_player,image_index,px,py);
            // Efeito de piscar
            var pisca = abs(sin(current_time / 200.0));
            
            draw_set_alpha(pisca);
            //draw_circle(px, py-4, 3, false);
            //draw_rectangle(px - 1,py-4 * escala,px+4 * escala ,py,false);
            //Podemos colocar a imagem do player aqui:
            draw_sprite_ext(spr_player,image_index,px,py,image_xscale * escala,image_yscale * escala,image_angle,image_blend,image_alpha)
            draw_set_alpha(1);
            
        #endregion
}


#region 



/* Antigo mapa
if mostra_mapa {
    
    
    // Cálculo da posição central com base na posição do player
    var offset_x = obj_player.x * escala - (view_wport[0] / 2);
    var offset_y = obj_player.y * escala - (view_hport[0] / 2);
    for(var i = 0;i<cols;i++){
        for(var j = 0;j<lins;j++){
            //Checando se eu devo desenhar na celula atual
            if level [i][j] != 0 { 
                //DESENHANDO
                //origem no começo do mapa
                // _tam = tamanho * escala;
                //draw_rectangle(i * _tam,j * _tam,(i+1) * _tam,(j+1) * _tam,false);
                
                ////origem a partir do play
                var _tam = tamanho * escala; 
                //// Agora desenhamos o minimapa com esse offset aplicado
                var draw_x = i * _tam - offset_x;
                var draw_y = j * _tam - offset_y;
                 //
                //if level[i][j] != 0 && descoberto[i][j] {
                    //draw_set_alpha(1);
                    //draw_set_color(cor); // cor normal do minimapa
                    //draw_rectangle(draw_x, draw_y, draw_x + _tam, draw_y + _tam, false);
                //}
                
                #region FUNCIONANDO
                
                
                if draw_x >= 0 && draw_y >= 0 && draw_x < display_get_gui_width() && draw_y < display_get_gui_height() && descoberto[i][j]{
                    ////draw_rectangle(draw_x, draw_y, draw_x + _tam, draw_y + _tam, false);
                    
                    //draw_set_color(c_black); // marrom claro
                    draw_set_alpha(1);
                    //draw_rectangle(draw_x, draw_y, draw_x + _tam, draw_y + _tam, true); // preenchido
                    draw_set_color(cor);
                    draw_rectangle(draw_x, draw_y, draw_x + _tam, draw_y + _tam, false); // contorno preto                     
                    draw_set_alpha(1); 
                }
                #endregion
            
            }
            
        } 
    }
    
    //Desenhando o player
    if object_exists(obj_player){
        //var play_x = obj_player.x * escala;
        //var play_y = obj_player.y * escala;
        var play_x = obj_player.x * escala - offset_x;
        var play_y = obj_player.y * escala - offset_y;

        
        //draw_circle(play_x,play_y - 3 * escala,4 * escala,false)
        
        //draw_rectangle(play_x - 2,play_y - 4,play_x + 2,play_y,0);
        draw_sprite(spr_player,image_index,play_x,play_y);
    }
    
    timer += 0.09
    
    if object_exists(obj_nave){
        var nave_x = obj_nave.x * escala - offset_x;
        var nave_y = obj_nave.y * escala - offset_y;
        draw_sprite(spr_nave,image_index,nave_x,nave_y);
        //draw_circle_color(nave_x,nave_y-4,timer,c_aqua,c_black,0)
    }
    
    if timer > 5 {
        timer = 1
    }
}
 * /
 */