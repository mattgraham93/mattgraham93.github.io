import Link from "next/link";
import { Project } from '@/data/cms-config';
import ProjectImage from './project-image';

interface ProjectCardProps {
  project: Project;
}

export function ProjectCard({ project }: ProjectCardProps) {
  const link = project.demoUrl || project.githubUrl || `/projects/${project.id}`;
  const isExternal = link.startsWith('http');
  const year = new Date(project.date).getFullYear().toString();
  
  const getCategoryColor = (category: string) => {
    switch (category) {
      case 'professional':
        return 'bg-purple-500/20 text-purple-300 border-purple-500/50';
      case 'academic':
        return 'bg-blue-500/20 text-blue-300 border-blue-500/50';
      case 'personal':
        return 'bg-emerald-500/20 text-emerald-300 border-emerald-500/50';
      default:
        return 'bg-gray-500/20 text-gray-300 border-gray-500/50';
    }
  };

  const getCategoryLabel = (category: string) => {
    switch (category) {
      case 'professional':
        return 'Professional';
      case 'academic':
        return 'Academic';
      case 'personal':
        return 'Personal';
      default:
        return category;
    }
  };

  return (
    <div className="group bg-gray-800/50 rounded-xl overflow-hidden border border-gray-700 hover:border-purple-500/50 transition-all duration-500 ease-out hover:shadow-xl hover:shadow-purple-500/10 hover:transform hover:scale-[1.02] flex flex-col h-full">
      {/* Image */}
      <div className="relative overflow-hidden h-48">
        <ProjectImage
          src={project.image}
          alt={project.title}
          width={400}
          height={300}
          className="w-full h-full object-cover transition-transform duration-500 ease-out group-hover:scale-105"
        />
        <div className="absolute inset-0 bg-gradient-to-t from-gray-900/60 to-transparent opacity-0 group-hover:opacity-100 transition-all duration-500 ease-in-out"></div>
        
        {/* Category Badge */}
        <div className={`absolute top-4 left-4 px-3 py-1 text-xs font-medium rounded-full border ${getCategoryColor(project.category)}`}>
          {getCategoryLabel(project.category)}
        </div>
        
        {/* Year Badge */}
        <div className="absolute top-4 right-4 px-3 py-1 text-xs font-medium bg-gray-900/80 text-gray-300 rounded-full border border-gray-600">
          {year}
        </div>
      </div>
      
      {/* Content */}
      <div className="p-6 flex flex-col flex-grow">
        {/* Tags */}
        <div className="flex flex-wrap gap-2 mb-3">
          {project.tags.slice(0, 3).map((tag, index) => (
            <span 
              key={index}
              className="px-2 py-1 text-xs font-medium bg-gray-700/50 text-gray-300 rounded border border-gray-600"
            >
              {tag}
            </span>
          ))}
          {project.tags.length > 3 && (
            <span className="px-2 py-1 text-xs font-medium bg-gray-700/50 text-gray-400 rounded border border-gray-600">
              +{project.tags.length - 3} more
            </span>
          )}
        </div>
        
        {/* Title */}
        <h3 className="text-xl font-bold text-white mb-3 group-hover:text-purple-400 transition-colors duration-300 ease-out line-clamp-2">
          {project.title}
        </h3>
        
        {/* Description */}
        <p className="text-gray-400 mb-4 leading-relaxed flex-grow line-clamp-3">
          {project.description}
        </p>
        
        {/* Impact */}
        {project.impact && (
          <div className="mb-4 px-3 py-2 bg-gray-700/30 rounded-lg border-l-2 border-emerald-500">
            <p className="text-emerald-400 text-sm font-medium">
              {project.impact.metric}: {project.impact.value}
            </p>
          </div>
        )}
        
        {/* Link */}
        <Link 
          href={link}
          className="inline-flex items-center gap-2 text-emerald-400 hover:text-emerald-300 font-semibold transition-colors group/link mt-auto"
          target={isExternal ? '_blank' : '_self'}
          rel={isExternal ? 'noopener noreferrer' : undefined}
        >
          {isExternal ? 'View Project' : 'Read More'}
          {isExternal ? (
            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
            </svg>
          ) : (
            <svg className="w-4 h-4 transition-transform group-hover/link:translate-x-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
            </svg>
          )}
        </Link>
      </div>
    </div>
  );
}