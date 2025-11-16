# Use the official Nginx image
FROM nginx:alpine

# Copy the index.html file into the container at /usr/share/nginx/html
FROM node:18
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 80
CMD ["npm", "start"]
