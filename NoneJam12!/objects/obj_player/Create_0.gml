//Variaveis de controle do personagem
velh         = 0;
velv         = 0;
max_velh     = 1;
max_velv     = 5;
grav         = .2;
pode_mexer   = true;
spd          = 1;
forca_pulo   = 3;
//colocando a direção
dir = 1;

//verificando os ovos opcionais
//global.ovinhos = 0;
if (!variable_global_exists("ovinhos")) global.ovinhos = 0;

//timer de morte do player
max_timer_morte = 60;
timer_morte = max_timer_morte;

//checando a escada
escada = 0;
//Colisores
lay_col  = layer_tilemap_get_id("Map");

mapa_verde = layer_tilemap_get_id("mapa_verde");

//colisor de morte
colisores_morte = [obj_bola_verde,obj_inimigo_gosma,obj_estaca,obj_olho_dano];

colisor_base = [lay_col, obj_chao, obj_check_escada, obj_plataforma,mapa_verde,obj_porta];

colisor_sem_check = [lay_col, obj_chao, obj_plataforma];

colisor = colisor_base;
//colisor      = [lay_col,obj_chao,obj_check_escada,obj_plataforma];

//Checando para saber se o player está em uma plataforma
plataforma_atual = noone;

//Iniciando o efeito squash
inicia_efeito_squash();

//timer para checar se o player pode pular ou nao
coyote_total_timer = 12;
coyote_timer       = coyote_total_timer;
ajuda_pulo         = false;

//Controles
left  = 0;
right = 0;
jump  = 0;
dash  = 0;


//check dos poderes e mapa
can_dash = true;
can_double_jump = true;


//qtd de pulos duplos
max_pulo_qtd = 2;
pulo_qtd = max_pulo_qtd;

//checando se pode ou nao pular depois que saiu da escada
check_pula_escada = 30;
pula_escada_timer = check_pula_escada;

//PARTE DO ESTADO TEXTO
mostra_pressiona_botao = false;
//timer para mostrar o botao
max_timer_mostra_botao = 80;
timer_mostra_botao = max_timer_mostra_botao;


//Dash variaveis
vel_dash = 6;
dash_timer = 10;
tempo_dash = dash_timer;
dei_dash = false;
//Agora impedindo com que o player dê dash o tempo todo
dash_temporizador_max = 50;
dash_temporizador = dash_temporizador_max;
pode_dash = true;
//quantidade de dash
max_dash = 1;
qtd_dash = max_dash;

//FUNÇÕES CÂMERA
cam_moving = false;
cam_target_x = 0;
cam_target_y = 0;


//PARTE COLETAVEIS
ovos_totais        = 5;
ovos_coletados     = 0;
//checando se peguei o ovo
pegou_ovo          = false;
max_timer_pega_ovo = 300;
timer_pega_ovo     = max_timer_pega_ovo;
hud_y              = 800;

//avisando que o jogo foi salvo
jogo_salvo = false;


pegando_ovo_timer = function () {
    
    if pegou_ovo {
        
        //diminuindo o timer
        timer_pega_ovo--;
        
        //Quando chegar em zero
        if timer_pega_ovo <= 0 {
            pegou_ovo = false;
            timer_pega_ovo = max_timer_pega_ovo;
        }
        
    }
    
}


#region COLISORES PLATAFORMA

//// Colisor padrão (com plataforma)
//colisor_padrao = [lay_col, obj_chao, obj_check_escada, obj_plataforma];
//
//// Colisor do frame quando estiver em cima da plataforma (sem plataforma)
//colisor_sem_plat = [lay_col, obj_chao];
//
//// Colisor usado no frame atual
//colisor_frame = colisor_padrao;


resolve_plataforma_e_colisor = function () {

    // não reseta colisor aqui (deixa sua escada/check em paz)
    plataforma_atual = noone;

    // detecta plataforma só quando estiver caindo/parado
    var p = instance_place(x, y + 1, obj_plataforma);

    if (p != noone && velv >= 0) {

        // cola no topo (isso evita "entrar" na plataforma)
        y += (p.bbox_top - bbox_bottom);

        // carrega o movimento dela (subindo e descendo)
        y += p.velv;
        
        // se estava caindo, zera pra não tremer
        if (velv > 0) velv = 0;

        plataforma_atual = p;
    }
};

