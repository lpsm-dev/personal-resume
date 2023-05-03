# Stage 1: Install packages
FROM node:current-alpine3.17 AS install
WORKDIR /usr/src/app
COPY [ "./code/package.json", "/usr/src/app" ]
RUN npm install

# Stage 2: Copy node_modules and run script
FROM node:current-alpine3.17
WORKDIR /usr/src/app
COPY --chown=node:node --from=install [ "/usr/src/app/node_modules", "/usr/src/app/node_modules" ]
COPY --chown=node:node [ "./code", "/usr/src/app" ]
USER node
CMD [ "npm", "start" ]
