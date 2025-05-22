import 'package:flutter/material.dart';
import 'services/company_service.dart';
import 'widgets/company_grid.dart';
import 'widgets/company_details_dialog.dart';
import 'widgets/filter_bar.dart';
import 'widgets/sort_bar.dart';
import 'models/company.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BizWiz',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CompanyService _companyService = CompanyService();
  final List<String> _searchHistory = [];
  String? _searchQuery;
  List<String> _selectedCategories = [];
  DateTime? _startDate;
  double? _minRevenue;
  double? _maxRevenue;
  int? _minTeamSize;
  int? _maxTeamSize;
  List<String> _selectedTechStacks = [];
  List<String> _selectedBusinessModels = [];
  SortField? _sortField;
  SortOrder _sortOrder = SortOrder.ascending;
  String? _error;

  // Cache for derived data
  List<String>? _cachedCategories;
  List<String>? _cachedTechStacks;
  List<String>? _cachedBusinessModels;
  List<Company>? _cachedFilteredCompanies;
  Map<String, dynamic>? _lastFilterState;

  List<String> get _categories {
    _cachedCategories ??= _companyService
        .getAllCompanies()
        .expand((company) => company.category)
        .toSet()
        .toList()
      ..sort();
    return _cachedCategories!;
  }

  List<String> get _techStacks {
    _cachedTechStacks ??= _companyService.getAllTechStacks();
    return _cachedTechStacks!;
  }

  List<String> get _businessModels {
    _cachedBusinessModels ??= _companyService.getAllBusinessModels();
    return _cachedBusinessModels!;
  }

  bool _listEquals<T>(List<T> list1, List<T> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }

  bool _mapEquals(Map<String, dynamic> map1, Map<String, dynamic> map2) {
    if (map1.length != map2.length) return false;
    return map1.entries.every((entry) {
      final value2 = map2[entry.key];
      if (entry.value is List && value2 is List) {
        return _listEquals(entry.value, value2);
      }
      return entry.value == value2;
    });
  }

  List<Company> get _filteredAndSortedCompanies {
    // Check if filters have changed
    final currentFilterState = {
      'searchQuery': _searchQuery,
      'categories': _selectedCategories,
      'startDate': _startDate,
      'minRevenue': _minRevenue,
      'maxRevenue': _maxRevenue,
      'minTeamSize': _minTeamSize,
      'maxTeamSize': _maxTeamSize,
      'techStacks': _selectedTechStacks,
      'businessModels': _selectedBusinessModels,
      'sortField': _sortField,
      'sortOrder': _sortOrder,
    };

    // If filters haven't changed, return cached result
    if (_lastFilterState != null &&
        _mapEquals(_lastFilterState!, currentFilterState)) {
      return _cachedFilteredCompanies!;
    }

    // Update cache
    _lastFilterState = currentFilterState;
    var companies = _companyService.filterCompanies(
      categories: _selectedCategories,
      startDate: _startDate,
      minRevenue: _minRevenue,
      maxRevenue: _maxRevenue,
      minTeamSize: _minTeamSize,
      maxTeamSize: _maxTeamSize,
      techStacks: _selectedTechStacks,
      businessModels: _selectedBusinessModels,
    );

    // Apply search filter if query exists
    if (_searchQuery != null && _searchQuery!.isNotEmpty) {
      final query = _searchQuery!.toLowerCase();
      companies = companies.where((company) {
        return company.name.toLowerCase().contains(query) ||
            company.elevatorPitch.toLowerCase().contains(query) ||
            company.category.any((cat) => cat.toLowerCase().contains(query)) ||
            company.techStack
                .any((tech) => tech.toLowerCase().contains(query)) ||
            company.businessModel.toLowerCase().contains(query) ||
            company.founder.name.toLowerCase().contains(query);
      }).toList();
    } else if (_searchQuery != null) {
      // If search query is empty string, show all companies
      companies = _companyService.getAllCompanies();
    }

    // Apply sorting if a sort field is selected
    if (_sortField != null) {
      companies.sort((a, b) {
        int comparison;
        switch (_sortField) {
          case SortField.date:
            comparison = a.startDate.compareTo(b.startDate);
            break;
          case SortField.revenue:
            comparison = a.revenue.arr.compareTo(b.revenue.arr);
            break;
          case SortField.teamSize:
            comparison = a.teamSize.compareTo(b.teamSize);
            break;
          default:
            comparison = 0;
        }
        return _sortOrder == SortOrder.ascending ? comparison : -comparison;
      });
    }

    _cachedFilteredCompanies = companies;
    return companies;
  }

  void _clearFilters() {
    setState(() {
      _searchQuery = null;
      _selectedCategories = [];
      _startDate = null;
      _minRevenue = null;
      _maxRevenue = null;
      _minTeamSize = null;
      _maxTeamSize = null;
      _selectedTechStacks = [];
      _selectedBusinessModels = [];
      // Clear caches
      _cachedFilteredCompanies = null;
      _lastFilterState = null;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCompanies();
  }

  void _loadCompanies() {
    setState(() {
      _error = null;
      // Clear caches when reloading
      _cachedCategories = null;
      _cachedTechStacks = null;
      _cachedBusinessModels = null;
      _cachedFilteredCompanies = null;
      _lastFilterState = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BizWiz'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadCompanies,
          ),
        ],
      ),
      body: _error != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_error!),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadCompanies,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                FilterBar(
                  categories: _categories,
                  techStacks: _techStacks,
                  businessModels: _businessModels,
                  selectedCategories: _selectedCategories,
                  startDate: _startDate,
                  minRevenue: _minRevenue,
                  maxRevenue: _maxRevenue,
                  minTeamSize: _minTeamSize,
                  maxTeamSize: _maxTeamSize,
                  selectedTechStacks: _selectedTechStacks,
                  selectedBusinessModels: _selectedBusinessModels,
                  onCategoriesChanged: (categories) {
                    setState(() {
                      _selectedCategories = categories;
                    });
                  },
                  onStartDateChanged: (date) {
                    setState(() {
                      _startDate = date;
                    });
                  },
                  onMinRevenueChanged: (revenue) {
                    setState(() {
                      _minRevenue = revenue;
                    });
                  },
                  onMaxRevenueChanged: (revenue) {
                    setState(() {
                      _maxRevenue = revenue;
                    });
                  },
                  onMinTeamSizeChanged: (size) {
                    setState(() {
                      _minTeamSize = size;
                    });
                  },
                  onMaxTeamSizeChanged: (size) {
                    setState(() {
                      _maxTeamSize = size;
                    });
                  },
                  onTechStacksChanged: (stacks) {
                    setState(() {
                      _selectedTechStacks = stacks;
                    });
                  },
                  onBusinessModelsChanged: (models) {
                    setState(() {
                      _selectedBusinessModels = models;
                    });
                  },
                  onClearFilters: _clearFilters,
                  onSearch: (query) {
                    setState(() {
                      _searchQuery = query;
                      if (query.isNotEmpty && !_searchHistory.contains(query)) {
                        _searchHistory.add(query);
                      }
                    });
                  },
                  searchHistory: _searchHistory,
                  onClearHistory: () {
                    setState(() {
                      _searchHistory.clear();
                    });
                  },
                ),
                SortBar(
                  selectedField: _sortField,
                  sortOrder: _sortOrder,
                  onFieldChanged: (field) => setState(() => _sortField = field),
                  onOrderChanged: (order) => setState(() => _sortOrder = order),
                ),
                Expanded(
                  child: CompanyGrid(
                    companies: _filteredAndSortedCompanies,
                    onCompanyTap: (company) {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            CompanyDetailsDialog(company: company),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