atualiza_colisor_para_movimento = function () {
    // por padrão
    colisor = colisor_base;

    // se estou na escada OU subindo (pulo), sem check
    if (estado_atual == estado_ladder || velv < 0) {
        colisor = colisor_sem_check;
    }
};

#endregion

//CAMERA
move_camera = function () {
    
    //pegando o tamanho da camera
    static _gridx = 320, _gridy = 180;
    
    //variaveis para saber a posição do player na grid
    var _meux,_meuy;
    
    //dividindo o valor para q seja feito em grid
    _meux = (x div _gridx) * _gridx;
    _meuy = (y div _gridy) * _gridy;
    
    
    //dando suavidade para o movimeento
    var _suavidade = 0.08;
    var cam_x = lerp(camera_get_view_x(view_camera[0]),_meux,_suavidade);
    var cam_y = lerp(camera_get_view_y(view_camera[0]),_meuy,_suavidade);
    
    camera_set_view_pos(view_camera[0],cam_x,cam_y); 

}

//movimentacao
comandos = function  (){
     
    check_poderes();
    
    if pode_mexer {
        // Teclado (WASD + setas)
        right = keyboard_check(ord("D")) || keyboard_check(vk_right);
        left  = keyboard_check(ord("A")) || keyboard_check(vk_left);
        up    = keyboard_check(ord("W")) || keyboard_check(vk_up);
        down  = keyboard_check(ord("S")) || keyboard_check(vk_down);
        grab  = keyboard_check(ord("E"))
        
        if can_dash {
            dash  = keyboard_check_pressed(ord("K")) || keyboard_check_pressed(ord("X"));
        }
        
        // Gamepad Analógico
        var lx = gamepad_axis_value(0, gp_axislh); // Eixo horizontal esquerdo
        var ly = gamepad_axis_value(0, gp_axislv); // Eixo vertical esquerdo

        if (lx > 0.2) right = true;
        if (lx < -0.2) left  = true;
        if (ly < -0.2) up    = true;
        if (ly > 0.2) down  = true;

        // Gamepad D-Pad
        right = right || gamepad_button_check(0, gp_padr);
        left  = left  || gamepad_button_check(0, gp_padl);
        up    = up    || gamepad_button_check(0, gp_padu);
        down  = down  || gamepad_button_check(0, gp_padd);

        // Pulo (Teclado espaço ou controle face1)
        jump = keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_face1) 
        || keyboard_check_pressed(ord("Z"));
    };
 
};

check_poderes = function () {
    
   // if can_dash dash = keyboard_check_pressed(ord("K")) || gamepad_button_check_pressed(0, gp_face3); else dash = noone;
    
}

//colisao com o chao
checa_chao = function () {
    
    chao = place_meeting(x, y + 1, colisor);  
    
    //se eu estiver no chao e não estiver na escada, faço meu Y desenhar corretamente na tela
    //and !escada 
    if chao { 
        y = round(y);
    };
    
    if chao { 
        coyote_timer = coyote_total_timer;
        ajuda_pulo = true; 
        
    }else{
        if coyote_timer > 0 {
            coyote_timer--;
        }
    };
     
};

checa_escada = function (){
    
    
    escada = place_meeting(x,y,obj_escada);
    
};

//verifica escada

verifica_escada = function () {
    
    var colide_chao = place_meeting(x,y+1,colisor);
    var _check_escada = place_meeting(x,y+1,obj_check_escada)
    
    //Checando se posso ou não subir ou descer escada
    //SE estou colidindo com o chao abaixo
    if colide_chao and down {
        //nada acontece        
    }else if !colide_chao and down or up{ 
        //se eu nao estiver colidindo e apertar cima ou baixo
        sobe_escada();
    }
    
    
    
}

//Ajustando a direção
ajusta_xscale = function () { 

    if (velh != 0) dir = sign(velh);
    
};

caindo_sprite = function  (){
    
    if velv > 2 {
        //mask_index = spr_player;
        sprite_index = spr_player_fall;
    }
    
}

movimentacao_vertical = function () {
    
     //Se eu nao estiver no chão, eu caio
    
    if (!chao)
    {  
        if (velv < max_velv) velv += grav;  else velv = max_velv; 
            
        //if coyote_timer > 0 coyote_timer --;
        
    }
    else
    {
        //coyote_timer = coyote_total_timer;
        if velv != 0  {
            velv = 0;
            pulo_qtd = max_pulo_qtd;
        }
        
    };
    
    //Encostando no teto e caindo
    if place_meeting(x,y - 1 ,obj_chao){
        velv = 0.5;
    }
    
    
};

