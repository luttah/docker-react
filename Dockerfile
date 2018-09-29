FROM node:alpine as builder 
# sole purpose of this phase is to install dependencies
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# from above step we copy over the build folder and nothing else into nginx server's directory
FROM nginx
# Must explicitly expose a port equivalent to -p port:port in the commandline
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

