import ContactForm from '@/components/contact-form';
import SocialLinks from '@/components/social-links';
import ContactInfo from '@/components/contact-info';

export default function ContactPage() {
  return (
    <div className="min-h-screen pt-20 px-4">
      <div className="max-w-7xl mx-auto">
        {/* Header Section */}
        <div className="text-center mb-16">
          <h1 className="text-5xl font-bold mb-4 bg-gradient-to-r from-purple-400 via-blue-400 to-emerald-400 bg-clip-text text-transparent">
            Get in Touch
          </h1>
          <p className="text-xl text-gray-400 max-w-3xl mx-auto">
            Ready to collaborate on your next data project? I'd love to hear from you. 
            Whether you have a question, project idea, or just want to connect, let's start a conversation.
          </p>
          <div className="w-24 h-1 bg-gradient-to-r from-purple-500 to-emerald-500 mx-auto mt-8"></div>
        </div>
        
        {/* Main Content Grid */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 mb-16">
          {/* Left Column - Contact Form */}
          <div>
            <ContactForm />
          </div>
          
          {/* Right Column - Contact Info */}
          <div className="space-y-8">
            <ContactInfo />
            <SocialLinks />
          </div>
        </div>

        {/* Call to Action Section */}
        <div className="bg-gradient-to-r from-purple-600/10 via-blue-600/10 to-emerald-600/10 rounded-2xl p-8 border border-purple-600/20 text-center">
          <h2 className="text-3xl font-bold mb-4 text-white">
            Let's Build Something Amazing Together
          </h2>
          <p className="text-gray-300 mb-6 max-w-2xl mx-auto">
            I'm passionate about turning data into insights and insights into action. 
            If you're looking for someone who can help you make data-driven decisions, 
            optimize processes, or build predictive models, I'd love to discuss your project.
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <a
              href="mailto:eight-amens76@icloud.com"
              className="bg-gradient-to-r from-purple-600 to-blue-600 hover:from-purple-700 hover:to-blue-700 text-white font-semibold py-3 px-8 rounded-lg transition-all duration-300 inline-flex items-center justify-center"
            >
              Send Email Directly
            </a>
            <a
              href="/resume"
              className="border border-purple-600 text-purple-400 hover:bg-purple-600/10 font-semibold py-3 px-8 rounded-lg transition-all duration-300 inline-flex items-center justify-center"
            >
              View My Resume
            </a>
          </div>
        </div>
      </div>
    </div>
  );
}