'use client';

import { useState } from 'react';
import Image from 'next/image';

interface ProjectImageProps {
  src: string;
  alt: string;
  width: number;
  height: number;
  className?: string;
  priority?: boolean;
}

export default function ProjectImage({ src, alt, width, height, className, priority }: ProjectImageProps) {
  const [imageError, setImageError] = useState(false);
  const [isLoading, setIsLoading] = useState(true);

  if (imageError) {
    // Fallback gradient background with project title initial
    const initial = alt.charAt(0).toUpperCase();
    return (
      <div 
        className={`${className} bg-gradient-to-br from-purple-600 via-blue-600 to-emerald-600 flex items-center justify-center`}
        style={{ width, height }}
      >
        <div className="text-center">
          <div className="text-6xl font-bold text-white/90 mb-2">
            {initial}
          </div>
          <div className="text-white/70 text-sm font-medium px-4 text-center">
            {alt}
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="relative">
      {isLoading && (
        <div 
          className={`${className} bg-gradient-to-br from-gray-700 to-gray-800 flex items-center justify-center animate-pulse`}
          style={{ width, height }}
        >
          <div className="text-gray-400">Loading...</div>
        </div>
      )}
      <Image
        src={src}
        alt={alt}
        width={width}
        height={height}
        className={`${className} ${isLoading ? 'opacity-0' : 'opacity-100'} transition-opacity duration-300`}
        priority={priority}
        onError={() => setImageError(true)}
        onLoad={() => setIsLoading(false)}
      />
    </div>
  );
}