movimentacao_horizontal = function () {
    
    velh = (right - left) * spd;  
    
};

//checando se posso subirescada
pode_subir = true;
sobe_escada = function () {
    
    //verificando se o check colisor é um colisor ou nao
    
    var escada_atual = instance_place(x,y,obj_escada);
    var check_escada_atual = instance_place(x,y + 1,obj_check_escada); 

    //Se eu posso subir na escada então eu subo//quando encostar no chao voltar a poder subir
    if pode_subir {
        if escada_atual{
            if up { 
                x = escada_atual.x;
                troca_estado(estado_ladder)
            }
        }
    }
    
};

verifica_dash = function () {
    //momento em que eu apertei dash
    if pode_dash == false {
        dash_temporizador--;
    }
    
    if dash_temporizador  < 0 {
        pode_dash = true;
        dash_temporizador = dash_temporizador_max;
    }  
}

//efeito para pular o cogumelo
pula_saltador = function (){
    
    var coguma = instance_place(x,y + 2 ,obj_saltador);
    var caindo = velv > 0;
    
    //se eu pisar em cima do cogumelo
    var music = choose(snd_cogumelo,snd_cogumelo_1,snd_cogumelo_2)
    //Se o cogumelo estiver abaixo de mim e SE eu estiver caindo
    if coguma and caindo{  
        var limite = max_velv + .4;
        velv = -limite;
        audio_play_sound(music,0,0); 
        with(coguma){
            image_index = 0; 
            ativa_animacao = true;
        }
    }
    
};

//matando o player
mata_player = function () {
    
    var botao_do_capeta = keyboard_check(ord("J"));
    var _hurt = place_meeting(x,y,colisores_morte);
    
    
    if _hurt or botao_do_capeta {   
        //dir = choose(1,-1);   
         troca_estado(estado_morte);
    } 
    
}

//pegando os ovinhos menores
pegando_ovinhos = function (){
    
    var _ovinhos = instance_place(x,y,obj_ovos_bonus)
    
    if _ovinhos {
        
        global.ovinhos++;
        with(_ovinhos){
            instance_destroy();
        }
        
    }
    
};

//checando para ver se entrei no portal final
entra_portal = function (){
    
    var _portal = instance_place(x,y,obj_portal_final);
    if _portal{ 
         
        troca_estado(estado_portal);
    }
    
}




//Estados do player
estado_idle           = new estado();
estado_run            = new estado();
estado_jump           = new estado();
estado_parado         = new estado();
estado_ladder         = new estado();
estado_saindo_portal  = new estado();
estado_texto          = new estado();
estado_dash           = new estado();
estado_morte          = new estado();
estado_portal         = new estado();

#region IDLE

estado_idle.inicia = function () {
    sprite_index = spr_player;
    image_index = 0;
    
};

estado_idle.roda = function ()
{
    
    movimentacao_vertical();
    movimentacao_horizontal();
    ajusta_xscale();
    verifica_escada();
    entra_portal();
    mata_player();
    
    if jump and coyote_timer > 0{
        pulo_qtd--;
        //removendo a plataforma
        plataforma_atual = noone;
        velv = -forca_pulo;
        troca_estado(estado_jump);
        efeito_squash(.4,1.7);
    };
    
    //DASH    
    //se eu apertar dash
    if dash && pode_dash {
        troca_estado(estado_dash);
    }
    
    if velh != 0 {
        troca_estado(estado_run);
    }
    
    if !chao {
        troca_estado(estado_jump);
    }
    
    //SE apertar para baixo e estiver encostando no CHECK escada
    //então vou um pixel para baixo e meu estado é escada
    if down && place_meeting(x,y+1,obj_check_escada){ 
        y += 1;
        troca_estado(estado_ladder)
    }
    
    
     
};

estado_idle.finaliza = function () {
    
};

#endregion

#region  RUN

estado_run.inicia = function () {
    sprite_index = spr_player_run;
    image_index = 0;
};

