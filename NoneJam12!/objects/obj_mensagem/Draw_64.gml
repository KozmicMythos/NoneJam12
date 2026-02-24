
//xx e yy
var _xx = 380;
var _yy = 580;
var _preto= c_black;
var _tela_h = 11640;
var _tela_v = 1640;
//desenhando um retangulo preto

if distance_to_object(obj_player) < distancia {
    
    //draw_set_font(fnt);
    draw_set_halign(fa_center);
    draw_set_valign(1);
    draw_rectangle_color(0,540,60+600,_yy+100,_preto,_preto,_preto,_preto,false);
    //draw_sprite_ext(spr_enter_txt,image_index,300,610,image_xscale * 2,image_yscale * 2,image_angle,image_blend,image_alpha);
    draw_text(_xx,_yy,mensagem);
    draw_set_font(-1);
    draw_set_halign(-1);
    draw_set_valign(-1);
    //instance_destroy();
}


/* 
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var altura_barra = 120; // altura da faixa preta

if distance_to_object(obj_player) < distancia {

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    // Retângulo preto ocupando TODA parte inferior
    draw_set_color(c_black);
    draw_rectangle(
        0,
        gui_h - altura_barra,
        gui_w,
        gui_h,
        false
    );

    // Texto centralizado na barra
    draw_set_color(c_white);
    draw_text(
        gui_w * 0.5,
        gui_h - altura_barra * 0.5,
        mensagem
    );

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
 */