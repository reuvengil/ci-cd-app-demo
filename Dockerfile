FROM node:latest

WORKDIR /app

COPY package.json ./

RUN npm i --silent

COPY . .

ENTRYPOINT [ "npm" ]
CMD [ "start" ]