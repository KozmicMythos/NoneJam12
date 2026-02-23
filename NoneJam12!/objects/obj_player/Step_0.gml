//mask_index = spr_player_idle;

checa_chao();
comandos();
roda_estado();

//movimentacao horizontal
move_and_collide(velh,0,colisor,22);
//movimentacao vertical
move_and_collide(0,velv,colisor,22);

//retornando o valor original
retorna_squash();

//teste!"