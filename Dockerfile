FROM alpine:latest

RUN apk add --no-cache wget ca-certificates openssl

WORKDIR /app

# Télécharger Hysteria2
RUN wget -O hysteria https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-amd64 && \
    chmod +x hysteria

# Générer le certificat SSL
RUN openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes -subj "/CN=render.com"

# Créer le fichier config.yaml (version CORRIGÉE)
RUN echo 'listen: ":443"' > config.yaml && \
    echo 'tls:' >> config.yaml && \
    echo '  cert: /app/cert.pem' >> config.yaml && \
    echo '  key: /app/key.pem' >> config.yaml && \
    echo 'auth:' >> config.yaml && \
    echo '  type: password' >> config.yaml && \
    echo '  password: "motdepasse123"' >> config.yaml && \
    echo 'bandwidth:' >> config.yaml && \
    echo '  up: 100 mbps' >> config.yaml && \
    echo '  down: 100 mbps' >> config.yaml

EXPOSE 443/udp

CMD ["./hysteria", "server", "-c", "config.yaml"]
