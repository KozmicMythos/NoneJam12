draw_self();

if !desenha_texto exit;

//Alinhando o texto
draw_set_font(fonte_pixel);

draw_set_halign(0);
draw_set_valign(0);
//Fazendo o texto voltar metade da sprite
var _marg_x = 2;
var _marg_y = 2;
var _x = x - sprite_width / 2 +_marg_x;
var _y = y + _marg_y;
var _larg = (sprite_width * 10) - (_marg_x - 20);
//draw_text_transformed(_x + _marg_x,y + _marg_y,texto,0.1,0.1,0);
draw_text_ext_transformed(_x, _y,texto,60 , _larg, .1,.1,0);

draw_set_font(-1);