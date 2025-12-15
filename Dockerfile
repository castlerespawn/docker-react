# Stage 1: Build React app
FROM node:lts-alpine as builder

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine

COPY --from=builder /app/build /usr/share/nginx/html

# Expose port 80 for EB
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
