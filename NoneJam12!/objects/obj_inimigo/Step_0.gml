muda_estado();

if destroi {
    tempo_destroi--;
    image_alpha-= 0.01;
}

if tempo_destroi <= 0 or image_alpha <= 0{
    instance_destroy();
}