const experiences = [
  {
    title: "Senior Data Analyst",
    company: "CBRE",
    location: "Seattle, Washington, United States",
    period: "Sep 2022 - Present",
    achievements: [
      "Architected and implemented a scalable data warehouse for a multi-billion dollar global real estate portfolio, developing data models that fed and enhanced reporting visualizations for executive decision-makers.",
      "Built and maintained analytics data pipelines to ingest, clean, and enrich data from various sources, utilizing Python and Airflow to automate global forecasting models and reduce monthly analyst workload by over 160 hours.",
      "Designed and refactored the Facilities Usage Report (FUR) dashboard, a critical tool for operational compliance, by implementing a refactor to a single source of truth and adding new features that improved data accuracy and user understanding.",
      "Pioneered a global location scoring methodology that leverages 32 features across 6 categories to identify optimal locations for Meta facilities, and designed the visualizations to clearly communicate this complex analysis.",
      "Spearheaded data classification and permission management initiatives on Tableau Server as part of a company-wide privacy wave, ensuring data continuity and compliance for over 200 dashboards and reports.",
      "Authored comprehensive dashboard documentation and curated a Tableau Guide for internal teams, enhancing staff engagement and establishing best practices for analytical reporting.",
      "Collaborated with cross-functional stakeholders to drive rapid operational staffing decisions, transforming complex data into compelling narratives that guided real-time business strategy."
    ]
  },
  {
    title: "Senior Business Analyst",
    company: "CBRE",
    location: "Redmond, Washington, United States",
    period: "Dec 2020 - Sep 2022",
    achievements: [
      "Developed and implemented BI solutions to store, normalize, and report on Diverse Supplier data, improving reporting and data accessibility by 75%.",
      "Led the development of an automated reporting system to track human behavior and provide visual insights to executive leadership, serving as a primary source for strategic decision-making.",
      "Established project delivery governance from scope definition through maintenance, managed in Azure DevOps, driving alignment over $7B+ in program value.",
      "Onboarded, trained, and mentored team members to become leaders."
    ]
  },
  {
    title: "Program Manager - Global Digital Transformation",
    company: "CBRE",
    location: "Redmond, Washington, United States", 
    period: "Apr 2020 - Dec 2020",
    achievements: [
      "Led a global digital transformation program, generating $15M in new business.",
      "Reduced costs by $500K annually by insourcing cloud consulting resources.",
      "Increased project velocity by 150% by implementing global communication and collaboration practices.",
      "Standardized global data collection and implemented cloud-computed reporting, improving efficiency and accuracy.",
      "Developed and documented deep technologies and project governance processes and tools, aligning international stakeholders and streamlining operations.",
      "Created and maintained global web-based environments for data and information mining, supporting continuous learning and improvement."
    ]
  },
  {
    title: "Business Systems Analyst - Campus Modernization",
    company: "CBRE",
    location: "Redmond, Washington, United States",
    period: "Mar 2019 - Apr 2020",
    achievements: [
      "Designed and built scalable, governed enterprise data models and data warehouses hosted on Microsoft Azure SQL, supporting over 500 users and $5B in annual budgets.",
      "Developed automated bug reporting and training materials, reducing user issues by 95% and improving team productivity by 4x.",
      "Led the design and development of front-to-back-end web applications, streamlining business processes and improving user satisfaction."
    ]
  },
  {
    title: "Associate Project Manager - Campus Modernization",
    company: "CBRE",
    location: "Redmond, WA, United States",
    period: "May 2018 - Mar 2019",
    achievements: [
      "Led the design and architecture of an easy-to-use training hub on SharePoint using modern web technologies.",
      "Led the design and maintenance of a weekly publication delivered to 100+ stakeholders."
    ]
  },
  {
    title: "Studio Coordinator",
    company: "SkB Architects",
    location: "Greater Seattle Area, United States",
    period: "Aug 2016 - May 2018",
    achievements: [
      "Project Management, Business Operations, Data Cleaning"
    ]
  },
  {
    title: "Project Assistant",
    company: "LMN Architects", 
    location: "Seattle, Washington, United States",
    period: "Oct 2015 - Aug 2016",
    achievements: [
      "Project Management, Business Operations, Data Cleaning, Microsoft Excel"
    ]
  },
  {
    title: "General Manager",
    company: "Chipotle Mexican Grill",
    location: "Harrisonburg, Virginia, United States",
    period: "Sep 2012 - Jul 2015",
    achievements: [
      "Project Management, Operations Leadership, Team Development"
    ]
  }
];

export function Experience() {
  return (
    <section>
      <div className="text-center mb-12">
        <h2 className="text-4xl font-bold mb-4 text-white">Experience</h2>
        <div className="w-24 h-1 bg-gradient-to-r from-purple-500 to-emerald-500 mx-auto"></div>
      </div>

      <div className="space-y-8">
        {experiences.map((exp, index) => (
          <div key={index} className="bg-gray-800/50 rounded-xl p-6 border border-gray-700 hover:border-purple-500/50 transition-all duration-300">
            <div className="flex flex-col md:flex-row md:justify-between md:items-start mb-4">
              <div className="mb-2 md:mb-0">
                <h3 className="text-xl font-bold text-white mb-1">{exp.title}</h3>
                <p className="text-purple-400 font-semibold">{exp.company}</p>
                <p className="text-gray-400 text-sm">{exp.location}</p>
              </div>
              <div className="text-emerald-400 font-medium text-sm bg-emerald-500/10 px-3 py-1 rounded-full border border-emerald-500/30">
                {exp.period}
              </div>
            </div>
            
            <ul className="space-y-3">
              {exp.achievements.map((achievement, achIndex) => (
                <li key={achIndex} className="text-gray-300 flex items-start gap-3">
                  <div className="w-2 h-2 bg-gradient-to-r from-purple-500 to-emerald-500 rounded-full mt-2 flex-shrink-0"></div>
                  <span className="leading-relaxed">{achievement}</span>
                </li>
              ))}
            </ul>
          </div>
        ))}
      </div>
    </section>
  );
}