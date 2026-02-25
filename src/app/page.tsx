'use client';

import { TodoInput, TodoItem, FilterTabs, Stats } from '@/components';
import { useTodos } from '@/hooks/useTodos';

export default function Home() {
  const {
    todos,
    allTodos,
    filter,
    setFilter,
    addTodo,
    toggleTodo,
    deleteTodo,
    updateTodo,
    clearCompleted,
    stats,
    isLoaded,
  } = useTodos();

  if (!isLoaded) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="animate-pulse text-gray-400">加载中...⏳</div>
      </div>
    );
  }

  return (
    <div className="min-h-screen py-8 px-4 sm:px-6 lg:px-8">
      <div className="max-w-2xl mx-auto">
        {/* Header */}
        <div className="text-center mb-8">
          <h1 className="text-4xl font-bold text-gray-800 mb-2">
            ✅ 待办事项
          </h1>
          <p className="text-gray-500">管理你的任务，高效完成目标</p>
        </div>

        {/* Main Card */}
        <div className="bg-white rounded-2xl shadow-xl shadow-gray-200/50 overflow-hidden">
          <div className="p-6 space-y-6">
            {/* Input */}
            <TodoInput onAdd={addTodo} />

            {/* Filter Tabs */}
            <FilterTabs
              currentFilter={filter}
              onFilterChange={setFilter}
              counts={{
                all: stats.total,
                active: stats.active,
                completed: stats.completed,
              }}
            />

            {/* Todo List */}
            <div className="space-y-2">
              {todos.length === 0 ? (
                <div className="text-center py-12 text-gray-400">
                  <div className="text-5xl mb-4">📝</div>
                  <p className="text-lg">
                    {filter === 'all'
                      ? '还没有任务，添加一个吧！'
                      : filter === 'active'
                      ? '没有进行中的任务'
                      : '没有已完成的任务'
                    }
                  </p>
                </div>
              ) : (
                todos.map((todo) => (
                  <TodoItem
                    key={todo.id}
                    todo={todo}
                    onToggle={toggleTodo}
                    onDelete={deleteTodo}
                    onUpdate={updateTodo}
                  />
                ))
              )}
            </div>

            {/* Stats */}
            {stats.total > 0 && (
              <Stats
                total={stats.total}
                active={stats.active}
                completed={stats.completed}
                onClearCompleted={clearCompleted}
              />
            )}
          </div>
        </div>

        {/* Footer */}
        <p className="text-center text-gray-400 text-sm mt-8">
          双击任务可编辑 • 数据自动保存
        </p>
      </div>
    </div>
  );
}
