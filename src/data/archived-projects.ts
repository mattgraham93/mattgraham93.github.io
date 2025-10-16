// ARCHIVED PROJECTS - Temporarily removed from public view
// These projects can be restored to cms-config.ts when ready to make public again

export const archivedProjects = [
  {
    id: 'portfolio-optimization',
    title: 'Global CRE Data Program',
    description: 'Bridging enterprise data silos across real estate teams at Meta.',
    longDescription: `<div class="space-y-6">
      <h2 class="text-2xl font-bold text-white mb-4">A Deeper Dive</h2>
      
      <p class="mb-6">In the intricate ecosystem of global corporate real estate management, where six different systems are managed by six distinct teams, data silos and inconsistencies become inevitable challenges. The Global CRE Data Program emerged as a transformative initiative to bridge these gaps, serving as an interim solution for Meta's Global Real Estate Management Program while addressing the complexities of cross-team collaboration.</p>
      
      <p class="mb-6">This ambitious project tackled the fundamental challenge of integrating disparate data sources across real estate planning, management, finance, and people teams. By establishing a unified data architecture, the program aimed to eliminate the confusion and inefficiencies that arise when multiple teams operate with different metrics, definitions, and data representations.</p>
      
      <p class="mb-6">The initiative focused on creating standardized approaches to data collection, processing, and analysis across all real estate operations. This involved careful mapping of existing data flows, identification of critical integration points, and development of robust validation mechanisms to ensure data quality and consistency across the entire portfolio.</p>
      
      <p class="mb-6">Key stakeholders including lease administrators, portfolio managers, workplace planners, and space planners collaborated intensively to align on definitions, metrics, and representation standards. This cross-functional approach ensured that the solution would serve the diverse needs of all teams while maintaining the integrity and reliability of the data ecosystem.</p>
      
      <p class="mb-6">The program's success lay in its ability to transform fragmented data landscapes into a cohesive, actionable intelligence platform that empowered decision-makers across Meta's global real estate operations. By establishing this foundation, the initiative paved the way for more advanced analytics and optimization projects while ensuring that all teams could work from a single source of truth.</p>
      
      <p class="mb-6">Throughout the project lifecycle, extensive stakeholder alignment sessions were conducted to ensure that the solution addressed the unique requirements of each team while maintaining consistency across the organization. The team navigated complex technical challenges including data quality issues, system integration limitations, and the need for real-time synchronization across multiple platforms.</p>
      
      <p class="mb-6">The implementation involved careful consideration of data governance principles, establishing clear protocols for data access, modification, and validation. This ensured that while teams could access the information they needed, the integrity of the shared data ecosystem remained intact.</p>
      
      <p class="mb-6">As the program evolved, it became clear that this initiative was not just about technical integration, but about fundamentally changing how teams collaborated and made decisions. The unified data platform fostered better communication, reduced redundant efforts, and enabled more strategic, data-driven decision making across Meta's global real estate portfolio.</p>
    </div>`,
    category: 'professional',
    technologies: ['Data Integration', 'Enterprise Architecture', 'Cross-functional Collaboration', 'Real Estate Analytics', 'SQL', 'ETL'],
    image: '/assets/images/supply-demand-model.png',
    githubUrl: 'https://github.com/mattgraham93/portfolio-optimization',
    impact: {
      metric: 'Systems Unified',
      value: '6 Teams'
    },
    tags: ['Data Integration', 'Enterprise Architecture', 'Real Estate', 'Cross-functional Teams', 'Meta'],
    featured: true,
    date: '2023-12-15'
  },
  {
    id: 'supply-demand',
    title: 'Global Real Estate Supply and Demand Modeling',
    description: 'Integrated 6 disparate systems to create unified real estate capacity tracking and forecasting model. Enhanced Meta\'s portfolio optimization with predictive analytics and dynamic scenario planning.',
    longDescription: `<h2 class="text-2xl font-bold text-white mb-4">A Deeper Dive</h2>
    
    <p class="mb-6">Once upon a time, in a bustling city, Meta, a global corporation, embarked on an ambitious project named "Supply and Demand" as part of their Portfolio Optimization program. The goal of the program was to optimize Meta's global corporate real estate portfolio, improve data accuracy, and align with their evolving business needs.</p>
    
    <p class="mb-6">The project faced a significant challenge due to inconsistencies in tying active building capacity and attendance across six systems managed by six different teams within Meta. These inconsistencies were bound to happen given the decentralized nature of the systems. Recognizing the need to bridge these gaps and ensure a unified view, the Supply and Demand project was launched.</p>
    
    <p class="mb-6">The Supply and Demand project took a holistic approach to address these challenges. It integrated two new data sources and introduced new methods to model historical and future supply and demand. By incorporating additional data, the project aimed to enhance the accuracy and reliability of forecasting and planning within Meta's global real estate portfolio.</p>
    
    <p class="mb-6">One of the key features of the Supply and Demand solution was its ability to highlight trends in active attendance. By analyzing historical attendance data, the project team could identify patterns and fluctuations in utilization across various locations and offices. This information allowed Meta to plan for more dynamic scenarios, enabling them to optimize space allocation and make informed decisions about future real estate needs.</p>
    
    <p class="mb-6">The project team collaborated closely with the teams responsible for managing the six different systems within Meta. By fostering effective communication and coordination, they ensured that the integration of data sources and the implementation of new methods were aligned with the unique requirements and capabilities of each system.</p>
    
    <p class="mb-6">Throughout the project, extensive testing and validation processes were conducted to ensure the accuracy and reliability of the Supply and Demand solution. The project team rigorously tested the integration of data sources, the modeling algorithms, and the overall functionality of the solution. This approach allowed Meta to have confidence in the insights and recommendations generated by the system.</p>
    
    <p class="mb-6">As the Supply and Demand project progressed, Meta witnessed the transformation of their real estate management practices. The unified view provided by the solution empowered decision-makers to make informed choices based on accurate data. With a clearer understanding of supply and demand dynamics and attendance trends, Meta could optimize their portfolio, streamline operations, and strategically plan for the future.</p>
    
    <p class="mb-6">The success of the Supply and Demand project not only strengthened Meta's global corporate real estate portfolio but also positioned them as industry leaders in leveraging data-driven insights for optimal real estate management. This project served as a foundation for continuous improvement, as Meta embraced innovation and actively sought opportunities to further enhance their portfolio optimization practices.</p>
    
    <div class="bg-gray-800/50 rounded-lg p-6 border border-gray-700 my-8">
      <h3 class="text-lg font-semibold text-purple-400 mb-4">Technical Implementation</h3>
      <p class="text-gray-300 mb-4">Below is what the full aggregate model looked like. The SQL implementation demonstrates the complexity of integrating multiple data sources:</p>
      <a href="https://github.com/mattgraham93/mattgraham93.github.io/blob/main/archive/examples/hive/supply_forecast_data_model.sql" target="_blank" class="inline-flex items-center gap-2 text-emerald-400 hover:text-emerald-300 transition-colors">
        View SQL Model on GitHub
        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"></path>
        </svg>
      </a>
    </div>
    
    <p>And so, Meta's journey towards a unified and data-driven approach to global corporate real estate management continued, marking a new chapter in their success story.</p>`,
    category: 'professional',
    technologies: ['SQL', 'Hive', 'Python', 'ETL', 'Data Modeling', 'Apache Airflow', 'Power BI'],
    image: '/assets/images/supply-demand-regional.png',
    githubUrl: 'https://github.com/mattgraham93/mattgraham93.github.io/blob/main/archive/examples/hive/supply_forecast_data_model.sql',
    demoUrl: '/assets/supply_demand/FCS supply and demand.drawio.html',
    impact: {
      metric: 'Systems Integrated',
      value: '6 Systems'
    },
    tags: ['Real Estate', 'Data Integration', 'ETL', 'Meta', 'Portfolio Optimization', 'Forecasting', 'Business Intelligence'],
    featured: true,
    date: '2023-11-20'
  },
  {
    id: 'location-scoring',
    title: 'Global Real Estate Location Scoring Model',
    description: 'Machine learning model to evaluate office spaces and guide strategic real estate decisions.',
    longDescription: `<div class="space-y-6">
      <h2 class="text-2xl font-bold text-white mb-4">A Deeper Dive</h2>
      
      <p class="mb-6">Once upon a time, in the vast landscape of corporate operations, where optimizing portfolios and meeting supply and demand were paramount, a project called Location Scoring emerged. This project, an offspring of the esteemed Portfolio Optimization initiative and a sister to the renowned Supply and Demand endeavor, held the promise of revolutionizing the way businesses assessed their physical locations. Its purpose was to provide invaluable insights and scoring based on a range of factors, shaping the destiny of workplaces within the realm of Meta, a prominent client in the industry.</p>
      
      <p class="mb-6">With a clear vision in mind, Location Scoring set out to uncover the hidden truths about office spaces, unraveling the secrets of their performance and untapped potential. It aimed to strike the delicate balance between investment, experience, and utilization, utilizing machine learning techniques to analyze a comprehensive set of features associated with leased and owned spaces. By harnessing the power of data, Location Scoring aspired to guide decision-makers in identifying the buildings or floors that could be repurposed or vacated, ultimately paving the way for strategic transformations.</p>
      
      <p class="mb-6">As the project unfolded, a diverse set of stakeholders, including lease administrators, portfolio managers, workplace planners, and space planners, rallied around the cause. Their shared commitment and expertise fueled the project's growth and ensured that it aligned with the goals and objectives of Meta. Each stakeholder brought unique perspectives and requirements, contributing to the holistic nature of Location Scoring and its ability to address a wide range of business needs.</p>
      
      <p class="mb-6">To bring Location Scoring to life, a team of dedicated individuals embarked on a journey of research, alignment, and collaboration. They delved into industry best practices, examined performance metrics, and explored innovative approaches to scoring and evaluating office spaces. The team understood the significance of data quality and consistency, realizing that accurate and reliable information would form the foundation of Location Scoring's success.</p>
      
      <p class="mb-6">As the project gained momentum, key milestones were achieved. The team meticulously mapped out the features and metrics that would shape the scoring model, ensuring a comprehensive and insightful evaluation of each location. They carefully considered factors such as space utilization, cost performance, facility condition index, employee experience, and even the cultural dynamics of teams within the spaces. These multi-faceted aspects painted a vivid picture of each location's value, enabling decision-makers to make informed choices that aligned with Meta's strategic objectives.</p>
      
      <p class="mb-6">The journey of Location Scoring was not without its challenges. The team encountered limitations in data availability and had to overcome technical hurdles in consolidating information from various sources. They sought alignment on definitions, metrics, and representation, striving for a standardized approach that would enhance the accuracy and reliability of the scoring model. Collaborations with internal and external partners, including real estate experts and data providers, played a crucial role in shaping the project's direction and refining its methodologies.</p>
      
      <p class="mb-6">Despite the obstacles, the team's unwavering dedication propelled Location Scoring forward. The project began to take shape, with the development of a robust data model and the integration of cutting-edge technologies. The team harnessed the power of machine learning algorithms, leveraging vast amounts of data to generate meaningful insights and scores for each location within Meta's portfolio.</p>
      
      <p class="mb-6">As the project neared completion, the anticipation grew. The stakeholders eagerly awaited the unveiling of Location Scoring and the transformative impact it would have on Meta's operations. They envisioned a future where data-driven decisions and optimized office spaces would drive efficiency, cost-effectiveness, and employee satisfaction. The possibilities were endless, and the potential for Meta's success was boundless.</p>
      
      <p class="mb-6">And so, with every milestone achieved and every challenge overcome, Location Scoring emerged as a beacon of innovation within the corporate world. It stood as a testament to the power of data, collaboration, and a shared vision to revolutionize the way businesses assess and optimize their physical locations. With Location Scoring, Meta embarked on a new era of strategic decision-making, ushering in a brighter and more efficient future.</p>
    </div>`,
    category: 'professional',
    technologies: ['Machine Learning', 'Python', 'Data Analysis', 'Real Estate Analytics', 'Feature Engineering', 'Scoring Models'],
    image: '/assets/images/location-scoring-intro.png',
    githubUrl: 'https://github.com/mattgraham93/location-scoring',
    impact: {
      metric: 'Decision Accuracy',
      value: '+65%'
    },
    tags: ['Machine Learning', 'Location Analytics', 'Scoring Models', 'Real Estate', 'Meta', 'Portfolio Optimization'],
    featured: true,
    date: '2024-01-10'
  }
];