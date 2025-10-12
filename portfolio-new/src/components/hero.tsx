import Image from "next/image";
import Link from "next/link";

export function Hero() {
  return (
    <section className="min-h-screen flex items-center justify-center px-4 py-20">
      <div className="max-w-6xl mx-auto grid lg:grid-cols-2 gap-12 items-center">
        {/* Image Container */}
        <div className="flex justify-center lg:justify-end">
          <div className="relative">
            <div className="w-80 h-80 rounded-2xl overflow-hidden border-2 border-purple-500/20 shadow-2xl shadow-purple-500/20">
              <Image
                src="/assets/images/1843.png"
                alt="Mattie #1843"
                width={320}
                height={320}
                className="w-full h-full object-cover"
                priority
              />
            </div>
            <div className="absolute -bottom-4 left-1/2 transform -translate-x-1/2 bg-gray-800 px-4 py-2 rounded-lg border border-gray-700">
              <span className="text-sm text-gray-300">Mattie #1843</span>
            </div>
          </div>
        </div>

        {/* Text Content */}
        <div className="text-center lg:text-left">
          <div className="mb-6">
            <h1 className="text-5xl lg:text-6xl font-bold mb-4 bg-gradient-to-r from-purple-400 via-blue-400 to-emerald-400 bg-clip-text text-transparent">
              Hey, I'm Mattie!
            </h1>
            <p className="text-xl lg:text-2xl text-gray-300 leading-relaxed">
              I am a data professional who brings people and data together through 
              <span className="text-emerald-400 font-semibold"> transparent and efficient governance</span> paired with 
              <span className="text-blue-400 font-semibold"> actionable reporting and analysis</span>.
            </p>
          </div>
          
          <div className="mb-8">
            <p className="text-lg text-gray-400 mb-4">
              I excel at making complex data <span className="text-purple-400 font-semibold">meaningful</span> and <span className="text-emerald-400 font-semibold">accessible</span> in our daily lives.
            </p>
          </div>

          <div className="flex flex-col sm:flex-row gap-4 justify-center lg:justify-start">
            <Link 
              href="/projects"
              className="px-8 py-4 bg-gradient-to-r from-purple-600 to-blue-600 hover:from-purple-700 hover:to-blue-700 rounded-lg font-semibold transition-all duration-300 transform hover:scale-105 shadow-lg hover:shadow-xl"
            >
              Check out my projects
            </Link>
            <Link 
              href="/resume"
              className="px-8 py-4 border border-gray-600 hover:border-purple-500 rounded-lg font-semibold transition-all duration-300 hover:bg-purple-500/10"
            >
              View Resume
            </Link>
            <Link 
              href="/contact"
              className="px-8 py-4 border border-gray-600 hover:border-emerald-500 rounded-lg font-semibold transition-all duration-300 hover:bg-emerald-500/10"
            >
              Get in Touch
            </Link>
          </div>
        </div>
      </div>
    </section>
  );
}