import Link from "next/link";

// Sample blog posts - in the future this could come from a CMS or markdown files
const blogPosts = [
  {
    id: 1,
    title: "Can US State GDP Determine Congressional Representation?",
    excerpt: "Does a state's contribution differ that much from their representative population? An analysis using Python and statistical modeling.",
    date: "2024-03-15",
    readTime: "8 min read",
    tags: ["Data Analysis", "Government Data", "Python", "Statistics"],
    link: "https://grahammr93.medium.com/can-us-state-gdp-determine-congressional-representation-e3cda57285f3?sk=35e77d96c3a28c7f1a084875e48a2f19",
    external: true
  },
  {
    id: 2,
    title: "Making Traditional Data Analytics More Accessible in Python",
    excerpt: "Building an API for a statistics book to make interpreting proofs and statistical concepts more accessible to practitioners.",
    date: "2024-02-20",
    readTime: "6 min read",
    tags: ["Python", "API Development", "Statistics", "Education"],
    link: "https://grahammr93.medium.com/making-traditional-data-analytics-more-accessible-in-python-aa765ec85eb?sk=517e9c61e57729516d4a3a939d4cc8e8",
    external: true
  },
  {
    id: 3,
    title: "Closing the Gap: Setting Up an Ubuntu VM for Apache Spark",
    excerpt: "A comprehensive guide to setting up a virtual machine environment for big data processing with Apache Spark.",
    date: "2024-01-10",
    readTime: "12 min read",
    tags: ["Big Data", "Apache Spark", "Ubuntu", "DevOps"],
    link: "https://grahammr93.medium.com/closing-the-gap-setting-up-an-ubuntu-vm-for-apache-spark-5b64dcfd6923?sk=af5a47561a4847e9cf12664ca556d3ab",
    external: true
  }
];

export default function BlogPage() {
  return (
    <div className="min-h-screen pt-20 px-4">
      <div className="max-w-4xl mx-auto">
        <div className="text-center mb-16">
          <h1 className="text-5xl font-bold mb-4 bg-gradient-to-r from-purple-400 via-blue-400 to-emerald-400 bg-clip-text text-transparent">
            Blog
          </h1>
          <p className="text-xl text-gray-400">
            Insights on data science, visualization, and making complex topics accessible
          </p>
          <div className="w-24 h-1 bg-gradient-to-r from-purple-500 to-emerald-500 mx-auto mt-8"></div>
        </div>

        <div className="space-y-8">
          {blogPosts.map((post) => (
            <article 
              key={post.id}
              className="bg-gray-800/50 rounded-xl p-6 border border-gray-700 hover:border-purple-500/50 transition-all duration-300 hover:shadow-xl hover:shadow-purple-500/10"
            >
              <div className="flex flex-wrap gap-2 mb-4">
                {post.tags.map((tag, index) => (
                  <span 
                    key={index}
                    className="px-3 py-1 text-xs font-medium bg-purple-500/20 text-purple-300 rounded-full"
                  >
                    {tag}
                  </span>
                ))}
              </div>

              <h2 className="text-2xl font-bold text-white mb-3 hover:text-purple-400 transition-colors">
                <Link 
                  href={post.link}
                  target={post.external ? "_blank" : "_self"}
                  rel={post.external ? "noopener noreferrer" : undefined}
                >
                  {post.title}
                </Link>
              </h2>

              <p className="text-gray-400 mb-4 leading-relaxed">
                {post.excerpt}
              </p>

              <div className="flex justify-between items-center">
                <div className="flex items-center space-x-4 text-sm text-gray-500">
                  <span>{new Date(post.date).toLocaleDateString('en-US', { 
                    year: 'numeric', 
                    month: 'long', 
                    day: 'numeric' 
                  })}</span>
                  <span>•</span>
                  <span>{post.readTime}</span>
                </div>

                <Link 
                  href={post.link}
                  target={post.external ? "_blank" : "_self"}
                  rel={post.external ? "noopener noreferrer" : undefined}
                  className="inline-flex items-center gap-2 text-emerald-400 hover:text-emerald-300 font-semibold transition-colors group"
                >
                  Read Article
                  {post.external && (
                    <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
                    </svg>
                  )}
                  {!post.external && (
                    <svg className="w-4 h-4 transition-transform group-hover:translate-x-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
                    </svg>
                  )}
                </Link>
              </div>
            </article>
          ))}
        </div>

        <div className="text-center mt-16 py-12 bg-gray-800/30 rounded-xl border border-gray-700">
          <h3 className="text-2xl font-bold text-white mb-4">Want to see more?</h3>
          <p className="text-gray-400 mb-6">
            Check out my Medium profile for all my published articles on data science and analytics.
          </p>
          <Link 
            href="https://grahammr93.medium.com/"
            target="_blank"
            rel="noopener noreferrer"
            className="px-8 py-4 bg-gradient-to-r from-purple-600 to-blue-600 hover:from-purple-700 hover:to-blue-700 rounded-lg font-semibold transition-all duration-300 transform hover:scale-105 shadow-lg hover:shadow-xl inline-flex items-center gap-2"
          >
            Visit Medium Profile
            <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
            </svg>
          </Link>
        </div>
      </div>
    </div>
  );
}