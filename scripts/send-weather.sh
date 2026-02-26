#!/bin/bash
set -e

# 增加超时到60秒，添加重试机制
get_weather() {
    local city=$1
    local retries=3
    local result=""
    
    for i in $(seq 1 $retries); do
        result=$(curl -s --max-time 60 "wttr.in/${city}?format=%c+%t" 2>/dev/null || echo "")
        if [ -n "$result" ]; then
            echo "$result"
            return 0
        fi
        sleep 2
    done
    
    echo "获取失败"
}

TIME=$(date -d '+8 hours' '+%H:%M')

echo "Fetching weather data..."
SH=$(get_weather "Shanghai")
TZ=$(get_weather "Tongzhou")
TJ=$(get_weather "Taojiang")

echo "Sending to Telegram..."
curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
  -d "chat_id=${CHAT_ID}" \
  -d "text=🌤️ 天气播报 ${TIME}

📍 上海: ${SH}
📍 江苏通州: ${TZ}
📍 湖南桃江: ${TJ}

---
⏰ 每小时自动更新"

echo "Done"
