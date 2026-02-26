#!/bin/bash
set -e

TIME=$(date -d '+8 hours' '+%H:%M')
API_KEY="9225eb489bfd10135d929a05a4ba5261"

echo "=== Weather Report ${TIME} ==="
echo "API Key: ${API_KEY:0:10}..."

# 并行获取三个城市天气（后台运行）
fetch_city() {
    local city=$1
    local output_file=$2
    
    echo "Fetching ${city}..." 
    
    response=$(curl -s --max-time 45 "https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${API_KEY}&units=metric&lang=zh_cn" 2>&1)
    
    echo "Response for ${city}: ${response:0:100}..." 
    
    # 检查是否成功
    if echo "$response" | grep -q '"cod":200'; then
        temp=$(echo "$response" | grep -o '"temp":[0-9.]*' | head -1 | cut -d':' -f2)
        feels=$(echo "$response" | grep -o '"feels_like":[0-9.]*' | head -1 | cut -d':' -f2)
        humidity=$(echo "$response" | grep -o '"humidity":[0-9]*' | head -1 | cut -d':' -f2)
        desc=$(echo "$response" | grep -o '"description":"[^"]*"' | head -1 | cut -d'"' -f4)
        
        if [ -n "$temp" ] && [ "$temp" != "" ]; then
            echo "${desc}, ${temp}°C(体感${feels}°C), 湿度${humidity}%" > "$output_file"
        else
            echo "解析失败" > "$output_file"
        fi
    else
        error=$(echo "$response" | grep -o '"message":"[^"]*"' | head -1 | cut -d'"' -f4)
        echo "API错误: ${error:-未知错误}" > "$output_file"
    fi
}

# 创建临时文件
SH_FILE=$(mktemp)
TZ_FILE=$(mktemp)
TJ_FILE=$(mktemp)

# 并行获取（后台运行）
fetch_city "Shanghai" "$SH_FILE" &
PID1=$!

fetch_city "Tongzhou,CN" "$TZ_FILE" &
PID2=$!

fetch_city "Taojiang,CN" "$TJ_FILE" &
PID3=$!

# 等待所有后台任务完成（最多60秒）
echo "Waiting for all fetches to complete..."
wait $PID1 $PID2 $PID3

echo "All fetches completed"

# 读取结果
SH=$(cat "$SH_FILE")
TZ=$(cat "$TZ_FILE")
TJ=$(cat "$TJ_FILE")

# 清理临时文件
rm -f "$SH_FILE" "$TZ_FILE" "$TJ_FILE"

echo "Results:"
echo "  Shanghai: $SH"
echo "  Tongzhou: $TZ"
echo "  Taojiang: $TJ"

# 构建消息
MESSAGE="🌤️ 天气播报 ${TIME}

📍 上海: ${SH}
📍 江苏通州: ${TZ}
📍 湖南桃江: ${TJ}

---
⏰ OpenWeatherMap API"

echo "Sending to Telegram..."
RESULT=$(curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
  -d "chat_id=${CHAT_ID}" \
  -d "text=${MESSAGE}")

echo "Telegram response: ${RESULT:0:100}"
echo "Done at ${TIME}"
