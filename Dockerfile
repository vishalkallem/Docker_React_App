# Use the official image as a parent image.
FROM node:14-alpine as builder

# Set the working directory.
WORKDIR '/app'

# Copy the file from your host to your current location.
COPY package.json .

# Run the command inside your image filesystem.
RUN npm install

# Inform Docker that the container is listening on the specified port at runtime.
EXPOSE 3000

# Copy the rest of your app's source code from your host to your image filesystem.
COPY . .

# Run the specified command within the container.
CMD [ "npm", "run", "build" ]

# Use the official image for nginx
FROM nginx as deployer

# Copy the npm run build snapshot from the builder phase.
COPY --from=builder /app/build /usr/share/nginx/html
