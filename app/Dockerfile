FROM node:16.17.0-alpine as builder
WORKDIR /app
COPY ./package.json .
COPY ./yarn.lock .
RUN yarn install
COPY . .
ARG TMDB_V3_API_KEY
ENV VITE_APP_TMDB_V3_API_KEY=${TMDB_V3_API_KEY}
ENV VITE_APP_API_ENDPOINT_URL="https://api.themoviedb.org/3"
RUN yarn build

FROM nginx:stable-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/dist .
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]

#API Key = b16e4234d2c524eb9b11ef4bdf139093
#docker build --build-arg TMDB_V3_API_KEY=ba938bf5e37ad5fa1dcb8ae3654bc57c -t netflix .
# docker run -d --name netflix -p 8081:80 netflix:latest
#ba938bf5e37ad5fa1dcb8ae3654bc57c
# docker run -d --name sonar -p 9000:9000 sonarqube:lst-community
# try the below if the above did not work
#docker run -d --name sonar -p 9000:9000 sonarqube:community
