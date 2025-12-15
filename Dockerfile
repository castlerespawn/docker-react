# Stage 1: Build React app
FROM node:lts-alpine as builder

WORKDIR '/app'

# Copy package.json and install dependencies
COPY package.json . 
RUN npm install

# Copy all source files and build the React app
COPY . . 
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy the built React app to the Nginx server's public directory
COPY --from=builder /app/build /usr/share/nginx/html

# Expose port 80 for Nginx
EXPOSE 80

# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
