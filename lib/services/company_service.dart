import '../models/company.dart';
import '../data/mock_companies.dart';
import '../widgets/sort_bar.dart';

class CompanyService {
  List<Company> _companies = [];

  CompanyService() {
    _companies = List.from(mockCompanies);
  }

  List<Company> getAllCompanies() {
    return _companies;
  }

  Company? getCompanyById(String id) {
    try {
      return _companies.firstWhere((company) => company.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Company> getRelatedCompanies(String companyId) {
    final company = getCompanyById(companyId);
    if (company == null) return [];

    return company.relatedCompanies
        .map((id) => getCompanyById(id))
        .whereType<Company>()
        .toList();
  }

  List<Company> filterCompanies({
    String? category,
    DateTime? startDate,
    DateTime? endDate,
    double? minRevenue,
    double? maxRevenue,
    int? minTeamSize,
    int? maxTeamSize,
    String? techStack,
  }) {
    return _companies.where((company) {
      if (category != null && !company.category.contains(category)) {
        return false;
      }
      if (startDate != null && company.startDate.isBefore(startDate)) {
        return false;
      }
      if (endDate != null && company.startDate.isAfter(endDate)) {
        return false;
      }
      if (minRevenue != null && company.revenue.mrr < minRevenue) {
        return false;
      }
      if (maxRevenue != null && company.revenue.mrr > maxRevenue) {
        return false;
      }
      if (minTeamSize != null && company.teamSize < minTeamSize) {
        return false;
      }
      if (maxTeamSize != null && company.teamSize > maxTeamSize) {
        return false;
      }
      if (techStack != null && !company.techStack.contains(techStack)) {
        return false;
      }
      return true;
    }).toList();
  }

  List<Company> sortCompanies(
    List<Company> companies, {
    required SortField field,
    required SortOrder order,
  }) {
    final sorted = List<Company>.from(companies);
    sorted.sort((a, b) {
      int comparison;
      switch (field) {
        case SortField.date:
          comparison = a.startDate.compareTo(b.startDate);
          break;
        case SortField.revenue:
          comparison = a.revenue.mrr.compareTo(b.revenue.mrr);
          break;
        case SortField.teamSize:
          comparison = a.teamSize.compareTo(b.teamSize);
          break;
      }
      return order == SortOrder.ascending ? comparison : -comparison;
    });
    return sorted;
  }
}
