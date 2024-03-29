FROM node:18

WORKDIR /usr/src/app
ENV NODE_PATH="/usr/local/lib/node_modules"

COPY package.json .
RUN npm install &&\
    apt-get update || :  && apt-get install -y python3-full software-properties-common python3-pip
RUN apt install -y python3-setuptools python3-wheel python3-yaml python3-pyquery
RUN apt-get install -y graphviz protobuf-compiler build-essential libssl-dev cmake ruby bundler
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.11 2
RUN npm i -g @antora/cli@^3.0 @antora/site-generator@^3.0 && npm i -g @antora/lunr-extension@latest
RUN npm i -g --save vinyl
RUN npm i -g -y jquery 
RUN npm i -g -y jsdom
RUN npm i -g asciidoctor-kroki@^0.14.0
RUN npm i -g xmlhttprequest
RUN npm i -g bibtex
RUN npm i -g citeproc
RUN npm i -g @citation-js/plugin-bibtex
RUN npm i -g adm-zip
RUN curl -OL https://sourceforge.net/projects/doxygen/files/rel-1.8.13/doxygen-1.8.13.linux.bin.tar.gz && tar xzvf doxygen-1.8.13.linux.bin.tar.gz
WORKDIR /usr/src/app/doxygen-1.8.13
# This doxygen version on sourceforge was pushed incomplete: The Makefile.in has obsolete content that needs to be removed.
RUN sed -i '/doxytag\|examples/d' Makefile.in
RUN ./configure && make install
WORKDIR /usr/src/repo
RUN gem install asciidoctor-pdf
RUN npm i -g @antora/pdf-extension

ENV CI=true
ENV DOCSEARCH_ENABLED=true
ENV DOCSEARCH_ENGINE=lunr
# ENV NODE_PATH="/usr/local/lib/node_modules"

# ENTRYPOINT npm run docker-build
ENTRYPOINT /bin/bash
