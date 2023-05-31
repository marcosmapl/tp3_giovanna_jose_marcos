# Defina qual distro do linux vc quer usar
FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
# Instale as dependencias do SISTEMA OPERACIONAL
# Exemplo de como seria no ubuntu: RUN apt update && apt install -y python3 python3-pip libpq-dev

WORKDIR /app
COPY . /app

# Sua imagem deve ter o python 3.8+ instalado e o pip
RUN apt update && apt install -y python3 python3-pip libpq-dev wget gnupg2 lsb-release

RUN pip install -r requirements.txt

RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' &&\
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - &&\
    apt update && apt install -y postgresql

# Atualize a lista de pacotes e instale o PostgreSQL
# RUN apt-get update && apt-get -y install postgresql

RUN service postgresql start && \
    su - postgres -c "psql -c \"ALTER USER postgres PASSWORD 'postgres';\"" &&\
    su - postgres -c "createdb tpch" &&\
    service postgresql stop


CMD service postgresql start && tail -f /dev/null