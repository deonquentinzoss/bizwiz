import '../models/company.dart';
import 'company_service.dart';

class SearchService {
  final CompanyService _companyService;
  final List<String> _searchHistory = [];
  static const int _maxHistoryItems = 10;

  // Cache for search results
  final Map<String, List<Company>> _searchCache = {};
  final Map<String, Map<String, dynamic>> _lastSearchParams = {};

  SearchService(this._companyService);

  List<String> get searchHistory => _searchHistory;

  void clearHistory() {
    _searchHistory.clear();
  }

  List<Company> search(
    String query, {
    List<String>? categories,
    List<String>? techStacks,
    List<String>? businessModels,
    List<String>? industries,
  }) {
    if (query.isEmpty) {
      return _companyService.getAllCompanies();
    }

    // Add to search history
    if (!_searchHistory.contains(query)) {
      _searchHistory.insert(0, query);
      if (_searchHistory.length > _maxHistoryItems) {
        _searchHistory.removeLast();
      }
    }

    final lowercaseQuery = query.toLowerCase();
    return _companyService.getAllCompanies().where((company) {
      // Basic search
      if (company.name.toLowerCase().contains(lowercaseQuery) ||
          company.elevatorPitch.toLowerCase().contains(lowercaseQuery) ||
          company.founder.name.toLowerCase().contains(lowercaseQuery)) {
        return true;
      }

      // Category search
      if (company.category
          .any((cat) => cat.toLowerCase().contains(lowercaseQuery))) {
        return true;
      }

      // Tech stack search
      if (company.techStack
          .any((tech) => tech.toLowerCase().contains(lowercaseQuery))) {
        return true;
      }

      // Business model search
      if (company.businessModel.toLowerCase().contains(lowercaseQuery)) {
        return true;
      }

      // Industry search
      if (company.industry
          .any((ind) => ind.toLowerCase().contains(lowercaseQuery))) {
        return true;
      }

      return false;
    }).toList();
  }

  bool _mapEquals(Map<String, dynamic>? map1, Map<String, dynamic>? map2) {
    if (map1 == null || map2 == null) return map1 == map2;
    if (map1.length != map2.length) return false;
    return map1.entries.every((entry) {
      final value2 = map2[entry.key];
      if (entry.value is List && value2 is List) {
        return _listEquals(entry.value, value2);
      }
      return entry.value == value2;
    });
  }

  bool _listEquals<T>(List<T> list1, List<T> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }
}
