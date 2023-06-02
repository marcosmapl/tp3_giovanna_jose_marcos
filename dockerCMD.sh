#!/bin/bash

# # Construir a imagem
# sudo docker build . -t tp3

# Rodar o container
sudo docker run -d --rm --shm-size=1g --name tp3 -p 5433:5432 -p 8888:8888 -v $(pwd)/notebooks/:/app/notebooks -v $(pwd)/datadir/:/app/datadir tp3

# Esperar um pouco para garantir que o container está rodando
sleep 5

# Executar o Jupyter Notebook dentro do container
sudo docker exec tp3 jupyter notebook --notebook-dir=/app/notebooks/ --allow-root --ip 0.0.0.0 --no-browser
