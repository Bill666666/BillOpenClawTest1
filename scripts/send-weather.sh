#!/bin/bash
set -e

TIME=$(date -d '+8 hours' '+%H:%M')

SH=$(curl -s --max-time 30 "wttr.in/Shanghai?format=%c+%t" || echo "timeout")
TZ=$(curl -s --max-time 30 "wttr.in/Tongzhou?format=%c+%t" || echo "timeout")
TJ=$(curl -s --max-time 30 "wttr.in/Taojiang?format=%c+%t" || echo "timeout")

curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
  -d "chat_id=${CHAT_ID}" \
  -d "text=Weather ${TIME}
Shanghai: ${SH}
Tongzhou: ${TZ}
Taojiang: ${TJ}"

echo "Done"
