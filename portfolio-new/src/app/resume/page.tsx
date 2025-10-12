import { ResumeHeader } from "@/components/resume/resume-header";
import { Experience } from "@/components/resume/experience";
import { Education } from "@/components/resume/education";
import { Skills } from "@/components/resume/skills";
import { Certifications } from "@/components/resume/certifications";

export default function ResumePage() {
  return (
    <div className="min-h-screen pt-20 px-4">
      <div className="max-w-5xl mx-auto">
        <ResumeHeader />
        <div className="space-y-16">
          <Experience />
          <Skills />
          <Education />
          <Certifications />
        </div>
        
        {/* Download Button */}
        <div className="text-center mt-16 mb-12">
          <button className="px-8 py-4 bg-gradient-to-r from-purple-600 to-blue-600 hover:from-purple-700 hover:to-blue-700 rounded-lg font-semibold transition-all duration-300 transform hover:scale-105 shadow-lg hover:shadow-xl">
            Download PDF Resume
          </button>
        </div>
      </div>
    </div>
  );
}