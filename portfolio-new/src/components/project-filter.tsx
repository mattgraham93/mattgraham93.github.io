"use client";

interface ProjectFilterProps {
  projects: any[];
  selectedCategory: string;
  onCategoryChange: (category: string) => void;
  selectedTags: string[];
  onTagsChange: (tags: string[]) => void;
  searchTerm: string;
  onSearchChange: (term: string) => void;
  allTags: string[];
}

export function ProjectFilter({
  projects,
  selectedCategory,
  onCategoryChange,
  selectedTags,
  onTagsChange,
  searchTerm,
  onSearchChange,
  allTags
}: ProjectFilterProps) {
  const categories = [
    { id: "all", label: "All Projects", count: projects.length },
    { id: "professional", label: "Professional", count: projects.filter(p => p.category === "professional").length },
    { id: "academic", label: "Academic", count: projects.filter(p => p.category === "academic").length },
    { id: "personal", label: "Personal", count: projects.filter(p => p.category === "personal").length }
  ];

  const toggleTag = (tag: string) => {
    if (selectedTags.includes(tag)) {
      onTagsChange(selectedTags.filter(t => t !== tag));
    } else {
      onTagsChange([...selectedTags, tag]);
    }
  };

  return (
    <div className="mb-12 space-y-6">
      {/* Search Bar */}
      <div className="max-w-md mx-auto">
        <div className="relative">
          <svg 
            className="absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400 w-5 h-5" 
            fill="none" 
            stroke="currentColor" 
            viewBox="0 0 24 24"
          >
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
          </svg>
          <input
            type="text"
            placeholder="Search projects..."
            value={searchTerm}
            onChange={(e) => onSearchChange(e.target.value)}
            className="w-full pl-10 pr-4 py-3 bg-gray-800/50 border border-gray-700 rounded-lg focus:border-purple-500 focus:outline-none text-white placeholder-gray-400"
          />
        </div>
      </div>

      {/* Category Filter */}
      <div className="flex flex-wrap justify-center gap-4">
        {categories.map((category) => (
          <button
            key={category.id}
            onClick={() => onCategoryChange(category.id)}
            className={`px-6 py-3 rounded-lg font-medium transition-all duration-300 ${
              selectedCategory === category.id
                ? "bg-gradient-to-r from-purple-600 to-blue-600 text-white shadow-lg"
                : "bg-gray-800/50 text-gray-300 hover:bg-gray-700/50 border border-gray-700"
            }`}
          >
            {category.label}
            <span className="ml-2 text-sm opacity-75">({category.count})</span>
          </button>
        ))}
      </div>

      {/* Tag Filter */}
      <div className="max-w-4xl mx-auto">
        <h3 className="text-lg font-semibold text-gray-300 mb-4 text-center">Filter by Technology</h3>
        <div className="flex flex-wrap justify-center gap-2">
          {allTags.map((tag) => (
            <button
              key={tag}
              onClick={() => toggleTag(tag)}
              className={`px-3 py-1 text-sm rounded-full transition-all duration-300 ${
                selectedTags.includes(tag)
                  ? "bg-emerald-500/20 text-emerald-300 border border-emerald-500/50"
                  : "bg-gray-800/50 text-gray-400 hover:bg-gray-700/50 border border-gray-700"
              }`}
            >
              {tag}
            </button>
          ))}
        </div>
      </div>

      {/* Active Filters */}
      {(selectedCategory !== "all" || selectedTags.length > 0 || searchTerm) && (
        <div className="flex flex-wrap justify-center gap-2 pt-4 border-t border-gray-700">
          <span className="text-gray-400 text-sm">Active filters:</span>
          {selectedCategory !== "all" && (
            <span className="px-3 py-1 bg-purple-500/20 text-purple-300 rounded-full text-sm flex items-center gap-2">
              {selectedCategory}
              <button 
                onClick={() => onCategoryChange("all")}
                className="hover:text-purple-100"
              >
                ×
              </button>
            </span>
          )}
          {selectedTags.map((tag) => (
            <span key={tag} className="px-3 py-1 bg-emerald-500/20 text-emerald-300 rounded-full text-sm flex items-center gap-2">
              {tag}
              <button 
                onClick={() => toggleTag(tag)}
                className="hover:text-emerald-100"
              >
                ×
              </button>
            </span>
          ))}
          {searchTerm && (
            <span className="px-3 py-1 bg-blue-500/20 text-blue-300 rounded-full text-sm flex items-center gap-2">
              "{searchTerm}"
              <button 
                onClick={() => onSearchChange("")}
                className="hover:text-blue-100"
              >
                ×
              </button>
            </span>
          )}
        </div>
      )}
    </div>
  );
}