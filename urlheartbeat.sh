#!/usr/bin/env bash

BOT_TOKEN=""
CHAT_ID=""

shopt -s extglob

OPTIONS=":u:"

while getopts ${OPTIONS} opt; do
  case ${opt} in
    u)
      url=${OPTARG}
      ;;
    ?)
      echo "Invalid option: -${OPTARG}."
      exit 1
      ;;
  esac
done

if [ -z $BOT_TOKEN ];
then
  echo "No bot token specified. Message from your bot won't be sent."
  exit
fi;

if [ -z $url ];
then
  echo "No url specified"
  exit
fi;

while IFS=':' read key value; do
  value=${value##+([[:space:]])}; value=${value%%+([[:space:]])}

  case "$key" in
    Server) SERVER="$value"
      ;;
    HTTP*) read PROTOCOL STATUS MSG <<< "$key{$value:+:$value}"
      ;;
  esac
done < <(curl -sI $url)

if [[ -z $STATUS ]] || [[ $STATUS != "200" ]];
then
  MESSAGE="⚠️ Wrong response code (${STATUS}) for url ${url}"

  curl -X POST -H "Content-Type: application/json" -d "{\"chat_id\": \"${CHAT_ID}\", \"text\": \"${MESSAGE}\", \"disable_notification\": true}" https://api.telegram.org/bot${BOT_TOKEN}/sendMessage
fi;
