import '../models/company.dart';
import 'company_service.dart';

class SearchService {
  final CompanyService _companyService;
  final List<String> _searchHistory = [];
  static const int _maxHistoryItems = 10;

  SearchService(this._companyService);

  List<Company> search(
    String query, {
    String? category,
    List<String>? techStacks,
    String? businessModel,
  }) {
    if (query.isEmpty) return [];

    // Add to search history
    _addToHistory(query);

    // Get all companies
    var results = _companyService.getAllCompanies();

    // Apply search query
    final lowercaseQuery = query.toLowerCase();
    results = results.where((company) {
      return company.name.toLowerCase().contains(lowercaseQuery) ||
          company.elevatorPitch.toLowerCase().contains(lowercaseQuery) ||
          company.category
              .any((cat) => cat.toLowerCase().contains(lowercaseQuery)) ||
          company.techStack
              .any((tech) => tech.toLowerCase().contains(lowercaseQuery)) ||
          company.businessModel.toLowerCase().contains(lowercaseQuery) ||
          company.founder.name.toLowerCase().contains(lowercaseQuery);
    }).toList();

    // Apply filters if provided
    if (category != null) {
      results = results
          .where((company) => company.category.contains(category))
          .toList();
    }
    if (techStacks != null && techStacks.isNotEmpty) {
      results = results
          .where((company) =>
              techStacks.every((tech) => company.techStack.contains(tech)))
          .toList();
    }
    if (businessModel != null) {
      results = results
          .where((company) => company.businessModel == businessModel)
          .toList();
    }

    return results;
  }

  void _addToHistory(String query) {
    // Remove if already exists
    _searchHistory.remove(query);
    // Add to beginning of list
    _searchHistory.insert(0, query);
    // Keep only last N items
    if (_searchHistory.length > _maxHistoryItems) {
      _searchHistory.removeLast();
    }
  }

  List<String> getSearchHistory() {
    return List.from(_searchHistory);
  }

  void clearSearchHistory() {
    _searchHistory.clear();
  }
}
