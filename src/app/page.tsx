import Image from "next/image";
import { Hero } from "@/components/hero";
import { FeaturedProjects } from "@/components/featured-projects";
import { About } from "@/components/about";

export default function Home() {
  return (
    <div className="min-h-screen">
      <Hero />
      <About />
      <FeaturedProjects />
    </div>
  );
}
