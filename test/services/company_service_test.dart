import 'package:flutter_test/flutter_test.dart';
import 'package:bizwiz/services/company_service.dart';
import 'package:bizwiz/models/company.dart';

void main() {
  late CompanyService companyService;

  setUp(() {
    companyService = CompanyService();
  });

  group('CompanyService Tests', () {
    test('getAllCompanies returns non-empty list', () {
      final companies = companyService.getAllCompanies();
      expect(companies, isNotEmpty);
    });

    test('getAllTechStacks returns unique tech stacks', () {
      final techStacks = companyService.getAllTechStacks();
      expect(techStacks, isNotEmpty);
      expect(techStacks.toSet().length, equals(techStacks.length));
    });

    test('getAllBusinessModels returns unique business models', () {
      final businessModels = companyService.getAllBusinessModels();
      expect(businessModels, isNotEmpty);
      expect(businessModels.toSet().length, equals(businessModels.length));
    });

    group('filterCompanies', () {
      test('filters by category', () {
        final companies = companyService.filterCompanies(
          categories: ['SaaS'],
        );
        expect(companies, isNotEmpty);
        expect(
          companies.every((company) => company.category.contains('SaaS')),
          isTrue,
        );
      });

      test('filters by tech stack', () {
        final companies = companyService.filterCompanies(
          techStacks: ['Flutter'],
        );
        expect(companies, isNotEmpty);
        expect(
          companies.every((company) => company.techStack.contains('Flutter')),
          isTrue,
        );
      });

      test('filters by business model', () {
        final companies = companyService.filterCompanies(
          businessModels: ['B2B'],
        );
        expect(companies, isNotEmpty);
        expect(
          companies.every((company) => company.businessModel == 'B2B'),
          isTrue,
        );
      });

      test('filters by revenue range', () {
        final companies = companyService.filterCompanies(
          minRevenue: 1000000,
          maxRevenue: 5000000,
        );
        expect(companies, isNotEmpty);
        expect(
          companies.every((company) =>
              company.revenue.arr >= 1000000 && company.revenue.arr <= 5000000),
          isTrue,
        );
      });

      test('filters by team size range', () {
        final companies = companyService.filterCompanies(
          minTeamSize: 10,
          maxTeamSize: 50,
        );
        expect(companies, isNotEmpty);
        expect(
          companies.every(
              (company) => company.teamSize >= 10 && company.teamSize <= 50),
          isTrue,
        );
      });

      test('filters by start date', () {
        final startDate = DateTime(2020);
        final companies = companyService.filterCompanies(
          startDate: startDate,
        );
        expect(companies, isNotEmpty);
        expect(
          companies.every((company) => company.startDate.isAfter(startDate)),
          isTrue,
        );
      });

      test('combines multiple filters', () {
        final companies = companyService.filterCompanies(
          categories: ['SaaS'],
          techStacks: ['Flutter'],
          minRevenue: 1000000,
        );
        expect(companies, isNotEmpty);
        expect(
          companies.every((company) =>
              company.category.contains('SaaS') &&
              company.techStack.contains('Flutter') &&
              company.revenue.arr >= 1000000),
          isTrue,
        );
      });
    });
  });
}
