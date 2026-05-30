FROM tobyxdd/hysteria2:latest

WORKDIR /app

# Certificat SSL auto-signé
RUN openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes -subj "/CN=render.com"

# Configuration
RUN echo 'listen: ":443"' > config.yaml && \
    echo 'tls:' >> config.yaml && \
    echo '  cert: /app/cert.pem' >> config.yaml && \
    echo '  key: /app/key.pem' >> config.yaml && \
    echo 'auth:' >> config.yaml && \
    echo '  type: password' >> config.yaml && \
    echo '  password: "motdepasse123"' >> config.yaml

EXPOSE 443/udp

CMD ["hysteria-server", "-c", "config.yaml"]
