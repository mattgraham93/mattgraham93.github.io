import CMSAdmin from '@/components/cms-admin';

export default function AdminPage() {
  return <CMSAdmin />;
}

export const metadata = {
  title: 'Admin - Content Management System',
  description: 'Manage your portfolio content',
  robots: 'noindex, nofollow', // Don't index the admin page
};