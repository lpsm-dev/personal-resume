# --------------> The base image
FROM node:17.3.0-alpine3.14 AS build
WORKDIR /usr/src/app
COPY [ "./code/package.json", "/usr/src/app" ]
RUN npm install

# --------------> The production image
FROM node:17.3.0-alpine3.14
RUN apk add --no-cache dumb-init=1.2.5-r1 && \
    arch && sleep 10 && uname -ra && sleep 10
WORKDIR /usr/src/app
COPY --chown=node:node --from=build [ "/usr/src/app/node_modules", "/usr/src/app/node_modules" ]
COPY --chown=node:node [ "./code", "/usr/src/app" ]
USER node
CMD [ "dumb-init", "node", "index.js" ]
