const skillCategories = [
  {
    title: "Data Visualization & Web Development",
    color: "purple",
    skills: [
      "JavaScript", "HTML", "CSS", "Tableau", "Data Visualization", 
      "User Experience (UX)", "Responsive Design", "D3.js", "React", "Git", "Command Line"
    ]
  },
  {
    title: "Data Analysis & Engineering", 
    color: "blue",
    skills: [
      "Expert SQL", "Python", "R", "Airflow", "ETL/ELT Development", 
      "Google BigQuery", "Snowflake", "dbt", "Databricks", "Data Warehousing", "Data Modeling"
    ]
  },
  {
    title: "Cloud & Infrastructure",
    color: "emerald", 
    skills: [
      "Microsoft Azure", "Apache Spark", "Hadoop", "Docker", "Kubernetes",
      "CI/CD Pipelines", "Apache Airflow", "Git Version Control"
    ]
  },
  {
    title: "Collaboration & Process",
    color: "indigo",
    skills: [
      "Cross-functional Communication", "Stakeholder Management", "Requirements Gathering",
      "Agile Methodologies", "Project Management", "Data Governance", "Technical Writing"
    ]
  }
];

const getColorClasses = (color: string) => {
  const colorMap: { [key: string]: { bg: string; text: string; border: string } } = {
    purple: { bg: "bg-purple-500/20", text: "text-purple-300", border: "border-purple-500/50" },
    blue: { bg: "bg-blue-500/20", text: "text-blue-300", border: "border-blue-500/50" },
    emerald: { bg: "bg-emerald-500/20", text: "text-emerald-300", border: "border-emerald-500/50" },
    indigo: { bg: "bg-indigo-500/20", text: "text-indigo-300", border: "border-indigo-500/50" }
  };
  return colorMap[color] || colorMap.purple;
};

export function Skills() {
  return (
    <section>
      <div className="text-center mb-12">
        <h2 className="text-4xl font-bold mb-4 text-white">Technical Skills</h2>
        <div className="w-24 h-1 bg-gradient-to-r from-purple-500 to-emerald-500 mx-auto"></div>
      </div>

      <div className="grid md:grid-cols-2 gap-8">
        {skillCategories.map((category, index) => {
          const colors = getColorClasses(category.color);
          return (
            <div key={index} className="bg-gray-800/50 rounded-xl p-6 border border-gray-700 hover:border-purple-500/50 transition-all duration-300">
              <h3 className={`text-xl font-bold mb-6 ${colors.text}`}>
                {category.title}
              </h3>
              <div className="flex flex-wrap gap-2">
                {category.skills.map((skill, skillIndex) => (
                  <span 
                    key={skillIndex}
                    className={`px-3 py-2 text-sm font-medium rounded-lg border transition-all duration-300 hover:scale-105 ${colors.bg} ${colors.text} ${colors.border}`}
                  >
                    {skill}
                  </span>
                ))}
              </div>
            </div>
          );
        })}
      </div>

      {/* Proficiency Levels */}
      <div className="mt-12 bg-gray-800/30 rounded-xl p-6 border border-gray-700">
        <h3 className="text-xl font-bold text-white mb-6 text-center">Proficiency Levels</h3>
        <div className="grid md:grid-cols-3 gap-6">
          <div className="text-center">
            <div className="text-emerald-400 font-bold text-lg mb-2">Expert</div>
            <div className="text-gray-400 text-sm">SQL, Python, Tableau, Data Visualization, Project Management</div>
          </div>
          <div className="text-center">
            <div className="text-blue-400 font-bold text-lg mb-2">Advanced</div>
            <div className="text-gray-400 text-sm">R, JavaScript, Azure, Airflow, Data Warehousing</div>
          </div>
          <div className="text-center">
            <div className="text-purple-400 font-bold text-lg mb-2">Proficient</div>
            <div className="text-gray-400 text-sm">React, D3.js, Docker, Kubernetes, Apache Spark</div>
          </div>
        </div>
      </div>
    </section>
  );
}