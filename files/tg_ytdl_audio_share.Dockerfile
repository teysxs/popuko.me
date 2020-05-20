FROM alpine:3.7

ENV LC_ALL=en_US.UTF-8
ENV ENTRYPOINT='https://popuko.me/files/tg_ytdl_audio_share.sh'

ARG TOKEN
ARG CHAT_ID

RUN apk add \
	python3 \
	ffmpeg \
    ffmpeg-libs \
	python3-dev \
	alpine-sdk \
	libffi-dev \
	openssl-dev \
	bash

RUN pip3 install youtube-dl telegram-send

WORKDIR /tmp

RUN echo '[telegram]' > telegram.conf
RUN echo "token = $TOKEN" >> telegram.conf
RUN echo "chat_id = $CHAT_ID" >> telegram.conf

RUN curl $ENTRYPOINT > entrypoint.sh
RUN chmod +x entrypoint.sh

RUN cat telegram.conf
RUN cat entrypoint.sh

ENTRYPOINT [ "bash", "/tmp/entrypoint.sh" ]
