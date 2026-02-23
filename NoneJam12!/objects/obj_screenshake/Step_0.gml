
if(treme > 0.1){
	var _x = random_range(-treme, treme);
	var _y = random_range(-treme, treme);
	//alterando a posição do x do viewport
	view_set_xport(view_current,_x);
	view_set_yport(view_current,_y);
}
else{
	treme = 0 //zerando o tremor
	view_set_xport(view_current,0)
	view_set_yport(view_current,0)
}
//dimuindo o shake em pouco
treme = lerp(treme,0,0.2);

