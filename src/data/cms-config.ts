// Simple CMS configuration for easy content management
// This file allows you to update projects, blog posts, and other content
// without touching the component code

export interface Project {
  id: string;
  title: string;
  description: string;
  longDescription: string;
  category: 'professional' | 'academic' | 'personal';
  technologies: string[];
  image: string;
  demoUrl?: string;
  githubUrl?: string;
  impact?: {
    metric: string;
    value: string;
  };
  tags: string[];
  featured: boolean;
  date: string;
}

export interface BlogPost {
  id: string;
  title: string;
  excerpt: string;
  content: string;
  author: string;
  date: string;
  tags: string[];
  featured: boolean;
  readTime: string;
  image?: string;
}

export interface SocialLink {
  name: string;
  url: string;
  platform: 'linkedin' | 'github' | 'twitter' | 'email' | 'instagram';
}

// PROJECTS DATA
// To add a new project, copy an existing project object and modify the values
export const projects: Project[] = [
  {
    id: 'mtg-ecorec',
    title: 'MTG EcoRec',
    description: 'Full-stack application integrating multiple APIs to analyze the Magic: The Gathering economy with comprehensive data insights and strategic recommendations.',
    longDescription: `<div class="space-y-6">
      <h2 class="text-2xl font-bold text-white mb-4">Navigate the Magic: The Gathering Economy</h2>
      
      <div class="bg-gradient-to-r from-emerald-500/20 to-blue-500/20 rounded-lg p-6 border border-emerald-500/30 mb-8 text-center">
        <p class="text-lg text-emerald-200 font-medium mb-4">🚀 Live Demo Available - Explore Now!</p>
        <a href="https://mtgecorec-b9fkfngtawggfpbw.westus3-01.azurewebsites.net/" target="_blank" class="inline-flex items-center gap-2 px-4 py-2 bg-emerald-600 hover:bg-emerald-700 rounded-lg font-semibold text-white transition-all duration-300 transform hover:scale-105 text-sm">
          🎯 Try MTG EcoRec
          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"></path>
          </svg>
        </a>
      </div>
      
      <p class="mb-6">Magic: The Gathering isn't just a game—it's a $2 billion global economy where cardboard rectangles can be worth more than gold. Since its release in 1993, MTG has evolved from a niche hobby into a sophisticated marketplace where strategy, scarcity, and speculation intersect.</p>
      
      <div class="grid md:grid-cols-3 gap-6 my-8">
        <div class="bg-gray-800/50 rounded-lg p-6 border border-gray-700">
          <div class="text-2xl mb-3">📊</div>
          <h3 class="text-lg font-semibold text-purple-400 mb-2">Market Analysis</h3>
          <p class="text-gray-300 text-sm">Deep dive into card prices, trends, and market dynamics across thousands of Magic cards.</p>
        </div>
        <div class="bg-gray-800/50 rounded-lg p-6 border border-gray-700">
          <div class="text-2xl mb-3">🎯</div>
          <h3 class="text-lg font-semibold text-blue-400 mb-2">Strategic Recommendations</h3>
          <p class="text-gray-300 text-sm">Get personalized card recommendations based on your budget, playstyle, and investment goals.</p>
        </div>
        <div class="bg-gray-800/50 rounded-lg p-6 border border-gray-700">
          <div class="text-2xl mb-3">📈</div>
          <h3 class="text-lg font-semibold text-emerald-400 mb-2">Data-Driven Insights</h3>
          <p class="text-gray-300 text-sm">Interactive visualizations reveal patterns in rarity, colors, sets, and price movements.</p>
        </div>
      </div>
      
      <h3 class="text-xl font-bold text-white mb-4">The Story of MTG's Economy</h3>
      
      <p class="mb-6">Built as a comprehensive full-stack application, MTG EcoRec integrates multiple APIs to continuously gather and analyze data from over 35,000 unique cards. Our real-time analysis reveals fascinating patterns: certain colors command premium prices, rare cards from legendary sets appreciate dramatically, and market dynamics shift with each new release. The backend infrastructure seamlessly processes API data while the frontend delivers interactive insights into this complex ecosystem where player preferences, tournament formats, and digital innovations constantly reshape value.</p>
      
      <p class="mb-6">Whether you're a competitive player seeking an edge, a collector building a legacy, or an investor exploring alternative assets, understanding MTG's economy is crucial. Our tools help you navigate this fascinating world with confidence and insight.</p>
      
      <div class="bg-gradient-to-r from-purple-600/20 to-blue-600/20 rounded-lg p-6 border border-purple-500/30 my-8">
        <h3 class="text-lg font-semibold text-purple-300 mb-4">Key Features (In Development)</h3>
        <ul class="space-y-2 text-gray-300">
          <li class="flex items-center gap-3">
            <span class="w-2 h-2 bg-purple-400 rounded-full"></span>
            Multi-API integration for real-time data collection
          </li>
          <li class="flex items-center gap-3">
            <span class="w-2 h-2 bg-blue-400 rounded-full"></span>
            Full-stack architecture with backend data processing
          </li>
          <li class="flex items-center gap-3">
            <span class="w-2 h-2 bg-emerald-400 rounded-full"></span>
            Market analysis across 35,000+ unique cards
          </li>
          <li class="flex items-center gap-3">
            <span class="w-2 h-2 bg-purple-400 rounded-full"></span>
            Interactive frontend with dynamic visualizations
          </li>
          <li class="flex items-center gap-3">
            <span class="w-2 h-2 bg-blue-400 rounded-full"></span>
            Personalized investment recommendations engine
          </li>
        </ul>
      </div>
      
      <div class="text-center">
        <a href="https://mtgecorec-b9fkfngtawggfpbw.westus3-01.azurewebsites.net/" target="_blank" class="inline-flex items-center gap-2 px-6 py-3 bg-gradient-to-r from-emerald-600 to-blue-600 hover:from-emerald-700 hover:to-blue-700 rounded-lg font-semibold text-white transition-all duration-300 transform hover:scale-105">
          🚀 Explore MTG EcoRec Live
          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"></path>
          </svg>
        </a>
      </div>
    </div>`,
    category: 'personal',
    technologies: ['Python', 'API Integration', 'Full-Stack Development', 'Data Analysis', 'Machine Learning', 'Interactive Visualizations', 'Backend Development'],
    image: '/assets/images/mtg-ecorec-visualizations.png',
    demoUrl: 'https://mtgecorec-b9fkfngtawggfpbw.westus3-01.azurewebsites.net/',
    githubUrl: 'https://github.com/mattgraham93/mtgecorec',
    impact: {
      metric: 'Cards Analyzed',
      value: '35,000+'
    },
    tags: ['Full-Stack Development', 'API Integration', 'Data Science', 'Market Analysis', 'Gaming Economy', 'Live Demo'],
    featured: true,
    date: '2025-10-15'
  },
  {
    id: 'gdp-analysis',
    title: 'GDP vs Congressional Representation',
    description: 'Does a state\'s contribution differ that much from their representative population?',
    longDescription: 'Statistical analysis examining the relationship between state GDP contributions and congressional representation. Used R for data analysis and visualization to explore whether economic contribution aligns with political representation in the US system.',
    category: 'academic',
    technologies: ['R', 'Statistical Analysis', 'Data Visualization', 'ggplot2'],
    image: '/assets/images/gdp_analysis_act_v_pred_r_v_d.png',
    githubUrl: 'https://github.com/mattgraham93/gdp-representation-analysis',
    demoUrl: 'https://grahammr93.medium.com/can-us-state-gdp-determine-congressional-representation-e3cda57285f3?sk=35e77d96c3a28c7f1a084875e48a2f19',
    impact: {
      metric: 'Medium Views',
      value: '1,200+'
    },
    tags: ['Statistical Analysis', 'Government Data', 'R', 'Political Science'],
    featured: false,
    date: '2023-09-15'
  },
  {
    id: 'rfm-analysis',
    title: 'RFM Customer Segmentation',
    description: 'Customer segmentation analysis using RFM methodology for targeted marketing',
    longDescription: 'Implemented RFM (Recency, Frequency, Monetary) analysis to segment customers and improve marketing strategies. The analysis identified high-value customer segments and provided actionable insights for personalized marketing campaigns.',
    category: 'professional',
    technologies: ['Python', 'Pandas', 'Matplotlib', 'Seaborn', 'Customer Analytics'],
    image: '/assets/images/rfm-graph.png',
    githubUrl: 'https://github.com/mattgraham93/rfm-analysis',
    impact: {
      metric: 'Marketing ROI',
      value: '+45%'
    },
    tags: ['Customer Analytics', 'Marketing', 'Segmentation', 'Business Intelligence'],
    featured: false,
    date: '2023-08-10'
  },
  {
    id: 'sentiment-analysis',
    title: 'Social Media Sentiment Analysis',
    description: 'Natural language processing for brand sentiment monitoring',
    longDescription: 'Built a sentiment analysis system to monitor brand mentions across social media platforms. Used natural language processing techniques to classify sentiment and provide real-time insights for brand management and customer service teams.',
    category: 'personal',
    technologies: ['Python', 'NLTK', 'TextBlob', 'Twitter API', 'Flask'],
    image: '/assets/images/sentiment.png',
    githubUrl: 'https://github.com/mattgraham93/sentiment-analysis',
    impact: {
      metric: 'Accuracy',
      value: '87%'
    },
    tags: ['NLP', 'Sentiment Analysis', 'Social Media', 'Machine Learning'],
    featured: false,
    date: '2023-06-20'
  },
  {
    id: 'apache-spark-setup',
    title: 'Apache Spark on Ubuntu VM Setup',
    description: 'Comprehensive guide for setting up Apache Spark development environment',
    longDescription: 'Created a detailed tutorial and implementation guide for setting up Apache Spark on Ubuntu virtual machines. Covers installation, configuration, performance optimization, and troubleshooting for big data processing workflows.',
    category: 'personal',
    technologies: ['Apache Spark', 'Ubuntu', 'Big Data', 'DevOps', 'Scala'],
    image: '/assets/images/spark_vm.png',
    demoUrl: 'https://grahammr93.medium.com/closing-the-gap-setting-up-an-ubuntu-vm-for-apache-spark-5b64dcfd6923?sk=af5a47561a4847e9cf12664ca556d3ab',
    impact: {
      metric: 'Tutorial Views',
      value: '2,500+'
    },
    tags: ['Big Data', 'Apache Spark', 'Ubuntu', 'DevOps', 'Tutorial'],
    featured: false,
    date: '2024-02-10'
  },
  {
    id: 'ott-statistics-api',
    title: 'OTT: Statistics Made Accessible',
    description: 'Python API making traditional statistical concepts more accessible for practitioners',
    longDescription: 'Developed an innovative API that bridges the gap between traditional statistical textbooks and modern Python implementation. Makes complex statistical proofs and concepts more approachable for data science practitioners.',
    category: 'personal',
    technologies: ['Python', 'API Development', 'Statistics', 'Documentation'],
    image: '/assets/images/api_start.png',
    demoUrl: 'https://grahammr93.medium.com/making-traditional-data-analytics-more-accessible-in-python-aa765ec85eb?sk=517e9c61e57729516d4a3a939d4cc8e8',
    githubUrl: 'https://github.com/mattgraham93/ott-statistics',
    impact: {
      metric: 'GitHub Stars',
      value: '45+'
    },
    tags: ['API Development', 'Statistics', 'Python', 'Education', 'Open Source'],
    featured: false,
    date: '2024-01-25'
  }
];

