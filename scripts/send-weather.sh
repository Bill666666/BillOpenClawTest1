#!/bin/bash
set -e

TIME=$(date -d '+8 hours' '+%H:%M')

echo "Fetching weather data with 120s timeout..."

# 使用更长的超时时间，后台并行请求
fetch_weather() {
    local city=$1
    local name=$2
    
    # 尝试 wttr.in，超时120秒
    result=$(curl -s --max-time 120 "wttr.in/${city}?format=%c+%t" 2>/dev/null || echo "")
    
    if [ -z "$result" ]; then
        result="服务超时"
    fi
    
    echo "${name}: ${result}"
}

# 串行请求（避免并发被限）
SH=$(fetch_weather "Shanghai" "上海")
sleep 1
TZ=$(fetch_weather "Tongzhou" "江苏通州")
sleep 1
TJ=$(fetch_weather "Taojiang" "湖南桃江")

echo "Sending to Telegram..."

curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
  -d "chat_id=${CHAT_ID}" \
  -d "text=🌤️ 天气播报 ${TIME}

📍 ${SH}
📍 ${TZ}
📍 ${TJ}

---
⏰ 每小时自动更新 · 数据来自 wttr.in"

echo "Done at ${TIME}"
