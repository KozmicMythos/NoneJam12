//Iniciando a Máquina de estados

function estado() constructor 
{
    //método que roda ao iniciar o estado
    static inicia = function() {};
    
    //método para rodar a lógica do estado
    static roda = function() {};
    
    //método que finaliza o estado
    static finaliza = function() {};
    
}

//Preciso de funções para me ajudar a trabalhar a máquina de estados
//Função para iniciar o primeiro estado
function inicia_estado (_estado)
{
    //Criando uma variável para saber qual estado atual
    estado_atual = _estado; 
    estado_atual.inicia();
    
}

//trocando o estado

function troca_estado (_estado) 
{
     //Finalizando o estado atual
    estado_atual.finaliza();
    
    //mudando o estado para o atual
    estado_atual = _estado;
    
    //iniciando o estado
    estado_atual.inicia();
     
}

//Criando a função para rodar a máquina de estados
//Essa função precisa ser colocado no STEP

function roda_estado () 
{ 
    estado_atual.roda() 
}











