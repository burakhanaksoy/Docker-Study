FROM node:13-alpine

ENV MONGO_DB_USERNAME=admin \
    MONGO_DB_PWD=password

RUN mkdir /home/app
COPY . /home/app
WORKDIR /home/app
CMD ["node","server.js"]