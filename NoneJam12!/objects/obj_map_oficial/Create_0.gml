// Tamanho de cada tile real
tile_size = 16;

// Tamanho de cada tela
tela_size = 320;      // largura
tela_altura = 180;    // altura

// Escala de exibição no minimapa
escala = 1;

// Quantidade de telas no mapa
cols = room_width div tela_size;
lins = room_height div tela_altura;

// Tiles por tela
tiles_x = tela_size div tile_size;      // 20
tiles_y = tela_altura div tile_size;    // 11 (mas sobra 4px!)


// Descoberta de telas
descoberto = array_create(cols);

for (var i = 0; i < cols; i++) {
    descoberto[i] = array_create(lins, false);
}


// Tilemap
var _layer = layer_get_id("Map");
tilemap_id = layer_tilemap_get_id(_layer);


// Grade completa de tiles do mapa
var total_tiles_x = room_width div tile_size;
var total_tiles_y = room_height div tile_size;

level = array_create(total_tiles_x);

for (var i = 0; i < total_tiles_x; i++) {
    level[i] = array_create(total_tiles_y, 0);
}

for (var j = 0; j < total_tiles_y; j++) {
    for (var i = 0; i < total_tiles_x; i++) {
        level[i][j] = tilemap_get(tilemap_id, i, j);
    }
}

mostra_mapa = false;