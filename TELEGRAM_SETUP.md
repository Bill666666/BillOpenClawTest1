# Telegram Bot 配置指南

## 🎯 目标
配置 Telegram Bot，每小时自动推送上海、江苏通州、湖南桃江的天气预报。

---

## 📱 步骤一：创建 Bot

### 1. 打开 Telegram App
- 搜索 `@BotFather`
- 点击 **Start**

### 2. 创建新 Bot
发送：
```
/newbot
```

### 3. 设置名称
输入 Bot 名称（显示名称）：
```
Bill天气助手
```

### 4. 设置用户名
输入 Bot 用户名（必须唯一，以 bot 结尾）：
```
bill_weather_bot
```

### 5. 保存 Token
BotFather 会回复：
```
Done! Congratulations on your new bot.

Use this token to access the HTTP API:
1234567890:ABCdefGHIjklMNOpqrSTUvwxyz123456789
```

**⚠️ 复制并保存 Token！**

---

## 🔍 步骤二：获取 Chat ID

### 1. 找到你的 Bot
- 在 Telegram 搜索 `@bill_weather_bot`（你的用户名）
- 点击进入对话
- 点击 **Start** 或发送任意消息（如"你好"）

### 2. 获取 Chat ID
在浏览器访问：
```
https://api.telegram.org/bot<你的Token>/getUpdates
```

例如：
```
https://api.telegram.org/bot1234567890:ABCdefGHIjklMNOpqrSTUvwxyz123456789/getUpdates
```

### 3. 找到 ID
在返回的 JSON 中找到：
```json
{
  "update_id": 123456789,
  "message": {
    "message_id": 1,
    "from": {...},
    "chat": {
      "id": 123456789,  ← 这就是 Chat ID！
      "first_name": "YourName",
      "type": "private"
    },
    "date": 1708876800,
    "text": "你好"
  }
}
```

**⚠️ 保存 Chat ID（数字）！**

---

## 🔐 步骤三：配置 GitHub Secrets

### 1. 打开 GitHub 仓库
访问：
```
https://github.com/Bill666666/BillOpenClawTest1/settings/secrets/actions
```

### 2. 添加 Secrets

点击 **New repository secret**

#### Secret 1: TELEGRAM_BOT_TOKEN
- **Name**: `TELEGRAM_BOT_TOKEN`
- **Value**: `1234567890:ABCdefGHIjklMNOpqrSTUvwxyz123456789`（你的 Token）

#### Secret 2: TELEGRAM_CHAT_ID
- **Name**: `TELEGRAM_CHAT_ID`
- **Value**: `123456789`（你的 Chat ID）

### 3. 保存
点击 **Add secret**

---

## ✅ 步骤四：启用 GitHub Actions

### 1. 进入 Actions 页面
```
https://github.com/Bill666666/BillOpenClawTest1/actions
```

### 2. 启用 Actions
如果看到提示 **"Actions is disabled for this repository"**，点击 **Enable Actions**

### 3. 手动测试
- 找到 **"Hourly Weather Report to Telegram"** 工作流
- 点击 **Run workflow**
- 等待几秒钟
- 检查 Telegram 是否收到消息

---

## ⏰ 自动推送时间

配置完成后，**每小时整点**（北京时间 8:00, 9:00, 10:00...）会自动推送天气。

---

## 🧪 测试命令

手动发送测试消息：
```bash
curl -X POST "https://api.telegram.org/bot<TOKEN>/sendMessage" \
  -d "chat_id=<CHAT_ID>" \
  -d "text=测试消息：配置成功！🎉"
```

---

## 📋 总结

| 步骤 | 操作 | 输出 |
|------|------|------|
| 1 | 找 @BotFather 创建 Bot | **Bot Token** |
| 2 | 给 Bot 发消息，访问 API | **Chat ID** |
| 3 | 在 GitHub 添加 Secrets | 安全存储 |
| 4 | 启用 Actions | 自动运行 |

---

**完成这些步骤后，告诉我，我帮你验证配置是否正确！** 🚀
