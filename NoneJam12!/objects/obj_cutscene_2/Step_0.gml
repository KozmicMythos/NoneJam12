

if image_index > image_number - 1 {
    image_index = image_number - 1;
    diminui_alpha = true;
    
    
}

if diminui_alpha {
    image_alpha -= 0.01;
};

if image_alpha <= 0 {
    room_goto(room_historia)
}
