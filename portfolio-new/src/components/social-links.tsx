import { 
  FaLinkedin, 
  FaGithub, 
  FaEnvelope, 
  FaTwitter,
  FaInstagram,
  FaExternalLinkAlt 
} from 'react-icons/fa';

interface SocialLink {
  name: string;
  url: string;
  icon: React.ReactNode;
  color: string;
  description: string;
}

const socialLinks: SocialLink[] = [
  {
    name: 'LinkedIn',
    url: 'https://linkedin.com/in/mattgraham93',
    icon: <FaLinkedin className="text-2xl" />,
    color: 'hover:text-blue-400',
    description: 'Professional network and career updates'
  },
  {
    name: 'GitHub',
    url: 'https://github.com/mattgraham93',
    icon: <FaGithub className="text-2xl" />,
    color: 'hover:text-gray-300',
    description: 'Code repositories and open source projects'
  },
  {
    name: 'Email',
    url: 'mailto:grahammr93@gmail.com',
    icon: <FaEnvelope className="text-2xl" />,
    color: 'hover:text-emerald-400',
    description: 'Direct email communication'
  },
  // Add more social links as needed
  // {
  //   name: 'Twitter',
  //   url: 'https://twitter.com/mattgraham93',
  //   icon: <FaTwitter className="text-2xl" />,
  //   color: 'hover:text-blue-400',
  //   description: 'Thoughts on data science and tech'
  // },
];

export default function SocialLinks() {
  return (
    <div className="bg-gray-800/50 backdrop-blur-sm rounded-xl p-8 border border-gray-700">
      <h3 className="text-2xl font-bold mb-6 text-white">Connect With Me</h3>
      
      <div className="space-y-4">
        {socialLinks.map((link) => (
          <a
            key={link.name}
            href={link.url}
            target={link.url.startsWith('mailto:') ? undefined : '_blank'}
            rel={link.url.startsWith('mailto:') ? undefined : 'noopener noreferrer'}
            className={`group flex items-center space-x-4 p-4 rounded-lg bg-gray-700/30 hover:bg-gray-700/50 transition-all duration-300 ${link.color}`}
          >
            <div className="flex-shrink-0">
              {link.icon}
            </div>
            <div className="flex-grow">
              <h4 className="font-semibold text-white group-hover:text-current transition-colors">
                {link.name}
              </h4>
              <p className="text-sm text-gray-400 group-hover:text-gray-300 transition-colors">
                {link.description}
              </p>
            </div>
            <div className="flex-shrink-0 opacity-0 group-hover:opacity-100 transition-opacity">
              <FaExternalLinkAlt className="text-sm" />
            </div>
          </a>
        ))}
      </div>

      <div className="mt-8 pt-6 border-t border-gray-700">
        <p className="text-gray-400 text-sm leading-relaxed">
          I'm always interested in new opportunities, collaborations, and interesting data projects. 
          Whether you're looking for a data analyst, have a consulting project, or just want to chat 
          about the latest in data science, feel free to reach out!
        </p>
      </div>
    </div>
  );
}