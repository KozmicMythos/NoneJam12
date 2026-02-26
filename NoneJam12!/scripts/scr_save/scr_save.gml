function save_game()
{
    var dados = {
        jogador: undefined,
        mapa: undefined,
        ovos: undefined,
        poderes: undefined
    };

    // Salvando os dados do jogador
    with (obj_player)
    {
        dados.jogador = {
            object: object_get_name(object_index),
            x: x,
            y: y
            //can_dash: can_dash,
            //can_grab: can_grab
        };
    }

    // Salvando o estado do mapa
    with (obj_map)
    {
        dados.mapa = {
            tem_mapa : tem_mapa,
            cols: cols,
            lins: lins,
            descoberto: descoberto
        };
    }
    //Salvando os ovos
    dados.ovos = {
        ovo1: global.ovo1,
        ovo2: global.ovo2,
        ovo3: global.ovo3,
        ovo4: global.ovo4,
        ovo5: global.ovo5
    };
    
    //Salvando os poderes
    dados.poderes = {
        tem_dash: global.tem_dash,
        tem_double_jump: global.tem_double_jump
    };

    // Transformando a estrutura em string e salvando
    var _string = json_stringify(dados);
    var _file = file_text_open_write("save.txt");
    file_text_write_string(_file, _string);
    file_text_close(_file);
}


function load_game()
{
    if (file_exists("save.txt"))
    {
        var _file = file_text_open_read("save.txt");
        var _json = file_text_read_string(_file);
        file_text_close(_file);

        var _dados = json_parse(_json);

        // Destroi o player atual
        instance_destroy(obj_player);

        // Cria o novo player com os dados salvos
        var _struct = _dados.jogador;
        var _inst = instance_create_layer(_struct.x, _struct.y, "player", obj_player);
                 // --- aplicar poderes no player criado ---
         _inst.can_dash = global.tem_dash;
         _inst.can_double_jump = global.tem_double_jump;
        
        //poderes
        
        if (global.tem_dash) with (obj_poder_dash) instance_destroy();
        if (global.tem_double_jump) with (obj_poder_jump) instance_destroy();
            
        // carregar poderes do save
        global.tem_dash        = _dados.poderes.tem_dash;
        global.tem_double_jump = _dados.poderes.tem_double_jump;
       

        //_inst.can_dash         = _struct.can_dash;
        //_inst.can_grab         = _struct.can_grab;
        //_inst.itens_coletados  = _struct.itens_coletados;

        //Carregando os dados do mapa
        var _mapa = _dados.mapa;
        with (obj_map)
        {
            tem_mapa   = _mapa.tem_mapa;
            cols       = _mapa.cols;
            lins       = _mapa.lins;
            descoberto = _mapa.descoberto;
        }
        
        // carregar flags
        global.ovo1 = _dados.ovos.ovo1;
        global.ovo2 = _dados.ovos.ovo2;
        global.ovo3 = _dados.ovos.ovo3;
        global.ovo4 = _dados.ovos.ovo4;
        global.ovo5 = _dados.ovos.ovo5;
        
        var _total = 0;
          _total += global.ovo1;
          _total += global.ovo2;
          _total += global.ovo3;
          _total += global.ovo4;
          _total += global.ovo5;
          
          _inst.ovos_coletados = _total;
        
        // destruir ovos que não podem nascer mais
        if (global.ovo1) with (obj_ovo_1) instance_destroy();
        if (global.ovo2) with (obj_ovo_2) instance_destroy();
        if (global.ovo3) with (obj_ovo_3) instance_destroy();
        if (global.ovo4) with (obj_ovo_4) instance_destroy();
        if (global.ovo5) with (obj_ovo_5) instance_destroy();
            
        
        


                
    }
}
