#Docker image of elasticsearch with ik tokenizer
# Author: chaoxin.lu

ARG STACK_VERSION=8.5.1

FROM elasticsearch:$STACK_VERSION

MAINTAINER chaoxin.lu

#es插件目录
ENV ES_WORK_DIR_PATH /usr/share/elasticsearch
ENV STACK_VERSION ${STACK_VERSION:-8.5.1}

COPY elasticsearch-analysis-ik-${STACK_VERSION}.zip $ES_WORK_DIR_PATH
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install -b file://$ES_WORK_DIR_PATH/elasticsearch-analysis-ik-$STACK_VERSION.zip \
    && rm -rf *.zip

COPY elasticsearch-analysis-pinyin-${STACK_VERSION}.zip $ES_WORK_DIR_PATH
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install -b file://$ES_WORK_DIR_PATH/elasticsearch-analysis-pinyin-$STACK_VERSION.zip \
    && rm -rf *.zip

COPY elasticsearch-analysis-hanlp-${STACK_VERSION}.zip $ES_WORK_DIR_PATH
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install -b file://$ES_WORK_DIR_PATH/elasticsearch-analysis-hanlp-$STACK_VERSION.zip \
    && rm -rf *.zip
