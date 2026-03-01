sobe = false;
image_index = random(image_number);

//checando se já peguei nozovo
peguei_ovo = false;

//check de musica
toca_musica = true;

y_base = y;        // posição original
float_amp = 3;     // altura da flutuação (pixels) 2~4 fica bom
float_speed = 0.05; // velocidade da flutuação (0.03~0.08)
float_time = irandom(1000); // começa em fase aleatória (não fica tudo sincronizado)