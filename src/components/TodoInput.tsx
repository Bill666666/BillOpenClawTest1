'use client';

import { useState, useRef } from 'react';

interface TodoInputProps {
  onAdd: (text: string) => void;
}

export function TodoInput({ onAdd }: TodoInputProps) {
  const [text, setText] = useState('');
  const inputRef = useRef<HTMLInputElement>(null);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (text.trim()) {
      onAdd(text);
      setText('');
      inputRef.current?.focus();
    }
  };

  return (
    <form onSubmit={handleSubmit} className="w-full">
      <div className="flex gap-3">
        <input
          ref={inputRef}
          type="text"
          value={text}
          onChange={(e) => setText(e.target.value)}
          placeholder="添加新任务..."
          className="flex-1 px-4 py-3 rounded-xl border-2 border-gray-200 
                     focus:border-primary-500 focus:outline-none 
                     transition-colors duration-200 text-gray-700
                     placeholder:text-gray-400 bg-white"
        />
        <button
          type="submit"
          className="px-6 py-3 bg-primary-500 hover:bg-primary-600 
                     text-white font-semibold rounded-xl
                     transition-all duration-200 
                     hover:shadow-lg hover:shadow-primary-500/25
                     active:scale-95"
        >
          添加
        </button>
      </div>
    </form>
  );
}
