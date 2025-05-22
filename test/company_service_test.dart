import 'package:flutter_test/flutter_test.dart';
import 'package:bizwiz/services/company_service.dart';
import 'package:bizwiz/widgets/sort_bar.dart';
import 'package:bizwiz/models/company.dart';

void main() {
  late CompanyService companyService;

  setUp(() {
    companyService = CompanyService();
  });

  group('CompanyService Sorting Tests', () {
    test('Sort by date ascending', () {
      final companies = companyService.getAllCompanies();
      final sorted = companyService.sortCompanies(
        companies,
        field: SortField.date,
        order: SortOrder.ascending,
      );

      // Verify the list is sorted by date
      for (int i = 0; i < sorted.length - 1; i++) {
        expect(
          sorted[i].startDate.isBefore(sorted[i + 1].startDate) ||
              sorted[i].startDate.isAtSameMomentAs(sorted[i + 1].startDate),
          true,
          reason: 'Companies should be sorted by date in ascending order',
        );
      }
    });

    test('Sort by date descending', () {
      final companies = companyService.getAllCompanies();
      final sorted = companyService.sortCompanies(
        companies,
        field: SortField.date,
        order: SortOrder.descending,
      );

      // Verify the list is sorted by date in descending order
      for (int i = 0; i < sorted.length - 1; i++) {
        expect(
          sorted[i].startDate.isAfter(sorted[i + 1].startDate) ||
              sorted[i].startDate.isAtSameMomentAs(sorted[i + 1].startDate),
          true,
          reason: 'Companies should be sorted by date in descending order',
        );
      }
    });

    test('Sort by revenue ascending', () {
      final companies = companyService.getAllCompanies();
      final sorted = companyService.sortCompanies(
        companies,
        field: SortField.revenue,
        order: SortOrder.ascending,
      );

      // Verify the list is sorted by revenue
      for (int i = 0; i < sorted.length - 1; i++) {
        expect(
          sorted[i].revenue.mrr <= sorted[i + 1].revenue.mrr,
          true,
          reason: 'Companies should be sorted by revenue in ascending order',
        );
      }
    });

    test('Sort by revenue descending', () {
      final companies = companyService.getAllCompanies();
      final sorted = companyService.sortCompanies(
        companies,
        field: SortField.revenue,
        order: SortOrder.descending,
      );

      // Verify the list is sorted by revenue in descending order
      for (int i = 0; i < sorted.length - 1; i++) {
        expect(
          sorted[i].revenue.mrr >= sorted[i + 1].revenue.mrr,
          true,
          reason: 'Companies should be sorted by revenue in descending order',
        );
      }
    });

    test('Sort by team size ascending', () {
      final companies = companyService.getAllCompanies();
      final sorted = companyService.sortCompanies(
        companies,
        field: SortField.teamSize,
        order: SortOrder.ascending,
      );

      // Verify the list is sorted by team size
      for (int i = 0; i < sorted.length - 1; i++) {
        expect(
          sorted[i].teamSize <= sorted[i + 1].teamSize,
          true,
          reason: 'Companies should be sorted by team size in ascending order',
        );
      }
    });

    test('Sort by team size descending', () {
      final companies = companyService.getAllCompanies();
      final sorted = companyService.sortCompanies(
        companies,
        field: SortField.teamSize,
        order: SortOrder.descending,
      );

      // Verify the list is sorted by team size in descending order
      for (int i = 0; i < sorted.length - 1; i++) {
        expect(
          sorted[i].teamSize >= sorted[i + 1].teamSize,
          true,
          reason: 'Companies should be sorted by team size in descending order',
        );
      }
    });
  });
}
