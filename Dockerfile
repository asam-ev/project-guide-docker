FROM node:17

WORKDIR /usr/src/app

COPY package.json .
RUN npm install &&\
    apt-get update || :  && apt-get install python3 -y &&\
    apt-get install python3-pip -y &&\
    python3 --version &&\
    python3 -m pip install --no-cache-dir pyyaml &&\
    npm --global i install-cmake

ENV CI=true
ENV DOCSEARCH_ENABLED=true
ENV DOCSEARCH_ENGINE=lunr

ENTRYPOINT npm run docker-build
