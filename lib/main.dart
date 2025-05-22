import 'package:flutter/material.dart';
import 'services/company_service.dart';
import 'services/search_service.dart';
import 'widgets/company_grid.dart';
import 'widgets/company_details_dialog.dart';
import 'widgets/filter_bar.dart';
import 'widgets/sort_bar.dart';
import 'widgets/search_bar.dart';
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
  final SearchService _searchService = SearchService(CompanyService());
  String _searchQuery = '';
  List<String> _searchHistory = [];
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
  bool _isLoading = false;
  String? _error;

  List<String> get _categories {
    final allCategories = _companyService
        .getAllCompanies()
        .expand((company) => company.category)
        .toSet();
    return allCategories.toList()..sort();
  }

  List<String> get _techStacks => _companyService.getAllTechStacks();
  List<String> get _businessModels => _companyService.getAllBusinessModels();

  List<Company> get _filteredAndSortedCompanies {
    return _companyService.filterCompanies(
      categories: _selectedCategories,
      startDate: _startDate,
      minRevenue: _minRevenue,
      maxRevenue: _maxRevenue,
      minTeamSize: _minTeamSize,
      maxTeamSize: _maxTeamSize,
      techStacks: _selectedTechStacks,
      businessModels: _selectedBusinessModels,
    );
  }

  void _clearFilters() {
    setState(() {
      _searchQuery = '';
      _selectedCategories = [];
      _startDate = null;
      _minRevenue = null;
      _maxRevenue = null;
      _minTeamSize = null;
      _maxTeamSize = null;
      _selectedTechStacks = [];
      _selectedBusinessModels = [];
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

  void _loadCompanies() {
    // Implementation of _loadCompanies method
  }
}
