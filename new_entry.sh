#!/bin/bash

ARGS=("$@")
TITLE=${ARGS[0]}

HASH_FULL=`date +%s | sha256sum | cut -d ' ' -f 1`
HASH_SHORT=${HASH_FULL: -6}

MONTH_DAY=`date +%m.%d`
LINK_HTML="<p class=\"l\"><a href=\"/blog/$HASH_SHORT\">$MONTH_DAY</a> | $TITLE"

TEMPLATE_PROCESSED=`sed files/templates/blog.html -e "s#%%title%%#$TITLE#g" -e "s#%%hash%%#$HASH_SHORT#g"`
echo "$TEMPLATE_PROCESSED" > blog/$HASH_SHORT.html
echo "$LINK_HTML"
