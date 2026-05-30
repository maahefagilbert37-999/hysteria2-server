FROM alpine:latest

RUN apk add --no-cache wget

WORKDIR /app

# Télécharger pingtunnel
RUN wget -O pingtunnel https://github.com/esrrhs/pingtunnel/releases/download/1.5/pingtunnel_linux64 && \
    chmod +x pingtunnel

EXPOSE 53/udp

CMD ["./pingtunnel", "-type", "server", "-key", "motdepasse123"]
