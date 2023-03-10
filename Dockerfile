# Use Node.js LTS version as the base image
FROM node:lts AS builder

# Set working directory
WORKDIR /app

# Copy the rest of the application code to the working directory
COPY . .

# Install dependencies
RUN npm install && npm run build -- --prod

# Use Nginx as the base image for the final image
FROM nginx:alpine

# Copy the built app from the builder image to the Nginx web root directory
COPY --from=builder /app/dist/sample-frontend /usr/share/nginx/html

# Copy the Nginx configuration file to the container
#COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 for the Nginx web server
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
