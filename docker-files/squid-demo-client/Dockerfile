FROM node:22.12.0-alpine3.21

COPY CA.pem /CA.pem

RUN chmod a+r /CA.pem

RUN \
  npm config set proxy http://localhost:3128 ; \
  npm config set https-proxy http://localhost:3129 ; \
  npm config set cafile "/CA.pem"
