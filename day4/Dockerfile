FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl vim

RUN useradd appuser

WORKDIR /app

COPY . /app

CMD ["sleep", "3600"]
