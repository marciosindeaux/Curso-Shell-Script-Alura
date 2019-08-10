#!/bin/bash

#Recebe apenas um parametro : O nome da variavel que vai ser convertido
function converter(){
    #Converte jpg para png 
    #a variavel $1 é a variavel que a função recebe
    convert $1.jpg $1.png
}

function result(){
    #$1 é o resultado do ultimo comando executado
    #caso 0 -> foi realizado
    #caso [1-255] -> ocorreu algum erro
    if [ $1 -eq 0 ]
    then
        #A varivael $2 é o nome do objeeto que foi convertido
        echo '[SUCCESS] ' $2'.jpg =/=> '$2'.png'
    else
        echo '[ERROR] ' $2'.jpg =/=> ' $2'.png'
    fi
}

#Fincão que faz a varredura recursiva dos diretórios
#Recebe apenas uma variavel : o diretório raiz em que ele vai faazer a recursividade
function move_directory(){
    #a variavel $1 é o diretorio em que se inicia a recursividade
    cd $1  
    #Passamos por todos os itens do diretorio raiz
    for item in *
    do
        if [ -d $item ]
            #Se esse item for um diretório
        then
            #Diga em qual diretório o sistema vai entrar e entre lá
            echo -e "[MOVE] Entrando no Diretório "$item
            move_directory $item
        else
            #Se esse item não for um diretório 

            #Ultilizando o awk realizo os seguintes passos :
            #pego nome completo da variavel ('nome' + 'extensao')
            #divido ela em 2 pelo -F. (field '.'), ou seja, abc.png vira {'abc', 'png'}
            #pego a primeira variavel (nome sem extensao)
            local NOME_SEM_EXTENSAO=$(ls $item | awk -F. '{print $1}')

            #Mando o item ser convertido, passando como parametro o nome do arquivo sem a extensao
            converter $NOME_SEM_EXTENSAO

            #Verifico o resultdo da ultima função passado o resultado e o nome do item
            # que supostamente foi convertido
            result $? $NOME_SEM_EXTENSAO
        fi
    done 

    #depois que realizo todas as conversões em um diretório, mostro qual diretório teve os
    # objetos convertidos e volto para o diretório anterior
    echo -e "[MOVE] Retornando do Diretório "$1
    cd ..
}

#Defino qual o meu diretório raiz para o script agir a partir dele 
DIRETORIO_IMAGENS=imagens-novos-livros/

#chamo a função que vai percorrer a árvore de diretórios 
# passando como parametro a minha pasta raiz
move_directory $DIRETORIO_IMAGENS