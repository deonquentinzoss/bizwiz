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
    industry: ['Technology', 'Cloud Computing', 'Enterprise Software'],
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
    industry: ['Technology', 'Cloud Computing', 'Enterprise Software'],
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
    industry: ['Technology', 'Cloud Computing', 'Infrastructure'],
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
  Company(
    id: '4',
    name: 'Stripe',
    logo: 'https://picsum.photos/seed/stripe/400/300',
    elevatorPitch: 'Payment processing platform for internet businesses.',
    startDate: DateTime(2010, 1, 1),
    revenue: Revenue(
      mrr: 50000000,
      arr: 600000000,
      lastUpdated: DateTime.now(),
    ),
    teamSize: 3000,
    category: ['Fintech', 'Payments', 'SaaS'],
    industry: ['Technology', 'Finance', 'Enterprise Software'],
    founder: const Founder(
      name: 'Patrick Collison',
      bio: 'Former founder of Auctomatic and Shuppa.',
      socialLinks: SocialLinks(
        twitter: 'https://twitter.com/patrickc',
        linkedin: 'https://linkedin.com/in/patrickcollison',
      ),
    ),
    companyHistory:
        'Started as a simple payment processing solution and grew into a comprehensive financial platform.',
    milestones: [
      Milestone(
        date: DateTime(2010, 1, 1),
        title: 'Company Founded',
        description: 'Stripe was founded by Patrick and John Collison.',
        type: MilestoneType.other,
      ),
      Milestone(
        date: DateTime(2011, 9, 1),
        title: 'Public Launch',
        description: 'Stripe launched its public API.',
        type: MilestoneType.product,
      ),
    ],
    techStack: ['Ruby', 'Go', 'React'],
    businessModel: 'Transaction-based SaaS',
    marketingStrategies: [
      'Developer-first',
      'API documentation',
      'Technical content'
    ],
    relatedCompanies: ['5', '6'],
  ),
  Company(
    id: '5',
    name: 'Figma',
    logo: 'https://picsum.photos/seed/figma/400/300',
    elevatorPitch: 'Collaborative interface design tool.',
    startDate: DateTime(2012, 1, 1),
    revenue: Revenue(
      mrr: 15000000,
      arr: 180000000,
      lastUpdated: DateTime.now(),
    ),
    teamSize: 400,
    category: ['Design', 'SaaS', 'Collaboration'],
    industry: ['Technology', 'Design', 'Cloud Computing'],
    founder: const Founder(
      name: 'Dylan Field',
      bio: 'Former intern at Flipboard and LinkedIn.',
      socialLinks: SocialLinks(
        twitter: 'https://twitter.com/zoink',
        linkedin: 'https://linkedin.com/in/dylanfield',
      ),
    ),
    companyHistory:
        'Started as a web-based design tool and evolved into a collaborative platform.',
    milestones: [
      Milestone(
        date: DateTime(2012, 1, 1),
        title: 'Company Founded',
        description: 'Figma was founded by Dylan Field and Evan Wallace.',
        type: MilestoneType.other,
      ),
      Milestone(
        date: DateTime(2016, 9, 1),
        title: 'Public Launch',
        description: 'Figma launched its public beta.',
        type: MilestoneType.product,
      ),
    ],
    techStack: ['WebGL', 'TypeScript', 'C++'],
    businessModel: 'Freemium SaaS',
    marketingStrategies: ['Community building', 'Education', 'Design advocacy'],
    relatedCompanies: ['4', '6'],
  ),
  Company(
    id: '6',
    name: 'GitHub',
    logo: 'https://picsum.photos/seed/github/400/300',
    elevatorPitch: 'Platform for software development and collaboration.',
    startDate: DateTime(2008, 1, 1),
    revenue: Revenue(
      mrr: 20000000,
      arr: 240000000,
      lastUpdated: DateTime.now(),
    ),
    teamSize: 2000,
    category: ['Development', 'SaaS', 'Collaboration'],
    industry: ['Technology', 'Cloud Computing', 'Enterprise Software'],
    founder: const Founder(
      name: 'Tom Preston-Werner',
      bio: 'Creator of Jekyll and co-founder of GitHub.',
      socialLinks: SocialLinks(
        twitter: 'https://twitter.com/mojombo',
        github: 'https://github.com/mojombo',
      ),
    ),
    companyHistory:
        'Started as a Git hosting service and grew into a comprehensive development platform.',
    milestones: [
      Milestone(
        date: DateTime(2008, 1, 1),
        title: 'Company Founded',
        description:
            'GitHub was founded by Tom Preston-Werner, Chris Wanstrath, and PJ Hyett.',
        type: MilestoneType.other,
      ),
      Milestone(
        date: DateTime(2018, 6, 1),
        title: 'Microsoft Acquisition',
        description: 'GitHub was acquired by Microsoft.',
        type: MilestoneType.growth,
      ),
    ],
    techStack: ['Ruby', 'Go', 'React'],
    businessModel: 'Freemium SaaS',
    marketingStrategies: ['Open source', 'Developer community', 'Education'],
    relatedCompanies: ['4', '5'],
  ),
  Company(
    id: '7',
    name: 'Slack',
    logo: 'https://picsum.photos/seed/slack/400/300',
    elevatorPitch: 'Business communication platform.',
    startDate: DateTime(2013, 1, 1),
    revenue: Revenue(
      mrr: 25000000,
      arr: 300000000,
      lastUpdated: DateTime.now(),
    ),
    teamSize: 2500,
    category: ['Communication', 'SaaS', 'Collaboration'],
    industry: ['Technology', 'Cloud Computing', 'Enterprise Software'],
    founder: const Founder(
      name: 'Stewart Butterfield',
      bio: 'Former founder of Flickr and Tiny Speck.',
      socialLinks: SocialLinks(
        twitter: 'https://twitter.com/stewart',
        linkedin: 'https://linkedin.com/in/stewartbutterfield',
      ),
    ),
    companyHistory:
        'Started as an internal tool for game development and evolved into a communication platform.',
    milestones: [
      Milestone(
        date: DateTime(2013, 1, 1),
        title: 'Company Founded',
        description: 'Slack was founded by Stewart Butterfield.',
        type: MilestoneType.other,
      ),
      Milestone(
        date: DateTime(2014, 2, 1),
        title: 'Public Launch',
        description: 'Slack launched its public beta.',
        type: MilestoneType.product,
      ),
    ],
    techStack: ['Electron', 'React', 'Node.js'],
    businessModel: 'Freemium SaaS',
    marketingStrategies: [
      'Word of mouth',
      'Integration ecosystem',
      'Enterprise sales'
    ],
    relatedCompanies: ['8', '9'],
  ),
  Company(
    id: '8',
    name: 'Zoom',
    logo: 'https://picsum.photos/seed/zoom/400/300',
    elevatorPitch: 'Video communications platform.',
    startDate: DateTime(2011, 1, 1),
    revenue: Revenue(
      mrr: 30000000,
      arr: 360000000,
      lastUpdated: DateTime.now(),
    ),
    teamSize: 5000,
    category: ['Communication', 'SaaS', 'Video'],
    industry: ['Technology', 'Cloud Computing', 'Enterprise Software'],
    founder: const Founder(
      name: 'Eric Yuan',
      bio: 'Former VP of Engineering at WebEx.',
      socialLinks: SocialLinks(
        twitter: 'https://twitter.com/ericsyuan',
        linkedin: 'https://linkedin.com/in/ericsyuan',
      ),
    ),
    companyHistory:
        'Started as a video conferencing solution and grew into a comprehensive communications platform.',
    milestones: [
      Milestone(
        date: DateTime(2011, 1, 1),
        title: 'Company Founded',
        description: 'Zoom was founded by Eric Yuan.',
        type: MilestoneType.other,
      ),
      Milestone(
        date: DateTime(2019, 4, 1),
        title: 'IPO',
        description: 'Zoom went public on NASDAQ.',
        type: MilestoneType.growth,
      ),
    ],
    techStack: ['C++', 'WebRTC', 'React'],
    businessModel: 'Freemium SaaS',
    marketingStrategies: [
      'Product-led growth',
      'Enterprise sales',
      'Education'
    ],
    relatedCompanies: ['7', '9'],
  ),
  Company(
    id: '9',
    name: 'Dropbox',
    logo: 'https://picsum.photos/seed/dropbox/400/300',
    elevatorPitch: 'File hosting and collaboration platform.',
    startDate: DateTime(2007, 1, 1),
    revenue: Revenue(
      mrr: 20000000,
      arr: 240000000,
      lastUpdated: DateTime.now(),
    ),
    teamSize: 3000,
    category: ['Storage', 'SaaS', 'Collaboration'],
    industry: ['Technology', 'Cloud Computing', 'Enterprise Software'],
    founder: const Founder(
      name: 'Drew Houston',
      bio: 'Former founder of Accolade and Bit9.',
      socialLinks: SocialLinks(
        twitter: 'https://twitter.com/drewhouston',
        linkedin: 'https://linkedin.com/in/drewhouston',
      ),
    ),
    companyHistory:
        'Started as a simple file sync solution and evolved into a comprehensive collaboration platform.',
    milestones: [
      Milestone(
        date: DateTime(2007, 1, 1),
        title: 'Company Founded',
        description: 'Dropbox was founded by Drew Houston and Arash Ferdowsi.',
        type: MilestoneType.other,
      ),
      Milestone(
        date: DateTime(2018, 3, 1),
        title: 'IPO',
        description: 'Dropbox went public on NASDAQ.',
        type: MilestoneType.growth,
      ),
    ],
    techStack: ['Python', 'Go', 'React'],
    businessModel: 'Freemium SaaS',
    marketingStrategies: [
      'Referral program',
      'Product-led growth',
      'Enterprise sales'
    ],
    relatedCompanies: ['7', '8'],
  ),
  Company(
    id: '10',
    name: 'Twilio',
    logo: 'https://picsum.photos/seed/twilio/400/300',
    elevatorPitch: 'Cloud communications platform.',
    startDate: DateTime(2008, 1, 1),
    revenue: Revenue(
      mrr: 15000000,
      arr: 180000000,
      lastUpdated: DateTime.now(),
    ),
    teamSize: 5000,
    category: ['Communication', 'API', 'SaaS'],
    industry: ['Technology', 'Telecommunications', 'Cloud Computing'],
    founder: const Founder(
      name: 'Jeff Lawson',
      bio: 'Former CTO of StubHub and founder of NineStar.',
      socialLinks: SocialLinks(
        twitter: 'https://twitter.com/jeffiel',
        linkedin: 'https://linkedin.com/in/jefflawson',
      ),
    ),
    companyHistory:
        'Started as a simple SMS API and grew into a comprehensive communications platform.',
    milestones: [
      Milestone(
        date: DateTime(2008, 1, 1),
        title: 'Company Founded',
        description: 'Twilio was founded by Jeff Lawson.',
        type: MilestoneType.other,
      ),
      Milestone(
        date: DateTime(2016, 6, 1),
        title: 'IPO',
        description: 'Twilio went public on NYSE.',
        type: MilestoneType.growth,
      ),
    ],
    techStack: ['Python', 'Node.js', 'Java'],
    businessModel: 'Usage-based SaaS',
    marketingStrategies: [
      'Developer-first',
      'API documentation',
      'Technical content'
    ],
    relatedCompanies: ['11', '12'],
  ),
  Company(
    id: '11',
    name: 'MongoDB',
    logo: 'https://picsum.photos/seed/mongodb/400/300',
    elevatorPitch: 'Document database platform.',
    startDate: DateTime(2007, 1, 1),
    revenue: Revenue(
      mrr: 20000000,
      arr: 240000000,
      lastUpdated: DateTime.now(),
    ),
    teamSize: 2000,
    category: ['Database', 'SaaS', 'Infrastructure'],
    industry: ['Technology', 'Database', 'Cloud Computing'],
    founder: const Founder(
      name: 'Eliot Horowitz',
      bio: 'Former CTO of DoubleClick and founder of ShopWiki.',
      socialLinks: SocialLinks(
        twitter: 'https://twitter.com/eliothorowitz',
        linkedin: 'https://linkedin.com/in/eliothorowitz',
      ),
    ),
    companyHistory:
        'Started as an open-source database and evolved into a comprehensive data platform.',
    milestones: [
      Milestone(
        date: DateTime(2007, 1, 1),
        title: 'Company Founded',
        description: 'MongoDB was founded by Eliot Horowitz.',
        type: MilestoneType.other,
      ),
      Milestone(
        date: DateTime(2017, 10, 1),
        title: 'IPO',
        description: 'MongoDB went public on NASDAQ.',
        type: MilestoneType.growth,
      ),
    ],
    techStack: ['C++', 'JavaScript', 'Python'],
    businessModel: 'Open Core SaaS',
    marketingStrategies: [
      'Open source',
      'Developer community',
      'Enterprise sales'
    ],
    relatedCompanies: ['10', '12'],
  ),
  Company(
    id: '12',
    name: 'DigitalOcean',
    logo: 'https://picsum.photos/seed/digitalocean/400/300',
    elevatorPitch: 'Cloud infrastructure provider.',
    startDate: DateTime(2011, 1, 1),
    revenue: Revenue(
      mrr: 10000000,
      arr: 120000000,
      lastUpdated: DateTime.now(),
    ),
    teamSize: 1000,
    category: ['Cloud', 'Infrastructure', 'SaaS'],
    industry: ['Technology', 'Cloud Computing', 'Infrastructure'],
    founder: const Founder(
      name: 'Ben Uretsky',
      bio: 'Former founder of ServerStack and co-founder of DigitalOcean.',
      socialLinks: SocialLinks(
        twitter: 'https://twitter.com/benuretsky',
        linkedin: 'https://linkedin.com/in/benuretsky',
      ),
    ),
    companyHistory:
        'Started as a simple VPS provider and grew into a comprehensive cloud platform.',
    milestones: [
      Milestone(
        date: DateTime(2011, 1, 1),
        title: 'Company Founded',
        description:
            'DigitalOcean was founded by Ben Uretsky and Moisey Uretsky.',
        type: MilestoneType.other,
      ),
      Milestone(
        date: DateTime(2015, 7, 1),
        title: 'Series B Funding',
        description: 'Raised \$83M in Series B funding.',
        type: MilestoneType.growth,
      ),
    ],
    techStack: ['Go', 'Python', 'React'],
    businessModel: 'Usage-based SaaS',
    marketingStrategies: [
      'Developer-first',
      'Technical content',
      'Community building'
    ],
    relatedCompanies: ['10', '11'],
  ),
  Company(
    id: '13',
    name: 'Atlassian',
    logo: 'https://picsum.photos/seed/atlassian/400/300',
    elevatorPitch: 'Team collaboration and productivity software.',
    startDate: DateTime(2002, 1, 1),
    revenue: Revenue(
      mrr: 40000000,
      arr: 480000000,
      lastUpdated: DateTime.now(),
    ),
    teamSize: 6000,
    category: ['Productivity', 'SaaS', 'Collaboration'],
    industry: ['Technology', 'Enterprise Software', 'Collaboration'],
    founder: const Founder(
      name: 'Mike Cannon-Brookes',
      bio: 'Co-founder of Atlassian and entrepreneur.',
      socialLinks: SocialLinks(
        twitter: 'https://twitter.com/mcannonbrookes',
        linkedin: 'https://linkedin.com/in/mikecannonbrookes',
      ),
    ),
    companyHistory:
        'Started as a simple issue tracking tool and grew into a comprehensive collaboration platform.',
    milestones: [
      Milestone(
        date: DateTime(2002, 1, 1),
        title: 'Company Founded',
        description:
            'Atlassian was founded by Mike Cannon-Brookes and Scott Farquhar.',
        type: MilestoneType.other,
      ),
      Milestone(
        date: DateTime(2015, 12, 1),
        title: 'IPO',
        description: 'Atlassian went public on NASDAQ.',
        type: MilestoneType.growth,
      ),
    ],
    techStack: ['Java', 'React', 'TypeScript'],
    businessModel: 'Perpetual License + SaaS',
    marketingStrategies: [
      'Product-led growth',
      'Enterprise sales',
      'Education'
    ],
    relatedCompanies: ['1', '2'],
  ),
];
