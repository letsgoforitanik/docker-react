FROM node:21.2.0-alpine3.18 as build-stage
WORKDIR /app
COPY package*.json .
RUN ["npm", "install"]
COPY . .
RUN ["npm", "run", "build"]

FROM nginx:stable-alpine3.17-slim as prod-stage
COPY --from=build-stage /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]