// BLOG POSTS DATA
// To add a new blog post, copy an existing post object and modify the values
export const blogPosts: BlogPost[] = [
  {
    id: 'intro-to-data-science',
    title: 'Getting Started with Data Science: A Beginner\'s Guide',
    excerpt: 'Essential steps and resources for aspiring data scientists looking to break into the field.',
    content: `# Getting Started with Data Science

Data science is one of the most exciting and rapidly growing fields in technology today. Whether you're a complete beginner or looking to transition from another field, this guide will help you understand what it takes to become a data scientist.

## What is Data Science?

Data science is an interdisciplinary field that combines statistics, programming, and domain expertise to extract insights from data. It involves collecting, cleaning, analyzing, and interpreting large amounts of data to help organizations make informed decisions.

## Essential Skills for Data Scientists

### 1. Programming Languages
- **Python**: The most popular language for data science
- **R**: Great for statistical analysis and visualization
- **SQL**: Essential for database management and queries

### 2. Statistical Knowledge
- Descriptive and inferential statistics
- Probability theory
- Hypothesis testing
- Regression analysis

### 3. Data Visualization
- Creating meaningful charts and graphs
- Tools like Matplotlib, Seaborn, Tableau
- Storytelling with data

## Getting Started Steps

1. **Learn the Fundamentals**: Start with statistics and programming basics
2. **Practice with Real Data**: Work on projects using public datasets
3. **Build a Portfolio**: Showcase your work on GitHub and personal websites
4. **Network**: Connect with other data professionals
5. **Keep Learning**: The field evolves rapidly, so continuous learning is key

Data science is a rewarding field that offers the opportunity to solve real-world problems with data. Start with the basics, practice regularly, and don't be afraid to tackle challenging projects!`,
    author: 'Mattie Graham',
    date: '2024-01-15',
    tags: ['Data Science', 'Career', 'Beginner Guide'],
    featured: true,
    readTime: '8 min'
  },
  {
    id: 'python-data-analysis',
    title: 'Python Libraries Every Data Analyst Should Know',
    excerpt: 'A comprehensive overview of essential Python libraries for data analysis and visualization.',
    content: `# Python Libraries Every Data Analyst Should Know

Python has become the go-to language for data analysis, and for good reason. Its rich ecosystem of libraries makes it incredibly powerful for working with data. Here's a guide to the most essential libraries every data analyst should master.

## Data Manipulation Libraries

### Pandas
The backbone of data analysis in Python. Pandas provides data structures and functions needed to work with structured data.

\`\`\`python
import pandas as pd
df = pd.read_csv('data.csv')
df.head()
\`\`\`

### NumPy
Fundamental package for scientific computing with Python. It provides support for arrays, mathematical functions, and linear algebra operations.

## Visualization Libraries

### Matplotlib
The foundational plotting library in Python. While it requires more code for basic plots, it offers complete control over every aspect of your visualizations.

### Seaborn
Built on top of Matplotlib, Seaborn provides a high-level interface for creating attractive statistical visualizations.

### Plotly
Great for creating interactive visualizations that can be embedded in web applications.

## Machine Learning Libraries

### Scikit-learn
The most popular machine learning library in Python, offering simple and efficient tools for data mining and analysis.

### TensorFlow/PyTorch
For deep learning applications, these libraries provide the tools needed to build and train neural networks.

## Getting Started

1. Start with Pandas and NumPy for data manipulation
2. Learn Matplotlib for basic plotting
3. Move to Seaborn for statistical visualizations
4. Explore Scikit-learn for machine learning

Each of these libraries has excellent documentation and a large community, making them great choices for data analysis projects.`,
    author: 'Mattie Graham',
    date: '2024-02-20',
    tags: ['Python', 'Data Analysis', 'Libraries', 'Tutorial'],
    featured: false,
    readTime: '12 min'
  },
  {
    id: 'real-estate-analytics',
    title: 'Analytics in Commercial Real Estate: A Data-Driven Approach',
    excerpt: 'How data analytics is transforming commercial real estate decision-making and investment strategies.',
    content: `# Analytics in Commercial Real Estate: A Data-Driven Approach

The commercial real estate industry has traditionally relied on intuition and experience for decision-making. However, the integration of data analytics is revolutionizing how we approach investment, management, and strategic planning in CRE.

## The Power of Data in CRE

### Market Analysis
- Demographic trends and population growth
- Economic indicators and employment data
- Supply and demand dynamics
- Comparable property analysis

### Portfolio Optimization
- Risk assessment across different markets
- Performance benchmarking
- Space utilization analytics
- Cost optimization opportunities

## Key Analytics Applications

### 1. Predictive Modeling
Using historical data to forecast future market conditions, rental rates, and property values.

### 2. Location Scoring
Developing standardized metrics to evaluate and compare different locations based on multiple factors.

### 3. Portfolio Dashboard
Creating real-time visibility into portfolio performance with key metrics and alerts.

## Tools and Technologies

- **Python/R**: For statistical analysis and modeling
- **SQL**: For data extraction and manipulation  
- **Tableau/Power BI**: For visualization and reporting
- **GIS Software**: For spatial analysis and mapping

## The Future of CRE Analytics

As more data becomes available and tools become more sophisticated, we can expect to see:
- More accurate predictive models
- Real-time market intelligence
- Automated decision-making systems
- Enhanced risk management

The integration of analytics in commercial real estate is not just a trend—it's becoming essential for competitive advantage in today's market.`,
    author: 'Mattie Graham',
    date: '2024-03-05',
    tags: ['Real Estate', 'Analytics', 'Commercial', 'Data Science'],
    featured: true,
    readTime: '10 min'
  }
];

