export function Education() {
  return (
    <section>
      <div className="text-center mb-12">
        <h2 className="text-4xl font-bold mb-4 text-white">Education</h2>
        <div className="w-24 h-1 bg-gradient-to-r from-purple-500 to-emerald-500 mx-auto"></div>
      </div>

      <div className="bg-gray-800/50 rounded-xl p-8 border border-gray-700 hover:border-purple-500/50 transition-all duration-300">
        <div className="flex flex-col md:flex-row md:justify-between md:items-start mb-6">
          <div>
            <h3 className="text-2xl font-bold text-white mb-2">Bachelor of Applied Science (BASc)</h3>
            <p className="text-purple-400 font-semibold text-lg mb-1">Data Management and Analysis, Data Analytics</p>
            <p className="text-gray-400">Bellevue College</p>
          </div>
          <div className="text-right mt-4 md:mt-0">
            <div className="text-emerald-400 font-medium bg-emerald-500/10 px-4 py-2 rounded-full border border-emerald-500/30 mb-2">
              2018 - Jun 2024
            </div>
            <div className="text-blue-400 font-bold text-xl">GPA: 3.82</div>
          </div>
        </div>
        
        <div className="mb-6">
          <h4 className="text-lg font-semibold text-white mb-3">Relevant Coursework</h4>
          <div className="grid md:grid-cols-2 gap-4">
            <div className="space-y-2">
              <div className="flex items-center gap-3">
                <div className="w-2 h-2 bg-purple-500 rounded-full"></div>
                <span className="text-gray-300">Econometrics (R)</span>
              </div>
              <div className="flex items-center gap-3">
                <div className="w-2 h-2 bg-blue-500 rounded-full"></div>
                <span className="text-gray-300">Predictive Analytics (Python/R)</span>
              </div>
              <div className="flex items-center gap-3">
                <div className="w-2 h-2 bg-emerald-500 rounded-full"></div>
                <span className="text-gray-300">Advanced Marketing Analytics (Tableau)</span>
              </div>
              <div className="flex items-center gap-3">
                <div className="w-2 h-2 bg-purple-500 rounded-full"></div>
                <span className="text-gray-300">Multivariate Analysis (R)</span>
              </div>
              <div className="flex items-center gap-3">
                <div className="w-2 h-2 bg-blue-500 rounded-full"></div>
                <span className="text-gray-300">Applied Statistical Methods (Python)</span>
              </div>
            </div>
            <div className="space-y-2">
              <div className="flex items-center gap-3">
                <div className="w-2 h-2 bg-emerald-500 rounded-full"></div>
                <span className="text-gray-300">Business Intelligence Applications</span>
              </div>
              <div className="flex items-center gap-3">
                <div className="w-2 h-2 bg-purple-500 rounded-full"></div>
                <span className="text-gray-300">SQL and Relational Database Programming</span>
              </div>
              <div className="flex items-center gap-3">
                <div className="w-2 h-2 bg-blue-500 rounded-full"></div>
                <span className="text-gray-300">Database Theory</span>
              </div>
              <div className="flex items-center gap-3">
                <div className="w-2 h-2 bg-emerald-500 rounded-full"></div>
                <span className="text-gray-300">Data Visualization</span>
              </div>
              <div className="flex items-center gap-3">
                <div className="w-2 h-2 bg-purple-500 rounded-full"></div>
                <span className="text-gray-300">Systems Analysis and Design</span>
              </div>
            </div>
          </div>
        </div>

        <div className="grid md:grid-cols-3 gap-6 pt-6 border-t border-gray-700">
          <div className="text-center p-4 bg-gray-700/30 rounded-lg">
            <div className="text-2xl font-bold text-purple-400 mb-1">6</div>
            <div className="text-gray-300 text-sm">Years Part-Time</div>
          </div>
          <div className="text-center p-4 bg-gray-700/30 rounded-lg">
            <div className="text-2xl font-bold text-blue-400 mb-1">3.82</div>
            <div className="text-gray-300 text-sm">Final GPA</div>
          </div>
          <div className="text-center p-4 bg-gray-700/30 rounded-lg">
            <div className="text-2xl font-bold text-emerald-400 mb-1">Full-Time</div>
            <div className="text-gray-300 text-sm">While Working</div>
          </div>
        </div>
      </div>
    </section>
  );
}