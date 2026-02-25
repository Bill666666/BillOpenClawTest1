# Weather Cron Configuration
# 定时天气任务配置

## 任务列表

### 每小时天气预报
- **ID:** weather-hourly-report
- **Schedule:** 0 * * * * (每小时执行)
- **Cities:** 上海、江苏通州、湖南桃江
- **Script:** /workspaces/BillOpenClawTest1/scripts/weather-reporter.js
- **Status:** Active
- **Created:** 2025-02-25
- **Channel:** whatsapp

## 手动执行测试

```bash
node /workspaces/BillOpenClawTest1/scripts/weather-reporter.js
```

## 设置系统 Cron (可选)

```bash
# 编辑 crontab
crontab -e

# 添加每小时执行
0 * * * * cd /workspaces/BillOpenClawTest1 && node scripts/weather-reporter.js >> /tmp/weather-cron.log 2>&1
```

## 通过 OpenClaw Cron 设置

使用命令:
```
openclaw cron add --name "weather-hourly" --schedule "0 * * * *" --command "node /workspaces/BillOpenClawTest1/scripts/weather-reporter.js"
```
