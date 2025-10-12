# Portfolio Website - Deployment Guide

## 🚀 Phase 3: Going Live!

This guide will help you deploy your new Next.js portfolio to GitHub Pages and other platforms.

## 📋 Pre-Deployment Checklist

- [x] ✅ Website structure complete
- [x] ✅ Contact form implemented  
- [x] ✅ Content management system set up
- [ ] 🔄 Images optimized and uploaded
- [ ] 🔄 Final content review
- [ ] 🔄 Choose deployment platform
- [ ] 🔄 Deploy to production

## 🌐 Deployment Options

### Option 1: GitHub Pages (Recommended)
**Pros:** Free, automatic deployments, custom domain support
**Cons:** Static sites only, requires GitHub Actions for Next.js

### Option 2: Vercel (Easiest)  
**Pros:** Built for Next.js, automatic deployments, excellent performance
**Cons:** Bandwidth limits on free plan

### Option 3: Netlify
**Pros:** Great for static sites, good free tier, form handling
**Cons:** May require configuration for Next.js features

## 🚀 Deploying to GitHub Pages

### Step 1: Prepare Your Repository
```bash
# Make sure you're in the portfolio-new directory
cd portfolio-new

# Install GitHub Pages deployment package
npm install --save-dev @next/bundle-analyzer
```

### Step 2: Update next.config.ts
```typescript
/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'export',
  trailingSlash: true,
  images: {
    unoptimized: true
  },
  basePath: process.env.NODE_ENV === 'production' ? '/mattgraham93.github.io' : '',
  assetPrefix: process.env.NODE_ENV === 'production' ? '/mattgraham93.github.io' : ''
}

module.exports = nextConfig
```

### Step 3: Create GitHub Actions Workflow
Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout
      uses: actions/checkout@v3
      
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        cache: 'npm'
        cache-dependency-path: portfolio-new/package-lock.json
        
    - name: Install dependencies
      run: |
        cd portfolio-new
        npm ci
        
    - name: Build
      run: |
        cd portfolio-new
        npm run build
        
    - name: Deploy to GitHub Pages
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./portfolio-new/out
        cname: mattgraham93.github.io
```

### Step 4: Enable GitHub Pages
1. Go to your repository settings
2. Scroll to "Pages" section
3. Set source to "Deploy from a branch"
4. Select "gh-pages" branch
5. Save settings

## 🚀 Deploying to Vercel (Alternative)

### Step 1: Connect Repository
1. Go to [vercel.com](https://vercel.com)
2. Sign up with GitHub
3. Import your repository
4. Set root directory to `portfolio-new`

### Step 2: Configure Build Settings
- Build Command: `npm run build`
- Output Directory: `.next`
- Install Command: `npm install`

### Step 3: Deploy
Click "Deploy" and Vercel will automatically build and deploy your site!

## 📝 Content Management Instructions

### Adding New Projects
1. Open `src/data/cms-config.ts`
2. Add a new project object to the `projects` array:
```typescript
{
  id: 'my-new-project',
  title: 'My Amazing Project',
  description: 'Short description for cards',
  longDescription: 'Detailed description with full context...',
  category: 'professional', // or 'academic' or 'personal'
  technologies: ['Python', 'React', 'PostgreSQL'],
  image: '/images/my-project.jpg',
  demoUrl: 'https://my-demo.com', // optional
  githubUrl: 'https://github.com/username/repo', // optional
  impact: { // optional
    metric: 'Users Served',
    value: '10,000+'
  },
  tags: ['Data Science', 'Web Development'],
  featured: true, // appears on homepage
  date: '2024-01-15'
}
```

### Adding Blog Posts
1. Add to the `blogPosts` array in `cms-config.ts`:
```typescript
{
  id: 'my-blog-post',
  title: 'My Awesome Blog Post',
  excerpt: 'Brief summary of the post...',
  content: `# Full Blog Post Content
  
Write your content here in Markdown format...
  
## Subheadings
- Bullet points
- More content`,
  author: 'Matt Graham',
  date: '2024-01-15',
  tags: ['Data Science', 'Tutorial'],
  featured: true,
  readTime: '5 min',
  image: '/images/blog/my-post.jpg' // optional
}
```

### Updating Personal Information
Edit the `personalInfo` object in `cms-config.ts`:
```typescript
export const personalInfo = {
  name: 'Your Name',
  title: 'Your Professional Title',
  email: 'your@email.com',
  location: 'Your Location',
  bio: 'Your bio...',
  skills: ['Skill 1', 'Skill 2', 'Skill 3'],
  availability: 'Your availability status'
};
```

### Adding Social Links
Update the `socialLinks` array:
```typescript
{
  name: 'Platform Name',
  url: 'https://platform.com/yourprofile',
  platform: 'linkedin' // or 'github', 'twitter', 'email', 'instagram'
}
```

## 🎨 Image Management

### Image Locations
- Project images: `public/images/`
- Blog images: `public/images/blog/`
- Profile/hero images: `public/assets/images/`

### Image Optimization Tips
1. Use `.jpg` for photos, `.png` for graphics with transparency
2. Optimize images before uploading (aim for <500KB)
3. Use consistent aspect ratios (16:9 for project cards works well)
4. Consider using tools like [TinyPNG](https://tinypng.com/) for compression

## 🔧 Local Development

```bash
# Navigate to project directory
cd portfolio-new

# Install dependencies
npm install

# Start development server
npm run dev

# Build for production
npm run build

# Preview production build
npm run start
```

## 🐛 Troubleshooting

### Common Issues

**Images not loading after deployment:**
- Make sure images are in `public/` directory
- Check image paths (use `/images/file.jpg` not `./images/file.jpg`)
- Verify image files are committed to Git

**Site not updating after changes:**
- Check GitHub Actions for build errors
- Clear browser cache
- Wait a few minutes for CDN propagation

**Build errors:**
- Check console for specific error messages
- Ensure all required packages are installed
- Verify TypeScript syntax is correct

### Getting Help
- Check the browser console for errors
- Review GitHub Actions logs for deployment issues
- Test locally first with `npm run dev`

## 🎉 Success!

Once deployed, your portfolio will be live and automatically update whenever you:
1. Push changes to the main branch
2. Update content in `cms-config.ts`
3. Add new images to the `public/` directory

Your professional portfolio is now ready to impress potential employers and clients! 🚀