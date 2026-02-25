# Todo List - 待办事项管理应用

一个简洁优雅的待办事项管理应用，使用 Next.js + TypeScript + Tailwind CSS 构建。

## 🚀 在线访问

**Codespace 公网链接：**
```
https://bookish-orbit-9qvvwq455rxf7jq9-3000.app.github.dev
```

> 在 VS Code 中也可通过 PORTS 面板的 3000 端口访问

## ✨ 功能特性

| 功能 | 说明 |
|------|------|
| 📝 **添加任务** | 快速输入框，一键添加待办事项 |
| ✅ **标记完成** | 点击圆圈切换完成/未完成状态 |
| ✏️ **编辑任务** | 双击任务或点击编辑按钮修改内容 |
| 🗑️ **删除任务** | 悬停显示删除按钮，快速移除任务 |
| 🔍 **筛选视图** | 支持全部 / 进行中 / 已完成三种筛选 |
| 📊 **进度统计** | 可视化进度条，实时显示完成比例 |
| 💾 **自动保存** | 数据存储在浏览器本地，刷新不丢失 |
| 📱 **响应式设计** | 完美适配手机、平板、桌面端 |

## 🛠️ 技术栈

- **框架：** [Next.js 14](https://nextjs.org/) (React 18)
- **语言：** [TypeScript](https://www.typescriptlang.org/)
- **样式：** [Tailwind CSS](https://tailwindcss.com/)
- **部署：** GitHub Codespace

## 📦 安装与运行

### 1. 克隆仓库

```bash
git clone https://github.com/Bill666666/BillOpenClawTest1.git
cd BillOpenClawTest1
```

### 2. 安装依赖

```bash
npm install
```

### 3. 启动开发服务器

```bash
npm run dev
```

开发服务器启动后，访问 http://localhost:3000

### 4. 构建生产版本

```bash
npm run build
npm start
```

## 📁 项目结构

```
BillOpenClawTest1/
├── src/
│   ├── app/
│   │   ├── globals.css      # 全局样式
│   │   ├── layout.tsx       # 根布局组件
│   │   └── page.tsx         # 主页面
│   ├── components/
│   │   ├── TodoInput.tsx    # 任务输入组件
│   │   ├── TodoItem.tsx     # 任务项组件
│   │   ├── FilterTabs.tsx   # 筛选标签组件
│   │   ├── Stats.tsx        # 统计组件
│   │   └── index.ts         # 组件导出
│   ├── hooks/
│   │   └── useTodos.ts      # 任务管理自定义 Hook
│   ├── types/
│   │   └── todo.ts          # TypeScript 类型定义
│   └── utils/               # 工具函数
├── tailwind.config.ts       # Tailwind CSS 配置
├── next.config.mjs          # Next.js 配置
├── tsconfig.json            # TypeScript 配置
└── package.json             # 项目依赖
```

## 🎨 设计规范

- **配色方案：** 绿色主题 (#22c55e)，清新自然
- **UI 风格：** 卡片式设计，圆角阴影，现代简约
- **交互体验：** 平滑动画，即时反馈，双击编辑
- **响应式：** 移动端优先，适配各种屏幕尺寸

## 🔧 开发注意事项

1. **避免蓝紫渐变色** - 项目设计规范要求
2. **组件使用 `.tsx` 扩展名**
3. **样式优先使用 Tailwind 工具类**
4. **类型定义放在 `types/` 目录**

## 📝 最近更新

- ✅ 完成基础 Todo List 功能
- ✅ 添加编辑功能
- ✅ 添加筛选功能
- ✅ 添加进度统计
- ✅ 修复三元运算符语法错误

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License

---

由 OpenClaw 助手协助开发 🦞
