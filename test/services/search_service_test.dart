import 'package:flutter_test/flutter_test.dart';
import 'package:bizwiz/services/search_service.dart';
import 'package:bizwiz/services/company_service.dart';

void main() {
  late SearchService searchService;
  late CompanyService companyService;

  setUp(() {
    companyService = CompanyService();
    searchService = SearchService(companyService);
  });

  group('SearchService Tests', () {
    test('search returns matching companies by name', () {
      final results = searchService.search('TechCorp');
      expect(results.length, 1);
      expect(results[0].name, 'TechCorp');
    });

    test('search returns matching companies by category', () {
      final results = searchService.search('SaaS');
      expect(results.length, 1);
      expect(results[0].category, contains('SaaS'));
    });

    test('search returns matching companies by tech stack', () {
      final results = searchService.search('Flutter');
      expect(results.length, 1);
      expect(results[0].techStack, contains('Flutter'));
    });

    test('search returns matching companies by business model', () {
      final results = searchService.search('B2B');
      expect(results.length, 2);
      expect(
          results.every((company) => company.businessModel == 'B2B'), isTrue);
    });

    test('search returns matching companies by founder name', () {
      final results = searchService.search('John');
      expect(results.length, 1);
      expect(results[0].founder.name, 'John Doe');
    });

    test('search returns matching companies by elevator pitch', () {
      final results = searchService.search('analytics');
      expect(results.length, 1);
      expect(results[0].name, 'DataFlow');
    });

    test('search is case insensitive', () {
      final results = searchService.search('techcorp');
      expect(results.length, 1);
      expect(results[0].name, 'TechCorp');
    });

    test('search returns empty list for no matches', () {
      final results = searchService.search('nonexistent');
      expect(results, isEmpty);
    });

    test('search returns empty list for empty query', () {
      final results = searchService.search('');
      expect(results, isEmpty);
    });

    test('search with filters', () {
      final results = searchService.search(
        'Tech',
        category: 'SaaS',
        techStacks: ['Flutter'],
        businessModel: 'B2B',
      );
      expect(results.length, 1);
      expect(results[0].name, 'TechCorp');
    });

    test('search history is maintained', () {
      searchService.search('TechCorp');
      searchService.search('DataFlow');
      final history = searchService.getSearchHistory();
      expect(history.length, 2);
      expect(history[0], 'DataFlow');
      expect(history[1], 'TechCorp');
    });

    test('search history is limited to max items', () {
      for (var i = 0; i < 15; i++) {
        searchService.search('query$i');
      }
      expect(searchService.getSearchHistory().length, 10);
    });

    test('clearHistory removes all search history', () {
      searchService.search('TechCorp');
      searchService.search('DataFlow');
      searchService.clearSearchHistory();
      expect(searchService.getSearchHistory(), isEmpty);
    });
  });
}
