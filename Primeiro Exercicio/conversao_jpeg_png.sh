#!/bin/bash

#Defini uma função de conversao, caso ela seja bem sucedida, retorna 0 , caso não seja, retorna de 1 a 255
function converter_imagem(){
    convert $1.jpg png/$1.png
}

#Gerei uma variavel caminho que indica onde está o caminho da imagem 
CAMINHO_IMAGENS=imagens/

#Mudando para o caminho das imagens
cd $CAMINHO_IMAGENS 

#Se na pasta onde estou não existir um diretorio chamado 'png'
if [ ! -d png ]
then
    #crie um diretorio chamado 'png'
    mkdir png
fi

#Para todos os diretorios que começam com qualquer coisa, as terminam com '.png'
for imagem in  *.jpg
do
    #Ultilizando o awk realizo os seguintes passos :
    #pego nome completo da variavel ('nome' + 'extensao')
    #divido ela em 2 pelo -F. (field '.'), ou seja, abc.png vira {'abc', 'png'}
    #pego a primeeeira variavel (nome sem extensao)
    IMAGEM_SEM_EXTENSAO=$(ls $imagem | awk -F. '{print $1}')

    #passando o conteudo da variavem para a função 
    converter_imagem "$IMAGEM_SEM_EXTENSAO"
    #Se a resposta dele for 0 -> deu certo
    if [ $? -eq 0 ]
    then
        echo '[SUCCESS] ' $IMAGEM_SEM_EXTENSAO'.jpg => '$IMAGEM_SEM_EXTENSAO'.png'
    else
        echo '[ERROR] ' $IMAGEM_SEM_EXTENSAO'.jpg => '$IMAGEM_SEM_EXTENSAO'.png'
    fi
done

