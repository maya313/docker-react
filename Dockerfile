FROM node:18.12.1-alpine as common

# Develop
FROM common as dev
WORKDIR /usr/src/app

# Production
FROM common as builder
COPY ./react-app /usr/src/app
WORKDIR /usr/src/app/react-app
RUN npm install
RUN npm run build

FROM nginx:1.23.3 as prod
RUN rm -r -f /usr/share/nginx/html
COPY --from=builder /usr/src/app/react-app/build /usr/share/nginx/html