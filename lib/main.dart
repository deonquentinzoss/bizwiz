import 'package:flutter/material.dart';
import 'services/company_service.dart';
import 'widgets/company_grid.dart';
import 'widgets/company_details_dialog.dart';
import 'widgets/filter_bar.dart';
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
  String? _selectedCategory;
  DateTime? _startDate;
  DateTime? _endDate;
  double? _minRevenue;
  double? _maxRevenue;
  int? _minTeamSize;
  int? _maxTeamSize;

  List<String> get _categories {
    final allCategories = _companyService
        .getAllCompanies()
        .expand((company) => company.category)
        .toSet();
    return allCategories.toList()..sort();
  }

  List<Company> get _filteredCompanies {
    return _companyService.filterCompanies(
      category: _selectedCategory,
      startDate: _startDate,
      endDate: _endDate,
      minRevenue: _minRevenue,
      maxRevenue: _maxRevenue,
      minTeamSize: _minTeamSize,
      maxTeamSize: _maxTeamSize,
    );
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
          FilterBar(
            categories: _categories,
            selectedCategory: _selectedCategory,
            startDate: _startDate,
            endDate: _endDate,
            minRevenue: _minRevenue,
            maxRevenue: _maxRevenue,
            minTeamSize: _minTeamSize,
            maxTeamSize: _maxTeamSize,
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
            onClearFilters: _clearFilters,
          ),
          Expanded(
            child: CompanyGrid(
              companies: _filteredCompanies,
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
