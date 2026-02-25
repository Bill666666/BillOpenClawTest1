#!/usr/bin/env node
/**
 * Weather Cron - 每小时推送天气到 WhatsApp
 * 通过 sessions_send 触发主会话响应
 */

const { execSync } = require('child_process');

const SESSION_KEY = 'agent:main:whatsapp:direct:+8618752876506';

const cities = [
  { name: '上海', query: 'Shanghai' },
  { name: '江苏通州', query: 'Tongzhou' },
  { name: '湖南桃江', query: 'Taojiang' },
];

function getWeather(query) {
  try {
    return execSync(
      `curl -s "wttr.in/${query}?format=📍+上海:+%c+%t(体感+%f),%w风,%h humidity" 2>&1 || echo "获取失败"`,
      { encoding: 'utf-8', timeout: 10000 }
    ).trim();
  } catch {
    return '获取失败';
  }
}

function main() {
  const hour = new Date().getHours();
  
  // 构建消息
  let message = `🌤️ 天气播报 ${hour}:00\n\n`;
  
  for (const city of cities) {
    const weather = getWeather(city.query);
    message += `${weather}\n`;
  }
  
  message += '\n---\n⏰ 每小时自动更新';
  
  // 使用 openclaw sessions_send 发送消息
  try {
    execSync(
      `openclaw sessions_send --session-key "${SESSION_KEY}" --message "${message.replace(/"/g, '\\"')}"`,
      { timeout: 30000 }
    );
    console.log(`[${new Date().toISOString()}] Weather sent successfully`);
  } catch (e) {
    console.error(`[${new Date().toISOString()}] Failed to send:`, e.message);
  }
}

main();
