if ativa_animacao { 
    image_speed = 1;
}else{
    image_speed = 0;
}

//se a animação da minha imagem acabar minha animação zera
if image_index > image_number - 1 {
    image_index = 0;
    ativa_animacao = 0;
}