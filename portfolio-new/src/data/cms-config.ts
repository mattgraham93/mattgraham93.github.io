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
    id: 'portfolio-optimization',
    title: 'Global CRE Data Program',
    description: 'Predictive data program to suggest areas to improve investment and run scenarios to identify opportunities for space reduction',
    longDescription: 'Developed a comprehensive real estate portfolio optimization system that aggregates data from multiple sources to provide predictive insights. The system helps identify investment opportunities and potential areas for space reduction through advanced analytics and scenario modeling.',
    category: 'professional',
    technologies: ['Python', 'Pandas', 'Scikit-learn', 'Tableau', 'SQL'],
    image: '/assets/images/real-estate-model.png',
    githubUrl: 'https://github.com/mattgraham93/portfolio-optimization',
    impact: {
      metric: 'Cost Savings',
      value: '$2.3M'
    },
    tags: ['Data Science', 'Predictive Analytics', 'Real Estate', 'Portfolio Optimization'],
    featured: true,
    date: '2024-01-15'
  },
  {
    id: 'supply-demand',
    title: 'CRE Supply and Demand Analysis',
    description: 'Aggregation of 6 disparate systems to track and model future real estate decisions',
    longDescription: 'Built an integrated data pipeline that combines information from six different systems to create a unified view of commercial real estate supply and demand. The system provides forecasting capabilities and supports strategic decision-making for real estate investments.',
    category: 'professional',
    technologies: ['Python', 'ETL', 'PostgreSQL', 'Power BI', 'Apache Airflow'],
    image: '/assets/images/supply-demand-regional.png',
    githubUrl: 'https://github.com/mattgraham93/supply-demand-analysis',
    impact: {
      metric: 'Data Integration',
      value: '6 Systems'
    },
    tags: ['Data Integration', 'ETL', 'Business Intelligence', 'Forecasting'],
    featured: true,
    date: '2023-11-20'
  },
  {
    id: 'location-scoring',
    title: 'Feasibility: Location Scoring Model',
    description: 'Before making real estate decisions, we must normalize our portfolio first',
    longDescription: 'Created a sophisticated location scoring model that normalizes portfolio data across different markets and property types. The model evaluates multiple factors including demographics, market conditions, and accessibility to provide standardized location scores for decision-making.',
    category: 'professional',
    technologies: ['Python', 'Machine Learning', 'Geospatial Analysis', 'R', 'GIS'],
    image: '/assets/images/location-scoring-intro2.png',
    githubUrl: 'https://github.com/mattgraham93/location-scoring',
    impact: {
      metric: 'Locations Scored',
      value: '500+'
    },
    tags: ['Machine Learning', 'Location Analytics', 'Scoring Models', 'GIS'],
    featured: true,
    date: '2024-03-10'
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
    author: 'Matt Graham',
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
    author: 'Matt Graham',
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
    author: 'Matt Graham',
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
    url: 'mailto:grahammr93@gmail.com',
    platform: 'email'
  },
  // Add more social links by copying the structure above
  // Available platforms: 'linkedin', 'github', 'twitter', 'email', 'instagram'
];

// PERSONAL INFO DATA
// Update your personal information here
export const personalInfo = {
  name: 'Matt Graham',
  title: 'Data Analyst & Business Intelligence Specialist',
  email: 'grahammr93@gmail.com',
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