estado_run.roda = function (){
   
    movimentacao_horizontal();
    movimentacao_vertical();
    ajusta_xscale();
    pula_saltador();
    entra_portal();
    mata_player();
    
    
  //ficando parado
    if velh == 0 {
        troca_estado(estado_idle); 
    };
    
    if jump and coyote_timer > 0 {
        pulo_qtd--;
        //removendo a plataforma
        plataforma_atual = noone;
        velv = -forca_pulo;
        troca_estado(estado_jump);
        //aplicando o efeito
        efeito_squash(.4,1.7);
    };
    
    if !chao and coyote_timer < 0 {
        troca_estado(estado_jump);
    };
    
    //se eu apertar dash     
    if dash && pode_dash {
        troca_estado(estado_dash);
    }
    
    //SE apertar para baixo e estiver encostando no CHECK escada
    //então vou um pixel para baixo e meu estado é escada
    if down && place_meeting(x,y+1,obj_check_escada){ 
        y += 1;
        troca_estado(estado_ladder)
    }
    
    
};

estado_run.finaliza = function () {
       
};

#endregion

#region JUMP

estado_jump.inicia = function () {
    
    sprite_index = spr_player_jump;
    image_index = 0;
    //colisor = colisor_sem_check;
};

estado_jump.roda = function (){
    
    caindo_sprite();
    movimentacao_vertical(); 
    movimentacao_horizontal();
    ajusta_xscale();
    pula_saltador();
    sobe_escada();
    entra_portal();
    mata_player();
    
    if chao {
        troca_estado(estado_idle);
        //aplicando o efeito
        efeito_squash(1.4,0.7);
    };
    
    //se eu apertar dash     
    if dash && pode_dash {
        troca_estado(estado_dash);
    }
    
    
    
    //fazendo o player nao ficar grudado em cima
    if place_meeting(x,y-1,colisor_base){
        velv += 0.1;
    };
    
    if !place_meeting(x,y,obj_escada){ 
        //colisor  = [obj_chao,lay_col,obj_check_escada]; 
        colisor      = colisor_base//[lay_col,obj_chao,obj_check_escada,obj_plataforma]; 
    };
    
    //DOUBLE JUMP
    if jump and pulo_qtd > 0 and can_double_jump{
        pulo_qtd--;
        //removendo a plataforma
        plataforma_atual = noone;
        velv = -forca_pulo;
        troca_estado(estado_jump);
        efeito_squash(.4,1.7);
    };
    
    
};

estado_jump.finaliza = function () {
    
};


estado_parado.inicia = function () {
    
}

estado_parado.roda = function () {
    
    velh = 0; 
    
}

estado_parado.finaliza = function () {
    
    
};

//ESTADO TEXTO

estado_texto.inicia = function(){
    
    pode_mexer = false;
    if velh != 0 velh = 0;
    if velv != 0 velv = 0;
    image_speed = 0; 
     
         
}

estado_texto.roda = function () {
    
    timer_mostra_botao--;
    
    if timer_mostra_botao <= 0 {
        //dizendo pra ele que pode desenhar o pressiona botao
        mostra_pressiona_botao = true;   
    }
    
    var butaum = keyboard_check(vk_enter) || gamepad_button_check(0,gp_face1);
    
    if butaum { 
        
        with(obj_poder_jump){
            //checando se eu peguei, aí posso sumir
            if pegou {
                pode_sumir = true;
            }
        }
        with(obj_poder_dash){
            //SE eu peguei então eu posso sumir
            if pegou {
                pode_sumir = true;
            }
        }
        
        
        
         
        timer_mostra_botao = max_timer_mostra_botao;
        mostra_pressiona_botao = false;
        troca_estado(estado_idle);
    };
    
   
    
    
    
}

estado_texto.finaliza = function () {
    
    pode_mexer = true;
    image_speed = 1;
    
}

//PORTAL

estado_saindo_portal.inicia = function () {
    sprite_index = spr_player_saindo_portal;    
}

estado_saindo_portal.roda = function () {
    
    movimentacao_vertical();
    velh = 0; 
    
    if chao {
        troca_estado(estado_idle);
        //Falando para o portal que eu posso fechar ele
        with(obj_portal){
            pode_fechar = true;
        }
    }
    
}

estado_saindo_portal.finaliza = function () {
    
    
};

//iniciando a escada
estado_ladder.inicia = function () {
     
    
    grav = 0;
    velh = 0;
    velv = 0; 
    sprite_index = spr_player_ladder; 
    colisor  = [obj_chao,lay_col,obj_plataforma];
    //colisor = colisor_sem_check;
    
}

