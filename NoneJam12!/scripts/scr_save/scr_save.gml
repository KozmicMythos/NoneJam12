function save_game()
{
    var dados = {
        jogador: undefined,
        mapa: undefined
    };

    // Salvando os dados do jogador
    with (obj_player)
    {
        dados.jogador = {
            object: object_get_name(object_index),
            x: x,
            y: y,
            //can_dash: can_dash,
            //can_grab: can_grab
        };
    }

    // Salvando o estado do mapa
    with (obj_map)
    {
        dados.mapa = {
            cols: cols,
            lins: lins,
            descoberto: descoberto
        };
    }

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
        //_inst.can_dash         = _struct.can_dash;
        //_inst.can_grab         = _struct.can_grab;
        //_inst.itens_coletados  = _struct.itens_coletados;

        //Carregando os dados do mapa
        var _mapa = _dados.mapa;
        with (obj_map)
        {
            cols       = _mapa.cols;
            lins       = _mapa.lins;
            descoberto = _mapa.descoberto;
        }
    }
}
