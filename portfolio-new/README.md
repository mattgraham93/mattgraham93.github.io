# Modern Portfolio Website

A sleek, modern portfolio website built with Next.js 15, TypeScript, and Tailwind CSS. Features a dark theme with purple/blue/emerald color scheme, smooth animations, and an easy-to-use content management system.

## ✨ Features

- **Modern Design**: Dark theme with smooth animations and professional layout
- **Responsive**: Fully responsive design that works on all devices
- **Interactive Components**: 
  - Hero section with profile image
  - Featured projects showcase
  - Advanced project filtering system
  - Interactive resume with detailed sections
  - Professional contact form
  - Blog system (expandable)
- **Easy Content Management**: Update projects, blog posts, and personal info without touching code
- **Performance Optimized**: Built with Next.js 15 and Turbopack for fast development and production builds
- **SEO Ready**: Proper meta tags, semantic HTML, and optimized for search engines

## 🚀 Quick Start

### Prerequisites
- Node.js 18+ installed
- Git installed

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/mattgraham93/mattgraham93.github.io.git
   cd mattgraham93.github.io/portfolio-new
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Start development server**
   ```bash
   npm run dev
   ```

4. **Open in browser**
   Navigate to [http://localhost:3000](http://localhost:3000)

## 📁 Project Structure

```
portfolio-new/
├── src/
│   ├── app/                 # Next.js app router pages
│   │   ├── about/          # About page
│   │   ├── admin/          # CMS admin interface
│   │   ├── blog/           # Blog pages
│   │   ├── contact/        # Contact page with form
│   │   ├── projects/       # Projects showcase
│   │   ├── resume/         # Interactive resume
│   │   └── layout.tsx      # Root layout
│   ├── components/         # Reusable React components
│   │   ├── navigation.tsx  # Main navigation
│   │   ├── hero.tsx        # Hero section
│   │   ├── contact-form.tsx # Contact form
│   │   └── ...            # Other components
│   └── data/
│       └── cms-config.ts   # 📝 EDIT THIS FILE FOR CONTENT
├── public/                 # Static assets
│   ├── images/            # Project and blog images
│   └── assets/            # Other static files
└── DEPLOYMENT.md          # Detailed deployment guide
```

## 🎨 Customization

### 🔧 Update Your Content

The easiest way to customize your portfolio is by editing the `src/data/cms-config.ts` file:

**Add a new project:**
```typescript
{
  id: 'my-project',
  title: 'My Awesome Project',
  description: 'Brief description...',
  category: 'professional',
  technologies: ['React', 'Node.js', 'PostgreSQL'],
  image: '/images/my-project.jpg',
  githubUrl: 'https://github.com/username/repo',
  featured: true,
  date: '2024-01-15'
}
```

**Update personal information:**
```typescript
export const personalInfo = {
  name: 'Your Name',
  title: 'Your Professional Title',
  email: 'your@email.com',
  // ... more settings
};
```

**Add social links:**
```typescript
export const socialLinks = [
  {
    name: 'LinkedIn',
    url: 'https://linkedin.com/in/yourprofile',
    platform: 'linkedin'
  }
  // ... more links
];
```

### 🎨 Design Customization

The website uses CSS custom properties for easy theme customization. Edit `src/app/globals.css` to change colors:

```css
:root {
  --color-purple: #8b5cf6;
  --color-blue: #3b82f6;
  --color-emerald: #10b981;
  /* ... more variables */
}
```

## 📦 Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run start` - Start production server
- `npm run lint` - Run ESLint

## 🌐 Deployment

See [DEPLOYMENT.md](./DEPLOYMENT.md) for detailed deployment instructions for:
- GitHub Pages
- Vercel
- Netlify
- Other platforms

## 🛠️ Built With

- **Framework**: [Next.js 15](https://nextjs.org/) with App Router
- **Language**: [TypeScript](https://www.typescriptlang.org/)
- **Styling**: [Tailwind CSS](https://tailwindcss.com/)
- **Icons**: [React Icons](https://react-icons.github.io/react-icons/)
- **Build Tool**: [Turbopack](https://turbo.build/pack)

## 📖 Content Management

### Admin Interface
Visit `/admin` in your browser for a visual overview of your content management options.

### Easy Updates
1. **Projects**: Add to `projects` array in `cms-config.ts`
2. **Blog Posts**: Add to `blogPosts` array in `cms-config.ts`
3. **Personal Info**: Update `personalInfo` object
4. **Social Links**: Update `socialLinks` array
5. **Images**: Add to `public/images/` directory

### Content Types
- **Projects**: Showcase your work with descriptions, technologies, and links
- **Blog Posts**: Share insights and tutorials (supports Markdown)
- **Personal Info**: Bio, skills, contact information
- **Social Links**: Professional and social media profiles

## 🤝 Contributing

This is a personal portfolio template, but suggestions and improvements are welcome!

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🆘 Support

Having issues? Check out:
- [DEPLOYMENT.md](./DEPLOYMENT.md) for deployment help
- [Next.js Documentation](https://nextjs.org/docs)
- [GitHub Issues](https://github.com/mattgraham93/mattgraham93.github.io/issues) for bug reports

---

**Built with ❤️ by Matt Graham**

*A modern, professional portfolio solution for data professionals and developers.*
