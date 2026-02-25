interface StatsProps {
  total: number;
  active: number;
  completed: number;
  onClearCompleted: () => void;
}

export function Stats({ total, active, completed, onClearCompleted }: StatsProps) {
  const progress = total > 0 ? (completed / total) * 100 : 0;

  return (
    <div className="space-y-3">
      <div className="h-2 bg-gray-200 rounded-full overflow-hidden">
        <div
          className="h-full bg-primary-500 transition-all duration-500 ease-out rounded-full"
          style={{ width: `${progress}%` }}
        />
      </div>
      
      <div className="flex items-center justify-between text-sm">
        <div className="flex gap-4 text-gray-500">
          <span>共 <span className="font-semibold text-gray-700">{total}</span> 项</span>
          <span>已完成 <span className="font-semibold text-primary-600">{completed}</span> 项</span>
        </div>
        
        {completed > 0 && (
          <button
            onClick={onClearCompleted}
            className="text-gray-400 hover:text-red-500 transition-colors text-sm"
          >
            清除已完成
          </button>
        )}
      </div>
    </div>
  );
}
