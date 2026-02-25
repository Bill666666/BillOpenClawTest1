#!/usr/bin/env node

/**
 * Weather Cron Daemon
 * 后台循环执行，每小时发送天气报告
 */

const { execSync } = require('child_process');

const cities = [
  { name: '上海', query: 'Shanghai' },
  { name: '江苏通州', query: 'Tongzhou' },
  { name: '湖南桃江', query: 'Taojiang' },
];

function getWeather(query) {
  try {
    const result = execSync(
      `curl -s "wttr.in/${query}?format=%c+%t(体感+%f),%w风,%h湿度&lang=zh"`,
      { encoding: 'utf-8', timeout: 15000 }
    );
    return result.trim() || '暂无数据';
  } catch (e) {
    return '获取超时';
  }
}

function sendWeatherReport() {
  const now = new Date();
  const timeStr = now.toLocaleString('zh-CN', {
    month: 'short',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
  });

  console.log(`\n🌤️ 天气预报 ${timeStr}`);
  console.log('='.repeat(50));

  for (const city of cities) {
    const weather = getWeather(city.query);
    console.log(`📍 ${city.name}: ${weather}`);
  }

  console.log('='.repeat(50));
  console.log('⏰ 下一条将在1小时后发送\n');
}

// 立即执行一次
console.log('🚀 天气定时任务已启动 (每小时更新)');
sendWeatherReport();

// 计算到下一个整点的时间
function getNextHourDelay() {
  const now = new Date();
  const nextHour = new Date(now);
  nextHour.setHours(now.getHours() + 1, 0, 0, 0);
  return nextHour - now;
}

// 定时执行
function scheduleNext() {
  const delay = getNextHourDelay();
  const minutes = Math.round(delay / 60000);
  console.log(`⏳ 距离下次执行还有 ${minutes} 分钟`);
  
  setTimeout(() => {
    sendWeatherReport();
    scheduleNext();
  }, delay);
}

// 启动定时器
scheduleNext();

// 保持进程运行
process.stdin.resume();