estado_ladder.roda = function () {
    
    comandos();  
    //dando velocidade para cima e para baixo
    velv = (down - up) * spd; 
    image_speed = sign(velv);
    mata_player();
    
    ////escada
    //var _escada = place_meeting(x,y,escada);
    var _escada_atual = instance_place(x,y,obj_check_escada);
    if _escada_atual {
        x = _escada_atual.x;
    }
    
 
    
    ////se eu encostar no chao eu saio do estado ladder
    //if chao {
        //troca_estado(estado_idle);
    //}
    if !place_meeting(x,y,obj_escada){ 
        troca_estado(estado_idle);        
    }
    

    //se eu pular eu pulo? rs    
    if jump {
        colisor  = [obj_chao,lay_col,obj_plataforma];
        //se eu pular minha gravidade volta ao normal
        velv -= 3;
        troca_estado(estado_jump);   
    }
    
    //se eu estou descendo e o chão estiver proximo    
    if down and place_meeting(x,y + 1,colisor){    
        troca_estado(estado_idle);
    }

    
}

estado_ladder.finaliza = function () {
    //
    grav = 0.2; 
    y = round(y);
    image_speed = 1; 
    //fazendo com que ao sair da escada ele não pule
    //pulo_qtd = 0;
    
    if !place_meeting(x,y,obj_escada){ 
        colisor = [obj_chao,lay_col,obj_plataforma,obj_check_escada];
    }
    else
    {    
        colisor = [obj_chao,lay_col,obj_plataforma];
    }
};

estado_dash.inicia = function (){ 
    velv = 0;
    image_index = 0;
    //falando que eu iniciei o dash
    pode_dash = false; 
    //audio_play_sound(snd_dash,0,0);    
}

estado_dash.roda = function () {
    
    comandos();
    entra_portal();
    
    //dando um efeito maneiro
    efeito_squash(1.4,0.5);
     //timer_pode_dash--;  
	sprite_index = spr_player; 
	//criando meu rastro
	if (tempo_dash % 3 == 0){
		//obj_screenshake.shake = 4;
		var rastro = instance_create_depth(x,y,depth + 1,obj_rastro);
		//definindo as informações do rastro
		rastro.sprite_index = sprite_index;
		rastro.image_index = image_index;
		rastro.image_speed = 0;
		rastro.image_xscale = xscale * dir;
        
	} 
	tempo_dash --;
	
	//velv = 0;	
	if !dei_dash {
           var _dir = keyboard_check(ord("D")) || right;
           var _esq = keyboard_check(ord("A")) || left;
           
           var h = _dir - _esq; // 1 direita, -1 esquerda, 0 nada
           
           if (h != 0) {
               velh = h * vel_dash;
               dir = h; // atualiza direção do personagem
           } else {
               velh = dir * vel_dash; // dash na última direção
           }
			
			
			//avisando que dei o dash
			dei_dash = true; 
		}
	
		if tempo_dash <= 0 {
			tempo_dash = dash_timer;
			dei_dash = false;
            troca_estado(estado_idle); 
		} 
    
    //fazendo com que se eu atacadr enquanto estiver dando dash, no final da animação vou pro ataque
    //pode_morrer();
}

estado_dash.finaliza = function () {
    
    velh = 0;
    
};

estado_portal.inicia = function () {
    image_index = 0;
    sprite_index = spr_player_portal_final;
    
}

estado_portal.roda = function () {
    
    velh = 0;
    velv = 0;
    var _xx = obj_portal_final.x;
    var _yy = obj_portal_final.y;
    
    x = lerp(x,_xx,0.1);
    y = lerp(y,_yy,0.1);
    
    image_angle-= 10;
   
    if image_index > image_number - 1 {
        room_goto(room_cutscene_final);
    }
    
}

estado_portal.finaliza = function () {
    
    
}

//Começando o estado de morte do player
estado_morte.inicia = function () {
    
    sprite_index = spr_player_death;
    image_index = 0;
    screenshake(12);
    audio_play_sound(snd_death,0,0);
    
}

estado_morte.roda = function () {
    
    movimentacao_vertical();
    
    if velh != 0 velh = 0 ;
  
   
    if image_index > image_number - 1 {
        load_game();
    }
        
    
}

estado_morte.finaliza = function (){
    
    
}


//verifica poderes
check_poderes = function () {
    //checando se o player tem os poderes
    if (global.tem_dash){
        can_dash = true;
    }
    if (global.tem_double_jump){
        can_double_jump = true;
    }
    
}


//Colocando o estado para rodar
inicia_estado(estado_saindo_portal);
