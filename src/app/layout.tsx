import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Todo List - 任务管理",
  description: "一个简洁优雅的待办事项管理应用",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="zh-CN">
      <body className="antialiased">{children}</body>
    </html>
  );
}
