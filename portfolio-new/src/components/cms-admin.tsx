'use client';

import { useState } from 'react';
import { FaPlus, FaEdit, FaTrash, FaSave, FaEye } from 'react-icons/fa';

interface CMSAdminProps {
  // This would be expanded in a real CMS system
}

export default function CMSAdmin() {
  const [activeTab, setActiveTab] = useState<'projects' | 'blog' | 'settings'>('projects');
  const [isEditing, setIsEditing] = useState(false);

  return (
    <div className="min-h-screen bg-gray-900 p-4">
      <div className="max-w-7xl mx-auto">
        {/* Header */}
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-white mb-2">Content Management System</h1>
          <p className="text-gray-400">
            Manage your portfolio content easily without touching code
          </p>
        </div>

        {/* Navigation Tabs */}
        <div className="border-b border-gray-700 mb-8">
          <nav className="flex space-x-8">
            {[
              { id: 'projects', label: 'Projects', count: 12 },
              { id: 'blog', label: 'Blog Posts', count: 8 },
              { id: 'settings', label: 'Settings', count: null }
            ].map((tab) => (
              <button
                key={tab.id}
                onClick={() => setActiveTab(tab.id as any)}
                className={`py-4 px-1 border-b-2 font-medium text-sm transition-colors ${
                  activeTab === tab.id
                    ? 'border-purple-500 text-purple-400'
                    : 'border-transparent text-gray-400 hover:text-gray-300 hover:border-gray-300'
                }`}
              >
                {tab.label}
                {tab.count && (
                  <span className="ml-2 bg-gray-700 text-gray-300 py-1 px-2 rounded-full text-xs">
                    {tab.count}
                  </span>
                )}
              </button>
            ))}
          </nav>
        </div>

        {/* Content Areas */}
        {activeTab === 'projects' && (
          <div className="space-y-6">
            <div className="flex justify-between items-center">
              <h2 className="text-2xl font-bold text-white">Manage Projects</h2>
              <button className="bg-purple-600 hover:bg-purple-700 text-white px-4 py-2 rounded-lg flex items-center space-x-2 transition-colors">
                <FaPlus />
                <span>Add New Project</span>
              </button>
            </div>

            <div className="bg-gray-800 rounded-lg p-6 border border-gray-700">
              <div className="text-center py-12">
                <div className="text-6xl text-gray-600 mb-4">🚧</div>
                <h3 className="text-xl font-semibold text-white mb-2">CMS Under Construction</h3>
                <p className="text-gray-400 mb-6 max-w-2xl mx-auto">
                  The visual CMS interface is coming soon! For now, you can edit your content directly in the 
                  <code className="bg-gray-700 px-2 py-1 rounded mx-1">src/data/cms-config.ts</code> file.
                </p>
                <div className="space-y-3 text-left max-w-3xl mx-auto">
                  <div className="bg-gray-700/50 p-4 rounded-lg">
                    <h4 className="text-purple-400 font-semibold mb-2">✨ How to add a new project:</h4>
                    <ol className="text-gray-300 space-y-1 text-sm">
                      <li>1. Open <code className="bg-gray-800 px-1 rounded">src/data/cms-config.ts</code></li>
                      <li>2. Find the <code className="bg-gray-800 px-1 rounded">projects</code> array</li>
                      <li>3. Copy an existing project object</li>
                      <li>4. Update the details (title, description, technologies, etc.)</li>
                      <li>5. Save the file - changes appear instantly!</li>
                    </ol>
                  </div>
                  <div className="bg-gray-700/50 p-4 rounded-lg">
                    <h4 className="text-blue-400 font-semibold mb-2">📝 How to add a blog post:</h4>
                    <ol className="text-gray-300 space-y-1 text-sm">
                      <li>1. Find the <code className="bg-gray-800 px-1 rounded">blogPosts</code> array in the same file</li>
                      <li>2. Copy an existing blog post object</li>
                      <li>3. Write your content in Markdown format</li>
                      <li>4. Update metadata (title, tags, date, etc.)</li>
                      <li>5. Save and your blog post goes live!</li>
                    </ol>
                  </div>
                  <div className="bg-gray-700/50 p-4 rounded-lg">
                    <h4 className="text-emerald-400 font-semibold mb-2">⚙️ Update social links & personal info:</h4>
                    <ol className="text-gray-300 space-y-1 text-sm">
                      <li>1. Find the <code className="bg-gray-800 px-1 rounded">socialLinks</code> and <code className="bg-gray-800 px-1 rounded">personalInfo</code> sections</li>
                      <li>2. Update URLs, contact information, and bio</li>
                      <li>3. Changes reflect immediately across the site</li>
                    </ol>
                  </div>
                </div>
              </div>
            </div>
          </div>
        )}

        {activeTab === 'blog' && (
          <div className="space-y-6">
            <div className="flex justify-between items-center">
              <h2 className="text-2xl font-bold text-white">Manage Blog Posts</h2>
              <button className="bg-purple-600 hover:bg-purple-700 text-white px-4 py-2 rounded-lg flex items-center space-x-2 transition-colors">
                <FaPlus />
                <span>New Blog Post</span>
              </button>
            </div>

            <div className="bg-gray-800 rounded-lg p-6 border border-gray-700">
              <div className="text-center py-12">
                <div className="text-6xl text-gray-600 mb-4">📝</div>
                <h3 className="text-xl font-semibold text-white mb-2">Blog Management</h3>
                <p className="text-gray-400 mb-4">
                  Currently, blog posts are managed through the configuration file. 
                  A full-featured blog editor is coming in the next update!
                </p>
              </div>
            </div>
          </div>
        )}

        {activeTab === 'settings' && (
          <div className="space-y-6">
            <h2 className="text-2xl font-bold text-white">Site Settings</h2>
            
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div className="bg-gray-800 rounded-lg p-6 border border-gray-700">
                <h3 className="text-lg font-semibold text-white mb-4">Personal Information</h3>
                <div className="space-y-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-300 mb-2">Name</label>
                    <input
                      type="text"
                      defaultValue="Matt Graham"
                      className="w-full px-3 py-2 bg-gray-700 border border-gray-600 rounded-lg text-white"
                      disabled
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-300 mb-2">Email</label>
                    <input
                      type="email"
                      defaultValue="grahammr93@gmail.com"
                      className="w-full px-3 py-2 bg-gray-700 border border-gray-600 rounded-lg text-white"
                      disabled
                    />
                  </div>
                  <p className="text-sm text-gray-400">
                    Edit these values in <code className="bg-gray-700 px-1 rounded">src/data/cms-config.ts</code>
                  </p>
                </div>
              </div>

              <div className="bg-gray-800 rounded-lg p-6 border border-gray-700">
                <h3 className="text-lg font-semibold text-white mb-4">Site Configuration</h3>
                <div className="space-y-4">
                  <div className="flex items-center justify-between">
                    <span className="text-gray-300">Show project metrics</span>
                    <input type="checkbox" defaultChecked disabled className="rounded" />
                  </div>
                  <div className="flex items-center justify-between">
                    <span className="text-gray-300">Show blog read times</span>
                    <input type="checkbox" defaultChecked disabled className="rounded" />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-300 mb-2">
                      Max featured projects
                    </label>
                    <input
                      type="number"
                      defaultValue="3"
                      className="w-20 px-3 py-2 bg-gray-700 border border-gray-600 rounded-lg text-white"
                      disabled
                    />
                  </div>
                </div>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}