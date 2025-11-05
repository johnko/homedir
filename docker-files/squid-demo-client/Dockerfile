FROM node:24.11.0-alpine3.21

COPY CA.pem /CA.pem

RUN chmod a+r /CA.pem

RUN \
  export PROXY_HOST=localhost ; \
  npm config set proxy http://$PROXY_HOST:3128 ; \
  npm config set https-proxy http://$PROXY_HOST:3129 ; \
  npm config set cafile "/CA.pem"
