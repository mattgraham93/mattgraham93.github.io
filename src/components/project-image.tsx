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
  return (
    <div className="relative overflow-hidden">
      <Image
        src={src}
        alt={alt}
        width={width}
        height={height}
        className={className}
        priority={priority}
        unoptimized={true}
        placeholder="blur"
        blurDataURL="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj/2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj/wAARCAABAAEDASIAAhEBAxEB/8QAFQABAQAAAAAAAAAAAAAAAAAAAAv/xAAUEAEAAAAAAAAAAAAAAAAAAAAA/8QAFQEBAQAAAAAAAAAAAAAAAAAAAAX/xAAUEQEAAAAAAAAAAAAAAAAAAAAA/9oADAMBAAIRAxEAPwCdABmX/9k="
        onError={(e) => {
          // Fallback to gradient if image fails
          const target = e.target as HTMLImageElement;
          const parent = target.parentElement;
          if (parent) {
            const initial = alt.charAt(0).toUpperCase();
            parent.innerHTML = `
              <div class="${className} bg-gradient-to-br from-purple-600 via-blue-600 to-emerald-600 flex items-center justify-center" style="width: ${width}px; height: ${height}px;">
                <div class="text-center">
                  <div class="text-6xl font-bold text-white/90 mb-2">${initial}</div>
                  <div class="text-white/70 text-sm font-medium px-4 text-center">${alt}</div>
                </div>
              </div>
            `;
          }
        }}
      />
    </div>
  );
}