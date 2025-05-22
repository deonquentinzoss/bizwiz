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

  List<Company> search(
    String query, {
    String? category,
    List<String>? techStacks,
    String? businessModel,
  }) {
    if (query.isEmpty) return [];

    // Add to search history
    _addToHistory(query);

    // Create search parameters map
    final searchParams = {
      'query': query,
      'category': category,
      'techStacks': techStacks,
      'businessModel': businessModel,
    };

    // Check cache
    final cacheKey = query.toLowerCase();
    if (_searchCache.containsKey(cacheKey) &&
        _mapEquals(_lastSearchParams[cacheKey], searchParams)) {
      return _searchCache[cacheKey]!;
    }

    // Get all companies
    var results = _companyService.getAllCompanies();

    // Apply search query
    final lowercaseQuery = query.toLowerCase();
    results = results.where((company) {
      // Check name first (most common search)
      if (company.name.toLowerCase().contains(lowercaseQuery)) {
        return true;
      }

      // Check other fields only if name doesn't match
      return company.elevatorPitch.toLowerCase().contains(lowercaseQuery) ||
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
      final techStackSet = techStacks.toSet();
      results = results
          .where((company) =>
              techStackSet.every((tech) => company.techStack.contains(tech)))
          .toList();
    }
    if (businessModel != null) {
      results = results
          .where((company) => company.businessModel == businessModel)
          .toList();
    }

    // Update cache
    _searchCache[cacheKey] = results;
    _lastSearchParams[cacheKey] = searchParams;

    return results;
  }

  void _addToHistory(String query) {
    if (query.isNotEmpty && !_searchHistory.contains(query)) {
      _searchHistory.insert(0, query);
      if (_searchHistory.length > _maxHistoryItems) {
        _searchHistory.removeLast();
      }
    }
  }

  List<String> getSearchHistory() {
    return List.from(_searchHistory);
  }

  void clearSearchHistory() {
    _searchHistory.clear();
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
