contando_historia()
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
    if keyboard_check(vk_enter){
        room_goto(Room1);
    }
};