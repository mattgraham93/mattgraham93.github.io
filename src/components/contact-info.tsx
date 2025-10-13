import { FaMapMarkerAlt, FaClock, FaPhone, FaCalendarAlt } from 'react-icons/fa';

export default function ContactInfo() {
  return (
    <div className="bg-gray-800/50 backdrop-blur-sm rounded-xl p-8 border border-gray-700">
      <h3 className="text-2xl font-bold mb-6 text-white">Contact Information</h3>
      
      <div className="space-y-6">
        <div className="flex items-start space-x-4">
          <div className="flex-shrink-0 w-12 h-12 bg-purple-600/20 rounded-lg flex items-center justify-center">
            <FaMapMarkerAlt className="text-purple-400" />
          </div>
          <div>
            <h4 className="font-semibold text-white mb-1">Location</h4>
            <p className="text-gray-400">
              Based in the United States<br />
              Open to remote work opportunities
            </p>
          </div>
        </div>

        <div className="flex items-start space-x-4">
          <div className="flex-shrink-0 w-12 h-12 bg-blue-600/20 rounded-lg flex items-center justify-center">
            <FaClock className="text-blue-400" />
          </div>
          <div>
            <h4 className="font-semibold text-white mb-1">Response Time</h4>
            <p className="text-gray-400">
              I typically respond within 24-48 hours<br />
              Faster response for urgent inquiries
            </p>
          </div>
        </div>

        <div className="flex items-start space-x-4">
          <div className="flex-shrink-0 w-12 h-12 bg-emerald-600/20 rounded-lg flex items-center justify-center">
            <FaCalendarAlt className="text-emerald-400" />
          </div>
          <div>
            <h4 className="font-semibold text-white mb-1">Availability</h4>
            <p className="text-gray-400">
              Available for freelance projects<br />
              Currently seeking full-time opportunities
            </p>
          </div>
        </div>
      </div>

      <div className="mt-8 p-4 bg-gradient-to-r from-purple-600/10 to-blue-600/10 rounded-lg border border-purple-600/20">
        <h4 className="font-semibold text-white mb-2">Interested in collaboration?</h4>
        <p className="text-gray-300 text-sm">
          I'm passionate about data-driven solutions and love working on projects that make a real impact. 
          Let's discuss how we can work together!
        </p>
      </div>
    </div>
  );
}