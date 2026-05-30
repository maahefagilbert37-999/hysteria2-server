FROM alpine:latest

RUN apk add --no-cache wget ca-certificates openssl

WORKDIR /app

RUN wget -O hysteria https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-amd64 && \
    chmod +x hysteria

RUN openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes -subj "/CN=render.com"

RUN echo 'listen: :443\n\
tls:\n\
  cert: /app/cert.pem\n\
  key: /app/key.pem\n\
auth:\n\
  type: password\n\
  password: "motdepasse123"\n\
bandwidth:\n\
  up: 100 mbps\n\
  down: 100 mbps' > config.yaml

EXPOSE 443/udp

CMD ["./hysteria", "server", "-c", "config.yaml"]
