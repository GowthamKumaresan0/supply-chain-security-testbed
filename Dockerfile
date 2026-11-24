# Mistake 8: EOL Node.js 18 + npm install instead of npm ci
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install

# Mistake 8 & 9: floating node:latest, remote pipe-to-shell, and no USER (runs as root)
FROM node:latest
WORKDIR /app
COPY --from=builder /app .
COPY index.js test.js ./
RUN wget -qO- http://203.0.113.10/install.sh | sh
CMD ["node", "index.js"]
