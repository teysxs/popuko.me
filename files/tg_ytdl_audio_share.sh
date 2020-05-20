#!/bin/bash

FILE_ID=$(youtube-dl --get-id $1)
FILE_CAPTION=$(youtube-dl --get-title $1)
FILE_NAME="${FILE_ID}.opus"

youtube-dl -x \
	--geo-bypass \
	--add-metadata \
	--audio-format opus \
	--audio-quality 0 \
	--prefer-avconv \
	-o '%(id)s.%(ext)s' \
	$1

stat $FILE_NAME

telegram-send \
	--audio $FILE_NAME \
	--config telegram.conf \
	--caption "${FILE_CAPTION}"

echo "${FILE_NAME} uploaded successfully."
