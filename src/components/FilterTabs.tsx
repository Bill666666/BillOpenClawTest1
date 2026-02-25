import { FilterType } from '@/types/todo';

interface FilterTabsProps {
  currentFilter: FilterType;
  onFilterChange: (filter: FilterType) => void;
  counts: {
    all: number;
    active: number;
    completed: number;
  };
}

export function FilterTabs({ currentFilter, onFilterChange, counts }: FilterTabsProps) {
  const tabs: { key: FilterType; label: string }[] = [
    { key: 'all', label: '全部' },
    { key: 'active', label: '进行中' },
    { key: 'completed', label: '已完成' },
  ];

  return (
    <div className="flex gap-1 p-1 bg-gray-100 rounded-xl">
      {tabs.map(({ key, label }) => (
        <button
          key={key}
          onClick={() => onFilterChange(key)}
          className={`flex-1 py-2 px-4 rounded-lg text-sm font-medium transition-all duration-200
            ${currentFilter === key
              ? 'bg-white text-primary-600 shadow-sm'
              : 'text-gray-500 hover:text-gray-700 hover:bg-gray-50'
            }`}
        >
          {label}
          <span className={`ml-2 text-xs px-2 py-0.5 rounded-full ${
            currentFilter === key ? 'bg-primary-100 text-primary-700' : 'bg-gray-200 text-gray-500'
          }`}>
            {counts[key]}
          </span>
        </button>
      ))}
    </div>
  );
}
