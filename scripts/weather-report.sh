#!/bin/bash

# Weather Report Cron Script
# 每小时获取上海、江苏通州、湖南桃江的天气

# 上海
SHANGHAI=$(curl -s "wttr.in/Shanghai?format=%l:+%c+%t+(feels+like+%f),+%w+wind,+%h+humidity,+%p+precipitation")

# 江苏通州
TONGZHOU=$(curl -s "wttr.in/Tongzhou,Jiangsu?format=%l:+%c+%t+(feels+like+%f),+%w+wind,+%h+humidity,+%p+precipitation")

# 湖南桃江
TAojiang=$(curl -s "wttr.in/Taojiang,Hunan?format=%l:+%c+%t+(feels+like+%f),+%w+wind,+%h+humidity,+%p+precipitation")

echo "🌤️ 天气预报 $(date '+%Y-%m-%d %H:%M')"
echo ""
echo "📍 上海: $SHANGHAI"
echo "📍 江苏通州: $TONGZHOU"
echo "📍 湖南桃江: $TAojiang"
