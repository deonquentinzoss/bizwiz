import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bizwiz/widgets/filter_bar.dart';

void main() {
  testWidgets('FilterBar displays all filter options',
      (WidgetTester tester) async {
    // Build our widget and trigger a frame
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FilterBar(
            categories: const ['SaaS', 'Tech'],
            techStacks: const ['Flutter', 'Dart'],
            businessModels: const ['B2B', 'B2C'],
            selectedCategories: const [],
            startDate: null,
            minRevenue: null,
            maxRevenue: null,
            minTeamSize: null,
            maxTeamSize: null,
            selectedTechStacks: const [],
            selectedBusinessModels: const [],
            onCategoriesChanged: (_) {},
            onStartDateChanged: (_) {},
            onMinRevenueChanged: (_) {},
            onMaxRevenueChanged: (_) {},
            onMinTeamSizeChanged: (_) {},
            onMaxTeamSizeChanged: (_) {},
            onTechStacksChanged: (_) {},
            onBusinessModelsChanged: (_) {},
            onClearFilters: () {},
            onSearch: (_) {},
            searchHistory: const [],
            onClearHistory: () {},
          ),
        ),
      ),
    );

    // Verify that all filter options are displayed
    expect(find.text('Category'), findsOneWidget);
    expect(find.text('Tech Stack'), findsOneWidget);
    expect(find.text('Business Model'), findsOneWidget);
    expect(find.text('Start Date'), findsOneWidget);
    expect(find.text('Revenue'), findsOneWidget);
    expect(find.text('Team Size'), findsOneWidget);
  });

  testWidgets('FilterBar shows selected filters', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FilterBar(
            categories: const ['SaaS', 'Tech'],
            techStacks: const ['Flutter', 'Dart'],
            businessModels: const ['B2B', 'B2C'],
            selectedCategories: const ['SaaS'],
            startDate: DateTime(2020),
            minRevenue: 1000000,
            maxRevenue: 5000000,
            minTeamSize: 10,
            maxTeamSize: 50,
            selectedTechStacks: const ['Flutter'],
            selectedBusinessModels: const ['B2B'],
            onCategoriesChanged: (_) {},
            onStartDateChanged: (_) {},
            onMinRevenueChanged: (_) {},
            onMaxRevenueChanged: (_) {},
            onMinTeamSizeChanged: (_) {},
            onMaxTeamSizeChanged: (_) {},
            onTechStacksChanged: (_) {},
            onBusinessModelsChanged: (_) {},
            onClearFilters: () {},
            onSearch: (_) {},
            searchHistory: const [],
            onClearHistory: () {},
          ),
        ),
      ),
    );

    // Verify that selected filters are displayed
    expect(find.text('SaaS'), findsOneWidget);
    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('B2B'), findsOneWidget);
    expect(find.text('2020'), findsOneWidget);
    expect(find.text('1M - 5M'), findsOneWidget);
    expect(find.text('10 - 50'), findsOneWidget);
  });

  testWidgets('FilterBar calls callbacks when filters change',
      (WidgetTester tester) async {
    String? selectedCategory;
    String? selectedTechStack;
    String? selectedBusinessModel;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FilterBar(
            categories: const ['SaaS', 'Tech'],
            techStacks: const ['Flutter', 'Dart'],
            businessModels: const ['B2B', 'B2C'],
            selectedCategories: const [],
            startDate: null,
            minRevenue: null,
            maxRevenue: null,
            minTeamSize: null,
            maxTeamSize: null,
            selectedTechStacks: const [],
            selectedBusinessModels: const [],
            onCategoriesChanged: (categories) {
              selectedCategory = categories.first;
            },
            onStartDateChanged: (date) {},
            onMinRevenueChanged: (revenue) {},
            onMaxRevenueChanged: (revenue) {},
            onMinTeamSizeChanged: (size) {},
            onMaxTeamSizeChanged: (size) {},
            onTechStacksChanged: (stacks) {
              selectedTechStack = stacks.first;
            },
            onBusinessModelsChanged: (models) {
              selectedBusinessModel = models.first;
            },
            onClearFilters: () {},
            onSearch: (_) {},
            searchHistory: const [],
            onClearHistory: () {},
          ),
        ),
      ),
    );

    // Open category dropdown
    await tester.tap(find.text('Category'));
    await tester.pumpAndSettle();

    // Select a category
    await tester.tap(find.text('SaaS'));
    await tester.pumpAndSettle();

    expect(selectedCategory, 'SaaS');

    // Open tech stack dropdown
    await tester.tap(find.text('Tech Stack'));
    await tester.pumpAndSettle();

    // Select a tech stack
    await tester.tap(find.text('Flutter'));
    await tester.pumpAndSettle();

    expect(selectedTechStack, 'Flutter');

    // Open business model dropdown
    await tester.tap(find.text('Business Model'));
    await tester.pumpAndSettle();

    // Select a business model
    await tester.tap(find.text('B2B'));
    await tester.pumpAndSettle();

    expect(selectedBusinessModel, 'B2B');
  });

  testWidgets('FilterBar clears filters when clear button is pressed',
      (WidgetTester tester) async {
    bool clearPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FilterBar(
            categories: const ['SaaS', 'Tech'],
            techStacks: const ['Flutter', 'Dart'],
            businessModels: const ['B2B', 'B2C'],
            selectedCategories: const ['SaaS'],
            startDate: DateTime(2020),
            minRevenue: 1000000,
            maxRevenue: 5000000,
            minTeamSize: 10,
            maxTeamSize: 50,
            selectedTechStacks: const ['Flutter'],
            selectedBusinessModels: const ['B2B'],
            onCategoriesChanged: (_) {},
            onStartDateChanged: (_) {},
            onMinRevenueChanged: (_) {},
            onMaxRevenueChanged: (_) {},
            onMinTeamSizeChanged: (_) {},
            onMaxTeamSizeChanged: (_) {},
            onTechStacksChanged: (_) {},
            onBusinessModelsChanged: (_) {},
            onClearFilters: () {
              clearPressed = true;
            },
            onSearch: (_) {},
            searchHistory: const [],
            onClearHistory: () {},
          ),
        ),
      ),
    );

    // Press clear button
    await tester.tap(find.byIcon(Icons.clear_all));
    await tester.pumpAndSettle();

    expect(clearPressed, true);
  });

  testWidgets('FilterBar shows search history', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FilterBar(
            categories: const ['SaaS', 'Tech'],
            techStacks: const ['Flutter', 'Dart'],
            businessModels: const ['B2B', 'B2C'],
            selectedCategories: const [],
            startDate: null,
            minRevenue: null,
            maxRevenue: null,
            minTeamSize: null,
            maxTeamSize: null,
            selectedTechStacks: const [],
            selectedBusinessModels: const [],
            onCategoriesChanged: (_) {},
            onStartDateChanged: (_) {},
            onMinRevenueChanged: (_) {},
            onMaxRevenueChanged: (_) {},
            onMinTeamSizeChanged: (_) {},
            onMaxTeamSizeChanged: (_) {},
            onTechStacksChanged: (_) {},
            onBusinessModelsChanged: (_) {},
            onClearFilters: () {},
            onSearch: (_) {},
            searchHistory: const ['TechCorp', 'DataFlow'],
            onClearHistory: () {},
          ),
        ),
      ),
    );

    // Focus search field
    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle();

    // Verify search history is displayed
    expect(find.text('TechCorp'), findsOneWidget);
    expect(find.text('DataFlow'), findsOneWidget);
  });
}
