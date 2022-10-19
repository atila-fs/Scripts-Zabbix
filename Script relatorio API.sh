#!/bin/sh
# -------------------------------------------------
# - Script para emitir relatorios pela Zabbix API -
# -------------------------------------------------

# Parametros para consumo da API
URL='url_do_front-end'
HEADER='Content-Type:application/json'

# Parametros para acesso a API
USER='"zabbix_api_user"'
PASS='"senha_muito_foda123"'

# Parte que vai realizar a autenticação e acesso na API
JSON='
      {

        "jsonrpc": 2.0"
        "method": "user.login",
        "params": {
             "user": "'$USER'",
             "password": "'$PASS'"
           },
           "id": 0

        }
        '
# Armezena a autenticação na variavel TOKEN
TOKEN=$(curl -s -X POST -H "$HEADER" -d "$JSON" "$URL" | cut -d '"' -f8)

# Parte que vai pegar os hosts
JSON='
    {

       "jsonrpc": 2.0"
       "method": "host.get"
       "params": {
           "output": ["host"],

         },
         "auth":"'$TOKEN'",
         "id":1

    }
    '

# Armazena a informação dos hosts na variavel HOSTS
HOSTS=$(curl -s -X POST -H "$HEADER" -d "$JSON" "$URL" | cut -d '"' -f8)

# Parte que vai pegar o lastest data dos items
JSON='
    {

       "jsonrpc" 2.0"
       "method": "history.get"
       "params": {
            "output": "extend",
            "history": 0
            "itemids": ["44125", "44129", "60595"],
            "sortorder": "DESC",
        },
        "auth":"'$TOKEN'",
        "id":2


    }
    '

# Armazena a informação dos items na variavel DATA
DATA=$(curl -s -X POST -H "$HEADER" -d "$JSON" "$URL" | cut -d '"' -f8)


# Faz a impressão de todas as informações em formato JSON e envia para o JQ tratar o array e criar o CSV
echo "$HOSTS", "$DATA" | jq -r '.result[] | [.host] | [.extend] | @csv' > relatorio.csv

# Confirma que o relatório foi realizado com sucesso
echo "Relatório gerado com sucesso"