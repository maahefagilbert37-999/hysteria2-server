FROM alpine:latest

RUN apk add --no-cache wget ca-certificates openssl

WORKDIR /app

RUN wget -O hysteria https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-amd64 && chmod +x hysteria

RUN openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes -subj "/CN=render.com"

RUN echo 'listen: ":443"' > config.yaml
RUN echo 'tls:' >> config.yaml
RUN echo '  cert: /app/cert.pem' >> config.yaml
RUN echo '  key: /app/key.pem' >> config.yaml
RUN echo 'auth:' >> config.yaml
RUN echo '  type: password' >> config.yaml
RUN echo '  password: "motdepasse123"' >> config.yaml

EXPOSE 443/udp

CMD ["./hysteria", "server", "-c", "config.yaml"]
