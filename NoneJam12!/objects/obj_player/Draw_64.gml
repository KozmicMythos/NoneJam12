var _xx = 120;
var _yy = 620;
var _marg = 4;
var _escala = 4;

// define o alvo dependendo do estado
var _alvo_y = pegou_ovo ? _yy : 1000;

// anima sempre (sobe ou desce)
hud_y = lerp(hud_y, _alvo_y, 0.1);

// trava quando estiver bem perto
if (abs(hud_y - _alvo_y) < 0.5) hud_y = _alvo_y;

// só desenha enquanto ainda não saiu totalmente da tela
if (hud_y < 1000) {

    draw_sprite_ext(spr_ovos_bg, image_index, _xx, hud_y + 50, _escala, _escala, 0, c_white, 1);

    draw_text(_xx + _marg, hud_y, ovos_totais);
    draw_text(_xx - 6,      hud_y, "/");
    draw_text(_xx - 15,     hud_y, ovos_coletados);
}

var x_center = display_get_gui_width() * 0.5;
var y_bottom = display_get_gui_height() - 34; // margem do fundo

var piscar = abs(sin(current_time / 600));

if (mostra_pressiona_botao) {

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_pixel);
    
    draw_text_transformed_colour(
        x_center,
        y_bottom,
        "PRESSIONE ENTER",
        0.7, 0.7, 0,
        c_white, c_white, c_white, c_white,
        piscar
    );
    draw_set_halign(-1);
    draw_set_valign(-1);
    draw_set_font(-1);
};

/*
var _y_inicio = 1000;

if jogo_salvo {
    
    if _yy <= _y_inicio{
        _y_inicio--;
    } 
    draw_sprite_ext(spr_save_sprite,image_index, _xx,_y_inicio,_escala,_escala,0,image_blend,image_alpha);
    
    
}
