import { notFound } from 'next/navigation';
import Image from 'next/image';
import Link from 'next/link';
import { projects } from '@/data/cms-config';

interface ProjectPageProps {
  params: {
    id: string;
  };
}

// Generate static paths for all projects
export async function generateStaticParams() {
  return projects.map((project) => ({
    id: project.id,
  }));
}

export default async function ProjectPage({ params }: ProjectPageProps) {
  const { id } = await params;
  const project = projects.find(p => p.id === id);

  if (!project) {
    notFound();
  }

  return (
    <div className="min-h-screen pt-20 px-4">
      <div className="max-w-5xl mx-auto">
        {/* Back Button */}
        <Link 
          href="/projects" 
          className="inline-flex items-center gap-2 text-purple-400 hover:text-purple-300 transition-colors mb-8"
        >
          <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
          </svg>
          Back to Projects
        </Link>

        {/* Project Header */}
        <div className="mb-12">
          <div className="flex flex-wrap gap-2 mb-4">
            <span className="px-3 py-1 bg-purple-500/20 text-purple-300 border border-purple-500/50 rounded-full text-sm">
              {project.category}
            </span>
            {project.tags.map((tag) => (
              <span 
                key={tag}
                className="px-3 py-1 bg-gray-700 text-gray-300 rounded-full text-sm"
              >
                {tag}
              </span>
            ))}
          </div>
          
          <h1 className="text-4xl md:text-5xl font-bold mb-6 bg-gradient-to-r from-purple-400 via-blue-400 to-emerald-400 bg-clip-text text-transparent">
            {project.title}
          </h1>
          
          <p className="text-xl text-gray-300 leading-relaxed mb-8">
            {project.description}
          </p>

          {/* Hero Image */}
          <div className="relative rounded-2xl overflow-hidden border border-gray-700 mb-8">
            <Image
              src={project.image}
              alt={project.title}
              width={1200}
              height={600}
              className="w-full h-auto"
              priority
            />
          </div>

          {/* Project Meta */}
          <div className="grid md:grid-cols-3 gap-6 mb-12">
            <div className="bg-gray-800/50 rounded-lg p-4 border border-gray-700">
              <h3 className="text-purple-400 font-semibold mb-2">Technologies</h3>
              <div className="flex flex-wrap gap-2">
                {project.technologies.map((tech) => (
                  <span key={tech} className="text-gray-300 text-sm">
                    {tech}
                  </span>
                ))}
              </div>
            </div>
            
            {project.impact && (
              <div className="bg-gray-800/50 rounded-lg p-4 border border-gray-700">
                <h3 className="text-emerald-400 font-semibold mb-2">Impact</h3>
                <p className="text-2xl font-bold text-white">{project.impact.value}</p>
                <p className="text-gray-400 text-sm">{project.impact.metric}</p>
              </div>
            )}
            
            <div className="bg-gray-800/50 rounded-lg p-4 border border-gray-700">
              <h3 className="text-blue-400 font-semibold mb-2">Links</h3>
              <div className="space-y-2">
                {project.githubUrl && (
                  <a 
                    href={project.githubUrl} 
                    target="_blank" 
                    rel="noopener noreferrer"
                    className="block text-gray-300 hover:text-white transition-colors"
                  >
                    GitHub Repository →
                  </a>
                )}
                {project.demoUrl && (
                  <a 
                    href={project.demoUrl} 
                    target="_blank" 
                    rel="noopener noreferrer"
                    className="block text-gray-300 hover:text-white transition-colors"
                  >
                    Live Demo →
                  </a>
                )}
              </div>
            </div>
          </div>
        </div>

        {/* Project Content */}
        <div className="prose prose-invert prose-lg max-w-none">
          <div className="text-gray-300 leading-relaxed space-y-6">
            {project.longDescription && (
              <div dangerouslySetInnerHTML={{ __html: project.longDescription }} />
            )}
          </div>
        </div>

        {/* Image Gallery for Supply-Demand Project */}
        {project.id === 'supply-demand' && (
          <div className="mt-16">
            <h2 className="text-3xl font-bold text-white mb-8">Image Gallery</h2>
            <div className="grid md:grid-cols-2 gap-8">
              <div className="space-y-4">
                <div className="relative rounded-lg overflow-hidden border border-gray-700">
                  <Image
                    src="/assets/images/supply-demand-regional.png"
                    alt="Regional Supply and Demand Analysis"
                    width={600}
                    height={400}
                    className="w-full h-auto"
                  />
                </div>
                <p className="text-gray-400 text-center">Regional analysis showing supply and demand patterns across different geographic areas</p>
              </div>
              
              <div className="space-y-4">
                <div className="relative rounded-lg overflow-hidden border border-gray-700">
                  <Image
                    src="/assets/images/supply-demand-site.png"
                    alt="Site-Level Supply and Demand Analysis"
                    width={600}
                    height={400}
                    className="w-full h-auto"
                  />
                </div>
                <p className="text-gray-400 text-center">Site-level breakdown providing granular insights into individual location performance</p>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}