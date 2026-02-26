#!/bin/bash
set -e

TIME=$(date -d '+8 hours' '+%H:%M')
API_KEY="9225eb489bfd10135d929a05a4ba5261"

# OpenWeatherMap API 获取天气
get_owm_weather() {
    local city=$1
    local name=$2
    
    # 调用 OpenWeatherMap API
    response=$(curl -s --max-time 30 "https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${API_KEY}&units=metric&lang=zh_cn" 2>/dev/null)
    
    # 检查是否成功
    if echo "$response" | grep -q '"cod":200'; then
        temp=$(echo "$response" | python3 -c "import sys,json; print(json.load(sys.stdin)['main']['temp'])" 2>/dev/null || echo "?")
        feels=$(echo "$response" | python3 -c "import sys,json; print(json.load(sys.stdin)['main']['feels_like'])" 2>/dev/null || echo "?")
        desc=$(echo "$response" | python3 -c "import sys,json; print(json.load(sys.stdin)['weather'][0]['description'])" 2>/dev/null || echo "未知")
        humidity=$(echo "$response" | python3 -c "import sys,json; print(json.load(sys.stdin)['main']['humidity'])" 2>/dev/null || echo "?")
        echo "${desc}, ${temp}°C(体感${feels}°C), 湿度${humidity}%"
    else
        # 失败时使用 wttr.in 备用
        echo "$(curl -s --max-time 30 "wttr.in/${city}?format=%c+%t" 2>/dev/null || echo '获取失败')"
    fi
}

echo "Fetching weather data..."

# 获取三个城市天气（使用英文城市名）
SH=$(get_owm_weather "Shanghai" "上海")
sleep 1
TZ=$(get_owm_weather "Tongzhou,CN" "通州")
sleep 1
TJ=$(get_owm_weather "Taojiang,CN" "桃江")

echo "Sending to Telegram..."

curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
  -d "chat_id=${CHAT_ID}" \
  -d "text=🌤️ 天气播报 ${TIME}

📍 上海: ${SH}
📍 江苏通州: ${TZ}
📍 湖南桃江: ${TJ}

---
⏰ 每小时自动更新"

echo "Done at ${TIME}"
