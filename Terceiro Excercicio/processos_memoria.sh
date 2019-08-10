#!/bin/bash

verifica_diretorio(){
    if [ ! -d log ]
    then
        mkdir log
        cd log
    else
        cd log
    fi
}

processos_memoria(){
    processos=$(ps -e -o pid --sort -size | head -n 11 | grep [0-9])

    for pid in $processos
    do
        nome_processo=$(ps -p $pid -o comm=)
        echo -n $(date +%F,%H:%M:%S,) >> $nome_processo.log
        tamanho_processo=$(ps -p $pid -o size | grep [0-9])
        echo "$(bc <<< "scale=2;$tamanho_processo/1024")mb" >> $nome_processo.log
    done
}

verifica_diretorio
processos_memoria
if [ $? -eq 0 ]
then
    echo -e "Processo realizado com sucesso\n"
else
    echo -e "Não foi possivel realizar o processo"
fi