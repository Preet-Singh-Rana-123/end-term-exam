FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./

COPY . .

EXPOSE 5000

CMD ["node", "app.js"]
