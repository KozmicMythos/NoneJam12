//dando o efeito padrão em 1
function screenshake(_treme = 1){

    //Aqui se cria o objeto shake ou pegar no banco de arquivos já feitos
    if instance_exists(obj_screenshake){
        
        //entrando no obj_screenshake
        with(obj_screenshake){
            
            //Se o shake for maior que 0
            if (_treme > treme){
                
                //o treme do objeto receberá o _treme que foi chamado "screenshake(10)",quer dizer que vai tremer mto
                // o _treme recebe o 10;  screenshake(_treme = 10);
                treme = _treme;
                
            }
            
        }
        
        
    }
    
}