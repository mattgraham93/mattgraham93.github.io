import Link from "next/link";
import { projects, featuredConfig } from '@/data/cms-config';
import ProjectImage from './project-image';

// Get featured projects from CMS data
const featuredProjects = projects
  .filter(project => project.featured)
  .slice(0, featuredConfig.maxFeaturedProjects)
  .map(project => ({
    title: project.title,
    description: project.description,
    image: project.image,
    link: project.demoUrl || project.githubUrl || `/projects/${project.id}`,
    tags: project.tags
  }));

export function FeaturedProjects() {
  return (
    <section className="py-20 px-4">
      <div className="max-w-7xl mx-auto">
        <div className="text-center mb-16">
          <h2 className="text-4xl font-bold mb-4 text-white">Featured Projects</h2>
          <p className="text-xl text-gray-400 mb-8">Professional and personal work showcasing data-driven solutions</p>
          <div className="w-24 h-1 bg-gradient-to-r from-purple-500 to-emerald-500 mx-auto"></div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
          {featuredProjects.map((project, index) => (
            <div 
              key={index}
              className="group bg-gray-800/50 rounded-xl overflow-hidden border border-gray-700 hover:border-purple-500/50 transition-all duration-500 ease-out hover:shadow-xl hover:shadow-purple-500/10 hover:transform hover:scale-[1.02]"
            >
              <div className="relative overflow-hidden">
                <ProjectImage
                  src={project.image}
                  alt={project.title}
                  width={600}
                  height={300}
                  className="w-full h-64 object-cover transition-transform duration-500 ease-out group-hover:scale-105"
                />
                <div className="absolute inset-0 bg-gradient-to-t from-gray-900/60 to-transparent opacity-0 group-hover:opacity-100 transition-all duration-500 ease-in-out"></div>
              </div>
              
              <div className="p-6">
                <div className="flex flex-wrap gap-2 mb-3">
                  {project.tags.map((tag, tagIndex) => (
                    <span 
                      key={tagIndex}
                      className="px-3 py-1 text-xs font-medium bg-purple-500/20 text-purple-300 rounded-full"
                    >
                      {tag}
                    </span>
                  ))}
                </div>
                
                <h3 className="text-xl font-bold text-white mb-3 group-hover:text-purple-400 transition-colors duration-300 ease-out">
                  {project.title}
                </h3>
                
                <p className="text-gray-400 mb-4 leading-relaxed">
                  {project.description}
                </p>
                
                <Link 
                  href={project.link}
                  className="inline-flex items-center gap-2 text-emerald-400 hover:text-emerald-300 font-semibold transition-all duration-300 ease-out"
                  target={project.link.startsWith('http') ? '_blank' : '_self'}
                >
                  Read More
                  <svg className="w-4 h-4 transition-transform duration-300 ease-out group-hover:translate-x-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
                  </svg>
                </Link>
              </div>
            </div>
          ))}
        </div>

        <div className="text-center mt-12">
          <Link 
            href="/projects"
            className="px-8 py-4 bg-gradient-to-r from-purple-600 to-blue-600 hover:from-purple-700 hover:to-blue-700 rounded-lg font-semibold transition-all duration-300 transform hover:scale-105 shadow-lg hover:shadow-xl"
          >
            View All Projects
          </Link>
        </div>
      </div>
    </section>
  );
}