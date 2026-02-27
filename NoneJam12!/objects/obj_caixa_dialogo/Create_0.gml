fonte = fnt_texto;
fonte_pixel = fnt_pixel;

//TEXTO
texto = "Texto de teste";

//conferindo se posso desenhar o texto ou nao
desenha_texto = false;

//checando se posso me destruir
me_destruir = false;

image_alpha = 0;
image_xscale = 0.1;

//Criando um metodo para iniciar
iniciando = function () {
    
    //Fazendo ele esticar
    image_xscale = lerp(image_xscale,3.5,.1);
    image_alpha = lerp(image_alpha,0.8,0.2);
   
   //fazendo ele subir um pouco
   y = lerp(y,ystart - 45,0.1);
   
   //Checando se cheguei na posição certa
   if y <= ystart - 39 {
       desenha_texto = true;
   }
    
}

finalizando = function () {
    
    //achatando
    image_xscale = lerp(image_xscale,0,.2);
    
    //ficando invisivel
    image_alpha = lerp(image_alpha,0,0.2);
    
    //Fazendo ele voltar para baixo
    y = lerp(y,ystart - 20,0.2);
    
    //parando de desenhar
    desenha_texto = false;
    
    if image_alpha <= 0.01 {
        instance_destroy();
    }
    
    

}