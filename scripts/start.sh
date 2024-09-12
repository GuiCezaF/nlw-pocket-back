#!/bin/bash

echo "Iniciando o container Docker...\n"
docker compose pull && docker compose build && docker compose up -d
sleep 2
if [ $? -eq 0 ]; then
  echo -e "\nContainer iniciado com sucesso. ✅"
  echo -e "\nMigrando dados e atualizando pacotes\n"

  pnpm install

  npx drizzle-kit migrate
  if [ $? -eq 0 ]; then
      echo -e "\nBanco de dados migrado com sucesso. ✅"
    else
      echo -e "\nErro ao migrar o banco de dados. ❌"
    fi

else
  echo -e "\nFalha ao iniciar o container Docker. ❌"
fi
