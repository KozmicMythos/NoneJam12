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

//checando a escada
escada = 0;
//Colisores
lay_col  = layer_tilemap_get_id("Map");
colisor      = [lay_col,obj_chao,obj_check_escada,obj_plataforma];

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




//FUNÇÕES CÂMERA
cam_moving = false;
cam_target_x = 0;
cam_target_y = 0;


#region COLISORES PLATAFORMA

// Colisor padrão (com plataforma)
colisor_padrao = [lay_col, obj_chao, obj_check_escada, obj_plataforma];

// Colisor do frame quando estiver em cima da plataforma (sem plataforma)
colisor_sem_plat = [lay_col, obj_chao, obj_check_escada];

// Colisor usado no frame atual
colisor_frame = colisor_padrao;


// resolve plataforma + escolhe colisor do frame
resolve_plataforma_e_colisor = function () {

    plataforma_atual = noone;
    colisor_frame = colisor_padrao;

    // só considera plataforma se estiver caindo/parado
    var p = instance_place(x, y + 1, obj_plataforma);

    if (p != noone && velv >= 0) {

        // cola exatamente no topo
        y += (p.bbox_top - bbox_bottom);

        // carrega com a plataforma (serve pra subir e descer)
        y += p.velv;

        // se estava caindo, zera pra não tremer
        if (velv > 0) velv = 0;

        plataforma_atual = p;

        // enquanto estiver em cima, NÃO colida com a plataforma
        colisor_frame = colisor_sem_plat;
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
     
    if pode_mexer {
        // Teclado (WASD + setas)
        right = keyboard_check(ord("D")) || keyboard_check(vk_right);
        left  = keyboard_check(ord("A")) || keyboard_check(vk_left);
        up    = keyboard_check(ord("W")) //|| keyboard_check(vk_up);
        down  = keyboard_check(ord("S")) //|| keyboard_check(vk_down);
        grab  = keyboard_check(ord("E"))
        
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

//colisao com o chao
checa_chao = function () {
    
    chao = place_meeting(x, y + 1, colisor);  
    
    //se eu estiver no chao e não estiver na escada, faço meu Y desenhar corretamente na tela
    //and !escada 
    if chao  { 
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
    
}


//Estados do player
estado_idle          = new estado();
estado_run           = new estado();
estado_jump          = new estado();
estado_parado        = new estado();
estado_ladder        = new estado();
estado_saindo_portal = new estado();
estado_texto         = new estado();


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
    
    if jump and coyote_timer > 0 {
        //removendo a plataforma
        plataforma_atual = noone;
        velv = -forca_pulo;
        troca_estado(estado_jump);
        efeito_squash(.4,1.7);
    };
    
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
    
    
    
  //ficando parado
    if velh == 0 {
        troca_estado(estado_idle); 
    };
    
    if jump and coyote_timer > 0 {
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
};

estado_jump.roda = function (){
    
    caindo_sprite();
    movimentacao_vertical(); 
    movimentacao_horizontal();
    ajusta_xscale();
     
    
    
    if chao {
        troca_estado(estado_idle);
        //aplicando o efeito
        efeito_squash(1.4,0.7);
    };
    
    
    
    //fazendo o player nao ficar grudado em cima
    if place_meeting(x,y-1,colisor){
        velv += 0.1;
    };
    
    if !place_meeting(x,y,obj_escada){ 
        //colisor  = [obj_chao,lay_col,obj_check_escada]; 
        colisor      = [lay_col,obj_chao,obj_check_escada,obj_plataforma]; 
    }
    
    
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
    
    var butaum = keyboard_check(vk_enter) || gamepad_button_check(0,gp_face1);
    
    if butaum { 
        troca_estado(estado_idle);
    }
    
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
    
}

estado_ladder.roda = function () {
    
    comandos(); 
    
    //dando velocidade para cima e para baixo
    velv = (down - up) * spd; 
    image_speed = sign(velv);
    
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
    //
    //se eu pular eu pulo? rs    
    if jump {
        //se eu pular minha gravidade volta ao normal
        velv -= 2;
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
     //se eu estou na escada 
    //colisor  = [obj_chao,obj_plataforma,lay_col,obj_check_escada,lay_col_2];
    
    if !place_meeting(x,y,obj_escada){ 
        colisor  = [obj_chao,lay_col,obj_check_escada,obj_plataforma];
    }
    else
    {    
        colisor  = [obj_chao,lay_col,obj_plataforma];
    }
}


//Colocando o estado para rodar
inicia_estado(estado_saindo_portal);
