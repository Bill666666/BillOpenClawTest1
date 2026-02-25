#!/bin/bash
# Weather Push Script - 发送天气到 WhatsApp
# 通过调用 OpenClaw 的 message 功能

# 获取天气数据
SH=$(curl -s "wttr.in/Shanghai?format=📍上海:+%c+%t(体感+%f),%w风,%h湿度" 2>/dev/null || echo "📍 上海: 获取失败")
TZ=$(curl -s "wttr.in/Tongzhou?format=📍江苏通州:+%c+%t(体感+%f),%w风,%h湿度" 2>/dev/null || echo "📍 江苏通州: 获取失败")
TJ=$(curl -s "wttr.in/Taojiang?format=📍湖南桃江:+%c+%t(体感+%f),%w风,%h湿度" 2>/dev/null || echo "📍 湖南桃江: 获取失败")

# 获取当前时间
TIME=$(date '+%H:%M')

# 构建消息内容
MESSAGE="🌤️ 天气预报 ${TIME}

${SH}
${TZ}
${TJ}

---
⏰ 每小时自动更新"

# 通过 OpenClaw CLI 发送消息
# 注意：这里需要调用 message 工具
openclaw message send --target "+8618752876506" --message "${MESSAGE}" 2>/dev/null || echo "发送失败，请检查配置"

# 同时记录到日志
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Weather report sent" >> /tmp/weather-push.log
