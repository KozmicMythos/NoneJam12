timer--;

xscale = lerp(xscale,1,99.1);
//yscale = xscale;

//xscale = clamp(xscale,1,10)
yscale = xscale;


if timer <=0 {
    image_alpha -= 0.01;
    if image_alpha <= 0{
        instance_destroy();
    }
}

if place_meeting(x+1,y,colisor){
    hspeed  = 0;
    vspeed  = 0;
    gravity = 0;
    y       -= 1;
    //sprite_index = spr_bolaverde_morrendo; 
}