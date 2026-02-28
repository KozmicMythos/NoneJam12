tem_mapa = true;
// Tamanho de cada tile real
tile_size = 16;

// Tamanho de cada tela
tela_size = 320;//horizontal
tela_altura = 180 // vertical

// Escala de exibição no minimapa
escala = 1;

// Quantidade de telas no mapa
cols = room_width div tela_size;
lins = room_height div tela_altura;

// Tiles por tela
tiles_x = tela_size div tile_size;
tiles_y = tela_altura div tile_size;

// Descoberta de telas
descoberto = array_create(cols, 0);
for (var i = 0; i < cols; i++) {
    descoberto[i] = array_create(lins, false);
}

// Tilemap
var _layer = layer_get_id("Map");
tilemap_id = layer_tilemap_get_id(_layer);

// Pega o conteúdo do tilemap e armazena em uma grade (por segurança)
level = array_create(cols * tiles_x);
    for (var i = 0; i < cols * tiles_x; i++) {
        level[i] = array_create(lins * tiles_y, 0);
    }

for (var j = 0; j < lins * tiles_y; j++) {
    for (var i = 0; i < cols * tiles_x; i++) {
        level[i][j] = tilemap_get(tilemap_id, i, j);
    }
}
//cores dos mapas
//cor_diferenciada = make_color_rgb(100, 140, 100);
verde = make_color_rgb(60, 140, 50);
vermelho = make_color_rgb(150, 30, 50);
verde_musgo = make_color_rgb(80, 200, 40);
azul_suave = make_color_rgb(100, 150, 255);
mostra_mapa = false;
cor = azul_suave;

//fazendo um check para ativar o pisca da nave, caso queira usar para quest