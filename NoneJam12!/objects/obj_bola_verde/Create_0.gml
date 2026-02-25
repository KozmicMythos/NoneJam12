image_index = random(image_number);
timer = 40;
lay_hurt  = layer_tilemap_get_id("Map");
xscale = 1;
yscale = 1;

lay_col  = layer_tilemap_get_id("Map");
colisor  = [obj_plataforma,lay_col,obj_check_escada];