
// Alternar o mapa com Enter
var mapa_controle = (keyboard_check_pressed(ord("M"))) || gamepad_button_check_pressed(0,gp_select) || gamepad_button_check_pressed(0,gp_start);
if mapa_controle  {
    mostra_mapa = !mostra_mapa;
    escala = 1;
}

if mostra_mapa {
    var mais = keyboard_check_pressed(vk_up);
    var menos = keyboard_check_pressed(vk_down);
    var roda_cima = mouse_wheel_up()
    var roda_baixo = mouse_wheel_down()
    
    
    if mais {
        escala += 0.5;
    }
    if menos {
        escala -= 0.5;
    }
    
    if roda_cima {
        escala += 0.1;
    }
    
    if roda_baixo {
        escala -= 0.1;
    }
    
    escala = clamp(escala,.6,2.5);
}

if instance_exists(obj_player){
   // Marca como descoberta a tela atual
   var tela_x = obj_player.x div tela_size;
   var tela_y = obj_player.y div tela_altura;
   
   if (tela_x >= 0 && tela_x < cols && tela_y >= 0 && tela_y < lins) {
       descoberto[tela_x][tela_y] = true;
   }
}

