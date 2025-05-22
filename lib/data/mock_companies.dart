import '../models/company.dart';
import '../models/milestone.dart';

final List<Company> mockCompanies = [
  Company(
    id: '1',
    name: 'Notion',
    logo: 'https://picsum.photos/seed/notion/400/300',
    elevatorPitch:
        'All-in-one workspace for notes, docs, and project management.',
    startDate: DateTime(2016, 1, 1),
    revenue: Revenue(
      mrr: 10000000,
      arr: 120000000,
      lastUpdated: DateTime.now(),
    ),
    teamSize: 200,
    category: ['Productivity', 'SaaS', 'Collaboration'],
    founder: const Founder(
      name: 'Ivan Zhao',
      bio:
          'Former designer and developer who wanted to create a better way to organize information.',
      socialLinks: SocialLinks(
        twitter: 'https://twitter.com/ivanhzhao',
        linkedin: 'https://linkedin.com/in/ivanhzhao',
      ),
    ),
    companyHistory:
        'Notion started as a simple note-taking app and evolved into a comprehensive workspace platform.',
    milestones: [
      Milestone(
        date: DateTime(2016, 1, 1),
        title: 'Company Founded',
        description: 'Notion was founded by Ivan Zhao and Simon Last.',
        type: MilestoneType.other,
      ),
      Milestone(
        date: DateTime(2018, 3, 1),
        title: 'Public Launch',
        description: 'Notion launched publicly after two years of development.',
        type: MilestoneType.product,
      ),
    ],
    techStack: ['React', 'TypeScript', 'Node.js'],
    businessModel: 'Freemium SaaS',
    marketingStrategies: [
      'Product-led growth',
      'Community building',
      'Word of mouth'
    ],
    relatedCompanies: ['2', '3'],
  ),
  Company(
    id: '2',
    name: 'Linear',
    logo: 'https://picsum.photos/seed/linear/400/300',
    elevatorPitch: 'Issue tracking tool for high-performance teams.',
    startDate: DateTime(2019, 1, 1),
    revenue: Revenue(
      mrr: 5000000,
      arr: 60000000,
      lastUpdated: DateTime.now(),
    ),
    teamSize: 50,
    category: ['Development', 'SaaS', 'Project Management'],
    founder: const Founder(
      name: 'Karri Saarinen',
      bio:
          'Former designer at Airbnb who wanted to create a better issue tracking tool.',
      socialLinks: SocialLinks(
        twitter: 'https://twitter.com/karrisaarinen',
        github: 'https://github.com/karrisaarinen',
      ),
    ),
    companyHistory:
        'Linear was built to solve the pain points of existing issue tracking tools.',
    milestones: [
      Milestone(
        date: DateTime(2019, 1, 1),
        title: 'Company Founded',
        description: 'Linear was founded by Karri Saarinen and Tuomas Artman.',
        type: MilestoneType.other,
      ),
      Milestone(
        date: DateTime(2020, 3, 1),
        title: 'Public Beta',
        description: 'Linear launched its public beta.',
        type: MilestoneType.product,
      ),
    ],
    techStack: ['React', 'TypeScript', 'GraphQL'],
    businessModel: 'SaaS',
    marketingStrategies: ['Product-led growth', 'Developer community'],
    relatedCompanies: ['1', '3'],
  ),
  Company(
    id: '3',
    name: 'Vercel',
    logo: 'https://picsum.photos/seed/vercel/400/300',
    elevatorPitch: 'Cloud platform for static sites and Serverless Functions.',
    startDate: DateTime(2015, 1, 1),
    revenue: Revenue(
      mrr: 8000000,
      arr: 96000000,
      lastUpdated: DateTime.now(),
    ),
    teamSize: 150,
    category: ['Development', 'Cloud', 'Infrastructure'],
    founder: const Founder(
      name: 'Guillermo Rauch',
      bio: 'Creator of Socket.io and former CTO of LearnBoost.',
      socialLinks: SocialLinks(
        twitter: 'https://twitter.com/rauchg',
        github: 'https://github.com/rauchg',
      ),
    ),
    companyHistory: 'Started as ZEIT, focused on cloud deployment and hosting.',
    milestones: [
      Milestone(
        date: DateTime(2015, 1, 1),
        title: 'Company Founded',
        description: 'ZEIT was founded by Guillermo Rauch.',
        type: MilestoneType.other,
      ),
      Milestone(
        date: DateTime(2020, 4, 1),
        title: 'Rebrand to Vercel',
        description: 'ZEIT rebranded to Vercel.',
        type: MilestoneType.growth,
      ),
    ],
    techStack: ['Next.js', 'React', 'Node.js'],
    businessModel: 'SaaS',
    marketingStrategies: [
      'Open source',
      'Developer community',
      'Content marketing'
    ],
    relatedCompanies: ['1', '2'],
  ),
];
