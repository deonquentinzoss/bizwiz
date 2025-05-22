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
  final _companyService = CompanyService();
  final _searchService = SearchService(CompanyService());
  String? _selectedCategory;
  DateTime? _startDate;
  DateTime? _endDate;
  double? _minRevenue;
  double? _maxRevenue;
  int? _minTeamSize;
  int? _maxTeamSize;
  List<String> _selectedTechStacks = [];
  String? _selectedBusinessModel;
  SortField? _sortField;
  SortOrder _sortOrder = SortOrder.ascending;
  String _searchQuery = '';
  List<Company> _searchResults = [];

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
    var companies = _searchQuery.isNotEmpty
        ? _searchResults
        : _companyService.filterCompanies(
            category: _selectedCategory,
            startDate: _startDate,
            endDate: _endDate,
            minRevenue: _minRevenue,
            maxRevenue: _maxRevenue,
            minTeamSize: _minTeamSize,
            maxTeamSize: _maxTeamSize,
            techStacks:
                _selectedTechStacks.isNotEmpty ? _selectedTechStacks : null,
            businessModel: _selectedBusinessModel,
          );

    if (_sortField != null) {
      companies = _companyService.sortCompanies(
        companies,
        field: _sortField!,
        order: _sortOrder,
      );
    }

    return companies;
  }

  void _handleSearch(String query) {
    setState(() {
      _searchQuery = query;
      _searchResults = _searchService.search(
        query,
        category: _selectedCategory,
        techStacks: _selectedTechStacks.isNotEmpty ? _selectedTechStacks : null,
        businessModel: _selectedBusinessModel,
      );
    });
  }

  void _clearFilters() {
    setState(() {
      _selectedCategory = null;
      _startDate = null;
      _endDate = null;
      _minRevenue = null;
      _maxRevenue = null;
      _minTeamSize = null;
      _maxTeamSize = null;
      _selectedTechStacks = [];
      _selectedBusinessModel = null;
      _sortField = null;
      _sortOrder = SortOrder.ascending;
      _searchQuery = '';
      _searchResults = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BizWiz'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          CustomSearchBar(
            onSearch: _handleSearch,
            searchHistory: _searchService.getSearchHistory(),
            onClearHistory: () {
              setState(() {
                _searchService.clearSearchHistory();
              });
            },
          ),
          FilterBar(
            categories: _categories,
            techStacks: _techStacks,
            businessModels: _businessModels,
            selectedCategory: _selectedCategory,
            startDate: _startDate,
            endDate: _endDate,
            minRevenue: _minRevenue,
            maxRevenue: _maxRevenue,
            minTeamSize: _minTeamSize,
            maxTeamSize: _maxTeamSize,
            selectedTechStacks: _selectedTechStacks,
            selectedBusinessModel: _selectedBusinessModel,
            onCategoryChanged: (category) =>
                setState(() => _selectedCategory = category),
            onStartDateChanged: (date) => setState(() => _startDate = date),
            onEndDateChanged: (date) => setState(() => _endDate = date),
            onMinRevenueChanged: (revenue) =>
                setState(() => _minRevenue = revenue),
            onMaxRevenueChanged: (revenue) =>
                setState(() => _maxRevenue = revenue),
            onMinTeamSizeChanged: (size) => setState(() => _minTeamSize = size),
            onMaxTeamSizeChanged: (size) => setState(() => _maxTeamSize = size),
            onTechStacksChanged: (stacks) =>
                setState(() => _selectedTechStacks = stacks),
            onBusinessModelChanged: (model) =>
                setState(() => _selectedBusinessModel = model),
            onClearFilters: _clearFilters,
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
                  builder: (context) => CompanyDetailsDialog(company: company),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
