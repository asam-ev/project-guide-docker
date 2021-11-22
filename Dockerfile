FROM antora/antora:3.0.0-beta.2

ENV DOCSEARCH_ENABLED=true \
    DOCSEARCH_ENGINE=lunr

RUN yarn global add antora-site-generator-lunr@0.6.1

ENTRYPOINT ["antora", "--generator", "antora-site-generator-lunr"]

CMD ["antora-playbook.yml"]

RUN yarn global add asciidoctor-kroki
