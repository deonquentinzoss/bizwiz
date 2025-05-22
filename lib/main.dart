import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/company_service.dart';
import 'services/search_service.dart';
import 'services/favorites_service.dart';
import 'widgets/company_grid.dart';
import 'widgets/company_details_dialog.dart';
import 'widgets/filter_bar.dart';
import 'widgets/sort_bar.dart';
import 'models/company.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

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
      home: HomePage(prefs: prefs),
    );
  }
}

class HomePage extends StatefulWidget {
  final SharedPreferences prefs;

  const HomePage({super.key, required this.prefs});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final CompanyService _companyService;
  late final SearchService _searchService;
  late final FavoritesService _favoritesService;
  late List<Company> _companies;
  late List<Company> _filteredCompanies;
  String _searchQuery = '';
  List<String> _selectedCategories = [];
  List<String> _selectedTechStacks = [];
  List<String> _selectedBusinessModels = [];
  DateTime? _startDate;
  double? _minRevenue;
  double? _maxRevenue;
  int? _minTeamSize;
  int? _maxTeamSize;
  SortField _sortField = SortField.date;
  SortOrder _sortOrder = SortOrder.descending;
  List<String> _searchHistory = [];
  bool _showFavoritesOnly = false;

  // Cache for derived data
  List<String>? _cachedCategories;
  List<String>? _cachedTechStacks;
  List<String>? _cachedBusinessModels;
  List<Company>? _cachedFilteredCompanies;
  Map<String, dynamic>? _lastFilterState;

  @override
  void initState() {
    super.initState();
    _companyService = CompanyService();
    _searchService = SearchService(_companyService);
    _favoritesService = FavoritesService(widget.prefs);
    _companies = _companyService.getAllCompanies();
    _filteredCompanies = _companies;
    _loadSearchHistory();
  }

  void _loadSearchHistory() {
    setState(() {
      _searchHistory = _searchService.searchHistory;
    });
  }

  void _handleSearch(String query) {
    setState(() {
      _searchQuery = query;
      _updateFilteredCompanies();
    });
  }

  void _handleCategoriesChanged(List<String> categories) {
    setState(() {
      _selectedCategories = categories;
      _updateFilteredCompanies();
    });
  }

  void _handleTechStacksChanged(List<String> techStacks) {
    setState(() {
      _selectedTechStacks = techStacks;
      _updateFilteredCompanies();
    });
  }

  void _handleBusinessModelsChanged(List<String> businessModels) {
    setState(() {
      _selectedBusinessModels = businessModels;
      _updateFilteredCompanies();
    });
  }

  void _handleStartDateChanged(DateTime? date) {
    setState(() {
      _startDate = date;
      _updateFilteredCompanies();
    });
  }

  void _handleMinRevenueChanged(double? revenue) {
    setState(() {
      _minRevenue = revenue;
      _updateFilteredCompanies();
    });
  }

  void _handleMaxRevenueChanged(double? revenue) {
    setState(() {
      _maxRevenue = revenue;
      _updateFilteredCompanies();
    });
  }

  void _handleMinTeamSizeChanged(int? size) {
    setState(() {
      _minTeamSize = size;
      _updateFilteredCompanies();
    });
  }

  void _handleMaxTeamSizeChanged(int? size) {
    setState(() {
      _maxTeamSize = size;
      _updateFilteredCompanies();
    });
  }

  void _handleSortFieldChanged(SortField field) {
    setState(() {
      _sortField = field;
      _updateFilteredCompanies();
    });
  }

  void _handleSortOrderChanged(SortOrder order) {
    setState(() {
      _sortOrder = order;
      _updateFilteredCompanies();
    });
  }

  void _handleClearFilters() {
    setState(() {
      _selectedCategories = [];
      _selectedTechStacks = [];
      _selectedBusinessModels = [];
      _startDate = null;
      _minRevenue = null;
      _maxRevenue = null;
      _minTeamSize = null;
      _maxTeamSize = null;
      _updateFilteredCompanies();
    });
  }

  void _handleClearHistory() {
    setState(() {
      _searchService.clearHistory();
      _searchHistory = [];
    });
  }

  void _handleFavoriteToggle(String companyId) {
    setState(() {
      _favoritesService.toggleFavorite(companyId);
      _updateFilteredCompanies();
    });
  }

  void _handleShowFavoritesOnlyChanged(bool value) {
    setState(() {
      _showFavoritesOnly = value;
      _updateFilteredCompanies();
    });
  }

  void _updateFilteredCompanies() {
    var companies = _companies;

    // Apply search
    if (_searchQuery.isNotEmpty) {
      companies = _searchService.search(
        _searchQuery,
        categories: _selectedCategories,
        techStacks: _selectedTechStacks,
        businessModels: _selectedBusinessModels,
      );
    }

    // Apply filters
    companies = _companyService.filterCompanies(
      companies,
      categories: _selectedCategories,
      techStacks: _selectedTechStacks,
      businessModels: _selectedBusinessModels,
      startDate: _startDate,
      minRevenue: _minRevenue,
      maxRevenue: _maxRevenue,
      minTeamSize: _minTeamSize,
      maxTeamSize: _maxTeamSize,
    );

    // Apply favorites filter
    if (_showFavoritesOnly) {
      companies = _favoritesService.getFavoriteCompanies(companies);
    }

    // Apply sorting
    companies = _companyService.sortCompanies(
      companies,
      sortField: _sortField,
      sortOrder: _sortOrder,
    );

    setState(() {
      _filteredCompanies = companies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    'BizWiz',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilterBar(
                      categories: _companyService.getAllCategories(),
                      techStacks: _companyService.getAllTechStacks(),
                      businessModels: _companyService.getAllBusinessModels(),
                      selectedCategories: _selectedCategories,
                      selectedTechStacks: _selectedTechStacks,
                      selectedBusinessModels: _selectedBusinessModels,
                      startDate: _startDate,
                      minRevenue: _minRevenue,
                      maxRevenue: _maxRevenue,
                      minTeamSize: _minTeamSize,
                      maxTeamSize: _maxTeamSize,
                      onCategoriesChanged: _handleCategoriesChanged,
                      onTechStacksChanged: _handleTechStacksChanged,
                      onBusinessModelsChanged: _handleBusinessModelsChanged,
                      onStartDateChanged: _handleStartDateChanged,
                      onMinRevenueChanged: _handleMinRevenueChanged,
                      onMaxRevenueChanged: _handleMaxRevenueChanged,
                      onMinTeamSizeChanged: _handleMinTeamSizeChanged,
                      onMaxTeamSizeChanged: _handleMaxTeamSizeChanged,
                      onClearFilters: _handleClearFilters,
                      onSearch: _handleSearch,
                      searchHistory: _searchHistory,
                      onClearHistory: _handleClearHistory,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: SortBar(
                      sortField: _sortField,
                      sortOrder: _sortOrder,
                      onSortFieldChanged: _handleSortFieldChanged,
                      onSortOrderChanged: _handleSortOrderChanged,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Switch(
                    value: _showFavoritesOnly,
                    onChanged: _handleShowFavoritesOnlyChanged,
                  ),
                  const Text('Favorites Only'),
                ],
              ),
            ),
            Expanded(
              child: CompanyGrid(
                companies: _filteredCompanies,
                onCompanyTap: (company) {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        CompanyDetailsDialog(company: company),
                  );
                },
                isFavorite: (company) =>
                    _favoritesService.isFavorite(company.id),
                onFavoriteToggle: _handleFavoriteToggle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
