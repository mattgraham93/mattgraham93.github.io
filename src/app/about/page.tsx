import Image from "next/image";

export default function AboutPage() {
  return (
    <div className="min-h-screen pt-20 px-4">
      <div className="max-w-6xl mx-auto">
        <div className="text-center mb-16">
          <h1 className="text-5xl font-bold mb-4 bg-gradient-to-r from-purple-400 via-blue-400 to-emerald-400 bg-clip-text text-transparent">
            About Me
          </h1>
          <p className="text-xl text-gray-400">
            My journey from general management to data visualization engineering
          </p>
          <div className="w-24 h-1 bg-gradient-to-r from-purple-500 to-emerald-500 mx-auto mt-8"></div>
        </div>

        <div className="grid lg:grid-cols-3 gap-12 items-start">
          {/* Left Column - Image and Quick Stats */}
          <div className="lg:col-span-1">
            <div className="sticky top-32">
              <div className="relative mb-8">
                <div className="w-full max-w-sm mx-auto rounded-2xl overflow-hidden border-2 border-purple-500/20 shadow-2xl shadow-purple-500/20">
                  <Image
                    src="/assets/images/1843.png"
                    alt="Mattie #1843"
                    width={400}
                    height={400}
                    className="w-full h-full object-cover"
                  />
                </div>
              </div>
              
              <div className="space-y-4">
                <div className="bg-gray-800/50 rounded-lg p-4 border border-gray-700">
                  <div className="text-2xl font-bold text-purple-400 mb-1">9+</div>
                  <div className="text-gray-300 text-sm">Years Experience</div>
                </div>
                <div className="bg-gray-800/50 rounded-lg p-4 border border-gray-700">
                  <div className="text-2xl font-bold text-blue-400 mb-1">$7B+</div>
                  <div className="text-gray-300 text-sm">Program Value</div>
                </div>
                <div className="bg-gray-800/50 rounded-lg p-4 border border-gray-700">
                  <div className="text-2xl font-bold text-emerald-400 mb-1">$15M</div>
                  <div className="text-gray-300 text-sm">New Business</div>
                </div>
                <div className="bg-gray-800/50 rounded-lg p-4 border border-gray-700">
                  <div className="text-2xl font-bold text-purple-400 mb-1">3.82</div>
                  <div className="text-gray-300 text-sm">GPA</div>
                </div>
              </div>
            </div>
          </div>

          {/* Right Column - Story */}
          <div className="lg:col-span-2 space-y-8">
            <section>
              <h2 className="text-3xl font-bold text-white mb-6">My Story</h2>
              <div className="space-y-6 text-lg leading-relaxed">
                <p className="text-gray-300">
                  Hi there! I'm Mattie Graham, a passionate and humble data enthusiast with expertise in 
                  <span className="text-purple-400 font-semibold"> ethical data practices</span>. I strive to make 
                  complex math and data meaningful in our daily lives.
                </p>
                
                <p className="text-gray-300">
                  My journey into data began in an unconventional way. I started as a General Manager at Chipotle, 
                  where I learned the importance of operational efficiency and customer experience. This foundation 
                  taught me that behind every business decision, there's data waiting to tell a story.
                </p>
                
                <p className="text-gray-300">
                  I excel in big data technologies like <span className="text-blue-400 font-semibold">R, Python, SQL/HQL, Hadoop, Tableau, Azure, Power BI</span> (and more). 
                  I craft scalable solutions with global impact. As a Program, People, Project, and Data Manager, 
                  Scientist, Engineer, and Analyst, I aim to foster diversity and community in the industry.
                </p>
                
                <p className="text-gray-300">
                  Connect with me to embark on a transformative journey. Together, you'll revolutionize 
                  <span className="text-emerald-400 font-semibold"> data-driven solutions</span>, one humble step at a time.
                </p>
              </div>
            </section>

            <section>
              <h2 className="text-3xl font-bold text-white mb-6">Technical Expertise</h2>
              <div className="grid md:grid-cols-2 gap-6">
                <div className="bg-gray-800/50 rounded-lg p-6 border border-gray-700">
                  <h3 className="text-xl font-semibold text-purple-400 mb-4">Data Visualization & Web</h3>
                  <div className="space-y-2 text-gray-300">
                    <div>JavaScript, HTML, CSS</div>
                    <div>Tableau, D3.js, React</div>
                    <div>User Experience (UX)</div>
                    <div>Responsive Design</div>
                  </div>
                </div>
                
                <div className="bg-gray-800/50 rounded-lg p-6 border border-gray-700">
                  <h3 className="text-xl font-semibold text-blue-400 mb-4">Data Analysis & Engineering</h3>
                  <div className="space-y-2 text-gray-300">
                    <div>Expert SQL, Python, R</div>
                    <div>Airflow, ETL/ELT Development</div>
                    <div>BigQuery, Snowflake, dbt</div>
                    <div>Data Warehousing</div>
                  </div>
                </div>
                
                <div className="bg-gray-800/50 rounded-lg p-6 border border-gray-700">
                  <h3 className="text-xl font-semibold text-emerald-400 mb-4">Cloud & Infrastructure</h3>
                  <div className="space-y-2 text-gray-300">
                    <div>Microsoft Azure</div>
                    <div>Databricks, Apache Spark</div>
                    <div>Docker, Kubernetes</div>
                    <div>Git, CI/CD Pipelines</div>
                  </div>
                </div>
                
                <div className="bg-gray-800/50 rounded-lg p-6 border border-gray-700">
                  <h3 className="text-xl font-semibold text-purple-400 mb-4">Leadership & Process</h3>
                  <div className="space-y-2 text-gray-300">
                    <div>Cross-functional Communication</div>
                    <div>Stakeholder Management</div>
                    <div>Agile Methodologies</div>
                    <div>Data Governance</div>
                  </div>
                </div>
              </div>
            </section>

            <section>
              <h2 className="text-3xl font-bold text-white mb-6">Education & Growth</h2>
              <div className="bg-gray-800/50 rounded-lg p-6 border border-gray-700">
                <div className="flex justify-between items-start mb-4">
                  <div>
                    <h3 className="text-xl font-semibold text-white">Bachelor of Applied Science</h3>
                    <p className="text-purple-400 font-medium">Data Management and Analysis</p>
                    <p className="text-gray-400">Bellevue College</p>
                  </div>
                  <div className="text-right">
                    <p className="text-gray-400">2018 - 2024</p>
                    <p className="text-emerald-400 font-semibold">GPA: 3.82</p>
                  </div>
                </div>
                <p className="text-gray-300 text-sm leading-relaxed">
                  Relevant Coursework: Econometrics (R), Predictive Analytics (Python/R), Advanced Marketing Analytics (Tableau), 
                  Multivariate Analysis (R), Applied Statistical Methods (Python), Business Intelligence Applications (SQL/Tableau/PowerBI), 
                  Database Theory, Data Visualization, Systems Analysis and Design.
                </p>
              </div>
            </section>
          </div>
        </div>
      </div>
    </div>
  );
}