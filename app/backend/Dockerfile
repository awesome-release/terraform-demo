FROM node:14.18.0-alpine3.14

ARG NODE_ENV=production
ENV NODE_ENV ${NODE_ENV}

WORKDIR /app

COPY package*.json ./ 
RUN npm ci --only=production

COPY . .

ARG PORT=80
ENV PORT ${PORT}
EXPOSE ${PORT}

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "node", "healthcheck.js" ]

CMD ["node", "src/index.js"]