// SOCIAL LINKS DATA
// To update your social media links, modify the URLs below
export const socialLinks: SocialLink[] = [
  {
    name: 'LinkedIn',
    url: 'https://linkedin.com/in/mattgraham93',
    platform: 'linkedin'
  },
  {
    name: 'GitHub',
    url: 'https://github.com/mattgraham93',
    platform: 'github'
  },
  {
    name: 'Email',
    url: 'mailto:eight-amens76@icloud.com',
    platform: 'email'
  },
  // Add more social links by copying the structure above
  // Available platforms: 'linkedin', 'github', 'twitter', 'email', 'instagram'
];

// PERSONAL INFO DATA
// Update your personal information here
export const personalInfo = {
  name: 'Mattie Graham',
  title: 'Data Analyst & Business Intelligence Specialist',
  email: 'eight-amens76@icloud.com',
  location: 'United States',
  bio: `I'm a passionate data analyst with expertise in transforming complex datasets into actionable insights. 
        I specialize in statistical analysis, machine learning, and data visualization to help organizations 
        make data-driven decisions.`,
  skills: [
    'Python', 'R', 'SQL', 'Tableau', 'Power BI', 'Machine Learning', 
    'Statistical Analysis', 'Data Visualization', 'Business Intelligence'
  ],
  availability: 'Available for freelance projects and full-time opportunities'
};

// FEATURED CONTENT CONFIGURATION
// Control what content appears in featured sections
export const featuredConfig = {
  maxFeaturedProjects: 3,
  maxFeaturedBlogPosts: 2,
  showProjectImpactMetrics: true,
  showBlogReadTime: true
};