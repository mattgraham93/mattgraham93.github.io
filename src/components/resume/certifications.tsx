const certifications = [
  {
    name: "Google Data Analytics Certificate",
    issuer: "Coursera",
    date: "August 2022",
    color: "emerald"
  },
  {
    name: "Advanced SQL for Data Scientists",
    issuer: "LinkedIn Learning",
    date: "August 2022", 
    color: "blue"
  },
  {
    name: "Tableau Essential Training",
    issuer: "LinkedIn Learning",
    date: "November 2022",
    color: "purple"
  },
  {
    name: "Google Analytics Certification",
    issuer: "Google",
    date: "November 2022",
    color: "indigo"
  },
  {
    name: "Google Ads - Measurement Certification", 
    issuer: "Google",
    date: "October 2022",
    color: "emerald"
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

export function Certifications() {
  return (
    <section>
      <div className="text-center mb-12">
        <h2 className="text-4xl font-bold mb-4 text-white">Certifications</h2>
        <div className="w-24 h-1 bg-gradient-to-r from-purple-500 to-emerald-500 mx-auto"></div>
      </div>

      <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
        {certifications.map((cert, index) => {
          const colors = getColorClasses(cert.color);
          return (
            <div 
              key={index} 
              className="bg-gray-800/50 rounded-xl p-6 border border-gray-700 hover:border-purple-500/50 transition-all duration-300 hover:shadow-xl hover:shadow-purple-500/10"
            >
              <div className={`inline-block px-3 py-1 text-xs font-medium rounded-full border mb-4 ${colors.bg} ${colors.text} ${colors.border}`}>
                {cert.date}
              </div>
              <h3 className="text-xl font-bold text-white mb-2 leading-tight">
                {cert.name}
              </h3>
              <p className={`font-semibold ${colors.text}`}>
                {cert.issuer}
              </p>
            </div>
          );
        })}
      </div>

      {/* Additional Information */}
      <div className="mt-12 bg-gray-800/30 rounded-xl p-6 border border-gray-700 text-center">
        <h3 className="text-xl font-bold text-white mb-4">Continuous Learning</h3>
        <p className="text-gray-400 leading-relaxed">
          Committed to staying current with emerging technologies and best practices in data science, 
          analytics, and visualization. Regularly pursuing additional certifications and professional 
          development opportunities to enhance skills and knowledge.
        </p>
      </div>
    </section>
  );
}