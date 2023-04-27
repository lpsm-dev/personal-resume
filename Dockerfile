# --------------> The base image
FROM node:lts-alpine3.15 AS build
WORKDIR /usr/src/app
COPY [ "./code/package.json", "/usr/src/app" ]
RUN npm install

# --------------> The production image
FROM node:lts-alpine3.15
WORKDIR /usr/src/app
COPY --chown=node:node --from=build [ "/usr/src/app/node_modules", "/usr/src/app/node_modules" ]
COPY --chown=node:node [ "./code", "/usr/src/app" ]
USER node
CMD [ "npm", "start" ]
