# Telegram Channel 配置

## 启用 Telegram 交互

OpenClaw 原生支持 Telegram，可以与 WhatsApp 一样进行双向对话。

## 配置步骤

### 1. 获取 Bot Token
你已经有了：`8763873900:AAGknhOLVa3vPHHBdbtLjDdCEsyMH2bp2ps`

### 2. 配置 OpenClaw Gateway

在 Codespace 终端执行：

```bash
# 添加 Telegram channel
openclaw channels add telegram --token "8763873900:AAGknhOLVa3vPHHBdbtLjDdCEsyMH2bp2ps"

# 重启 Gateway
openclaw gateway restart
```

### 3. 给 Bot 发消息

在 Telegram 中：
1. 找到 `@chaoran_weather_bot`
2. 发送任意消息（如"你好"）
3. OpenClaw 会收到消息并回复

## 特点

| 功能 | 支持 |
|------|------|
| 实时对话 | ✅ |
| 发送图片 | ✅ |
| 群聊支持 | ✅ |
| 多设备同步 | ✅ |

## 费用

- **需要保持 Codespace 运行**（因为要维持 Gateway 连接）
- 与 WhatsApp 费用相同

---

## 对比

| 方案 | 交互 | 自动推送 | 费用 | 需要 Codespace |
|------|------|----------|------|----------------|
| **WhatsApp** | ✅ | ❌ | 免费额度内 | ✅ |
| **GitHub Actions + Telegram** | ❌ | ✅ | **永久免费** | ❌ |
| **Telegram Channel** | ✅ | ✅ | 免费额度内 | ✅ |

---

## 建议

**当前（Codespace 运行中）：**
- WhatsApp 和 Telegram 都可以交互
- 同时享受 Actions 的自动天气推送

**两天后（停止 Codespace）：**
- 失去 WhatsApp/Telegram 交互
- **保留** Actions 自动天气推送
