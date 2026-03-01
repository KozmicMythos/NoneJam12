if ativa_animacao { 
    image_speed = 1;
    efeito_squash(1.2,0.8)
}else{
    image_speed = 0;
}

//se a animação da minha imagem acabar minha animação zera
if image_index > image_number - 1 {
    image_index = 0;
    ativa_animacao = 0;
}
retorna_squash();