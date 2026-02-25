mask_index = spr_player;
move_camera();
checa_chao();
comandos();
roda_estado();
verifica_dash();

resolve_plataforma_e_colisor();
//movimentacao horizontal
move_and_collide(velh,0,colisor,22);
//movimentacao vertical
move_and_collide(0,velv,colisor,22);


//retornando o valor original
retorna_squash();

if keyboard_check(vk_escape) game_restart()
if keyboard_check(vk_enter) save_game()
if keyboard_check(vk_backspace) load_game()
if keyboard_check(ord("O")) global.mapa = true;
    