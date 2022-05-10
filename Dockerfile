FROM node:17

WORKDIR /usr/src/app

COPY package.json .
RUN npm install &&\
    apt-get update || :  && apt-get install python3 -y &&\
    apt-get install python3-pip -y &&\
    python3 --version &&\
    python3 -m pip install --no-cache-dir pyyaml &&\
    apt-get install python -y &&\
    apt-get install protobuf-compiler -y &&\
    apt-get install doxygen -y &&\
    wget http://www.cmake.org/files/v3.23/cmake-3.23.0.tar.gz &&\
    tar xzf cmake-3.23.0.tar.gz &&\
    cd cmake-3.23.0 &&\
    ls &&\
    ./bootstrap &&\
    make &&\
    make install

ENV CI=true
ENV DOCSEARCH_ENABLED=true
ENV DOCSEARCH_ENGINE=lunr

ENTRYPOINT npm run docker-build
