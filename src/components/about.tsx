export function About() {
  return (
    <section className="py-20 px-4 bg-gray-900/50">
      <div className="max-w-4xl mx-auto">
        <div className="text-center mb-12">
          <h2 className="text-4xl font-bold mb-4 text-white">A little about me</h2>
          <div className="w-24 h-1 bg-gradient-to-r from-purple-500 to-emerald-500 mx-auto"></div>
        </div>
        
        <div className="grid gap-8 text-lg leading-relaxed">
          <p className="text-gray-300">
            Hi there! I'm Mattie Graham, a passionate and humble data enthusiast with expertise in 
            <span className="text-purple-400 font-semibold"> ethical data practices</span>. I strive to make 
            complex math and data meaningful in our daily lives.
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

        <div className="mt-12 grid grid-cols-1 md:grid-cols-3 gap-8">
          <div className="text-center p-6 rounded-lg bg-gray-800/50 border border-gray-700">
            <div className="text-3xl font-bold text-purple-400 mb-2">9+</div>
            <div className="text-gray-300">Years Experience</div>
          </div>
          <div className="text-center p-6 rounded-lg bg-gray-800/50 border border-gray-700">
            <div className="text-3xl font-bold text-blue-400 mb-2">$7B+</div>
            <div className="text-gray-300">Program Value Managed</div>
          </div>
          <div className="text-center p-6 rounded-lg bg-gray-800/50 border border-gray-700">
            <div className="text-3xl font-bold text-emerald-400 mb-2">15M</div>
            <div className="text-gray-300">New Business Generated</div>
          </div>
        </div>
      </div>
    </section>
  );
}