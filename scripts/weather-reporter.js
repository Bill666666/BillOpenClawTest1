#!/usr/bin/env node

/**
 * Weather Reporter - 定时天气报告
 * 每小时发送上海、江苏通州、湖南桃江的天气预报
 */

const { execSync } = require('child_process');

const cities = [
  { name: '上海', query: 'Shanghai' },
  { name: '江苏通州', query: 'Tongzhou' },
  { name: '湖南桃江', query: 'Taojiang' },
];

async function getWeather(query) {
  try {
    // 添加语言参数和超时
    const result = execSync(
      `curl -s "wttr.in/${query}?format=%c+%t(体感+%f),%w风,%h湿度&lang=zh"`,
      { encoding: 'utf-8', timeout: 15000 }
    );
    return result.trim() || '暂无数据';
  } catch (e) {
    return '获取超时，请重试';
  }
}

async function main() {
  const now = new Date();
  const timeStr = now.toLocaleString('zh-CN', {
    month: 'short',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
  });

  console.log(`🌤️ 天气预报 ${timeStr}`);
  console.log('');

  for (const city of cities) {
    const weather = await getWeather(city.query);
    console.log(`📍 ${city.name}: ${weather}`);
  }

  console.log('');
  console.log('---');
  console.log('⏰ 每小时自动更新 · 数据来源: wttr.in');
}

main().catch(console.error);
