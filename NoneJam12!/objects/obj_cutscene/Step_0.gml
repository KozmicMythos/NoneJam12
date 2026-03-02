
if image_index > image_number - 1 {
    image_index = image_number - 1;
    diminui_alpha = true;
    
    
}

if diminui_alpha {
    image_alpha -= 0.01;
    diminui_timer--;
};

if image_alpha <= 0 and diminui_timer <= 0{
    if !instance_exists(Room1){
        instance_create_depth(x,y,depth - 1,obj_cutscene_2);
    }
}
