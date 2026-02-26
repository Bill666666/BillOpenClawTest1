#!/bin/bash
set -e

TIME=$(date -d '+8 hours' '+%H:%M')
API_KEY="9225eb489bfd10135d929a05a4ba5261"

# 获取天气数据
get_weather() {
    local city=$1
    
    response=$(curl -s --max-time 30 "https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${API_KEY}&units=metric&lang=zh_cn")
    
    # 解析 JSON
    temp=$(echo "$response" | grep -o '"temp":[0-9.]*' | cut -d':' -f2)
    feels=$(echo "$response" | grep -o '"feels_like":[0-9.]*' | cut -d':' -f2)
    humidity=$(echo "$response" | grep -o '"humidity":[0-9]*' | cut -d':' -f2 | head -1)
    desc=$(echo "$response" | grep -o '"description":"[^"]*"' | cut -d'"' -f4)
    
    if [ -n "$temp" ]; then
        echo "${desc}, ${temp}°C(体感${feels}°C), 湿度${humidity}%"
    else
        echo "获取失败"
    fi
}

echo "Fetching weather..."
SH=$(get_weather "Shanghai")
TZ=$(get_weather "Tongzhou,CN")
TJ=$(get_weather "Taojiang,CN")

MESSAGE="🌤️ 天气播报 ${TIME}

📍 上海: ${SH}
📍 江苏通州: ${TZ}
📍 湖南桃江: ${TJ}

---
⏰ 每小时自动更新 · OpenWeatherMap"

curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
  -d "chat_id=${CHAT_ID}" \
  -d "text=${MESSAGE}"

echo "Done"
