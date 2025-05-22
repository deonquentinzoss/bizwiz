import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bizwiz/widgets/company_card.dart';
import 'package:bizwiz/models/company.dart';

void main() {
  final mockCompany = Company(
    id: '1',
    name: 'TechCorp',
    logo: 'logo1.png',
    elevatorPitch: 'Leading tech company',
    startDate: DateTime(2020),
    revenue: Revenue(mrr: 100000, arr: 1200000, lastUpdated: DateTime.now()),
    teamSize: 50,
    category: ['SaaS', 'Tech'],
    founder: const Founder(
      name: 'John Doe',
      bio: 'Tech entrepreneur',
      socialLinks: SocialLinks(),
    ),
    companyHistory: 'Founded in 2020',
    milestones: [],
    techStack: ['Flutter', 'Dart'],
    businessModel: 'B2B',
    marketingStrategies: [],
    relatedCompanies: [],
  );

  testWidgets('CompanyCard displays company information',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CompanyCard(
            company: mockCompany,
            onTap: () {},
          ),
        ),
      ),
    );

    // Verify company information is displayed
    expect(find.text('TechCorp'), findsOneWidget);
    expect(find.text('Leading tech company'), findsOneWidget);
    expect(find.text('SaaS'), findsOneWidget);
    expect(find.text('Tech'), findsOneWidget);
    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('Dart'), findsOneWidget);
    expect(find.text('B2B'), findsOneWidget);
    expect(find.text('50'), findsOneWidget);
    expect(find.text('1.2M'), findsOneWidget);
  });

  testWidgets('CompanyCard shows loading state', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CompanyCard(
            company: mockCompany,
            onTap: () {},
            isLoading: true,
          ),
        ),
      ),
    );

    // Verify loading indicator is displayed
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('CompanyCard handles tap events', (WidgetTester tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CompanyCard(
            company: mockCompany,
            onTap: () {
              tapped = true;
            },
          ),
        ),
      ),
    );

    // Tap the card
    await tester.tap(find.byType(Card));
    await tester.pumpAndSettle();

    expect(tapped, true);
  });

  testWidgets('CompanyCard handles image loading error',
      (WidgetTester tester) async {
    final companyWithInvalidLogo = Company(
      id: '1',
      name: 'TechCorp',
      logo: 'invalid.png',
      elevatorPitch: 'Leading tech company',
      startDate: DateTime(2020),
      revenue: Revenue(mrr: 100000, arr: 1200000, lastUpdated: DateTime.now()),
      teamSize: 50,
      category: ['SaaS', 'Tech'],
      founder: const Founder(
        name: 'John Doe',
        bio: 'Tech entrepreneur',
        socialLinks: SocialLinks(),
      ),
      companyHistory: 'Founded in 2020',
      milestones: [],
      techStack: ['Flutter', 'Dart'],
      businessModel: 'B2B',
      marketingStrategies: [],
      relatedCompanies: [],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CompanyCard(
            company: companyWithInvalidLogo,
            onTap: () {},
          ),
        ),
      ),
    );

    // Verify error icon is displayed
    expect(find.byIcon(Icons.business), findsOneWidget);
  });

  testWidgets('CompanyCard formats revenue correctly',
      (WidgetTester tester) async {
    final companyWithLargeRevenue = Company(
      id: '1',
      name: 'TechCorp',
      logo: 'logo1.png',
      elevatorPitch: 'Leading tech company',
      startDate: DateTime(2020),
      revenue: Revenue(
        mrr: 1000000,
        arr: 12000000,
        lastUpdated: DateTime.now(),
      ),
      teamSize: 50,
      category: ['SaaS', 'Tech'],
      founder: const Founder(
        name: 'John Doe',
        bio: 'Tech entrepreneur',
        socialLinks: SocialLinks(),
      ),
      companyHistory: 'Founded in 2020',
      milestones: [],
      techStack: ['Flutter', 'Dart'],
      businessModel: 'B2B',
      marketingStrategies: [],
      relatedCompanies: [],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CompanyCard(
            company: companyWithLargeRevenue,
            onTap: () {},
          ),
        ),
      ),
    );

    // Verify revenue is formatted correctly
    expect(find.text('12M'), findsOneWidget);
  });
}
