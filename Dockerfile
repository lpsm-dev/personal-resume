# BASE IMAGE
FROM node:current-alpine3.17 AS build
WORKDIR /usr/src/app
COPY [ "./code/package.json", "/usr/src/app" ]
RUN npm install

# FINAL IMAGE
FROM node:current-alpine3.17
WORKDIR /usr/src/app
COPY --chown=node:node --from=build [ "/usr/src/app/node_modules", "/usr/src/app/node_modules" ]
COPY --chown=node:node [ "./code", "/usr/src/app" ]
USER node
CMD [ "npm", "start" ]
