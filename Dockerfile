FROM ggrossetie/antora-lunr
RUN yarn global add asciidoctor-kroki
RUN apk update && apk add ruby
RUN gem install asciidoctor-bibtex