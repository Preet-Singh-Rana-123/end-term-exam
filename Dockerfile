FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm inatall

COPY . .

EXPOSE 5000

CMD ["node", "app.js"]
