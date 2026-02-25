draw_sprite_ext(sprite_index,image_index,x,y,xscale * dir,yscale,image_angle,image_blend,image_alpha);

var hit_tile = place_meeting(x, y-1, lay_col);
var hit_chao = place_meeting(x, y-1, obj_chao);
var hit_plat = place_meeting(x, y-1, obj_plataforma);
var hit_esc = place_meeting(x, y-1, obj_check_escada);

//draw_set_font(fnt_texto)
//draw_text_transformed(x,y-20,plataforma_atual,0.5,0.5,0);

draw_text(x,y-20,pulo_qtd)

