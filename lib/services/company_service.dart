import '../models/company.dart';
import '../data/mock_companies.dart';
import '../widgets/sort_bar.dart';
import 'dart:math';

class CompanyService {
  final List<Company> _companies = mockCompanies;
  final Map<String, dynamic> _filterState = {};

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

  List<Company> getRelatedCompanies(String companyId, {int limit = 3}) {
    final company = getCompanyById(companyId);
    if (company == null) return [];

    // Calculate similarity scores for all companies
    final scores = _companies
        .where((c) => c.id != companyId) // Exclude the current company
        .map((c) => _CompanySimilarity(
              company: c,
              score: _calculateSimilarityScore(company, c),
            ))
        .toList();

    // Sort by similarity score (descending)
    scores.sort((a, b) => b.score.compareTo(a.score));

    // Return top N companies
    return scores.take(limit).map((s) => s.company).toList();
  }

  double _calculateSimilarityScore(Company company1, Company company2) {
    double score = 0.0;
    double totalWeight = 0.0;

    // Category similarity (30% weight)
    const categoryWeight = 0.3;
    final categoryScore =
        _calculateCategorySimilarity(company1.category, company2.category);
    score += categoryScore * categoryWeight;
    totalWeight += categoryWeight;

    // Technology stack similarity (25% weight)
    const techWeight = 0.25;
    final techScore =
        _calculateTechStackSimilarity(company1.techStack, company2.techStack);
    score += techScore * techWeight;
    totalWeight += techWeight;

    // Business model similarity (20% weight)
    const modelWeight = 0.2;
    final modelScore =
        company1.businessModel == company2.businessModel ? 1.0 : 0.0;
    score += modelScore * modelWeight;
    totalWeight += modelWeight;

    // Team size similarity (15% weight)
    const teamWeight = 0.15;
    final teamScore =
        _calculateTeamSizeSimilarity(company1.teamSize, company2.teamSize);
    score += teamScore * teamWeight;
    totalWeight += teamWeight;

    // Revenue similarity (10% weight)
    const revenueWeight = 0.1;
    final revenueScore =
        _calculateRevenueSimilarity(company1.revenue.mrr, company2.revenue.mrr);
    score += revenueScore * revenueWeight;
    totalWeight += revenueWeight;

    // Normalize the score
    return score / totalWeight;
  }

  double _calculateCategorySimilarity(
      List<String> categories1, List<String> categories2) {
    if (categories1.isEmpty || categories2.isEmpty) return 0.0;

    final intersection =
        categories1.where((category) => categories2.contains(category)).length;
    final union = categories1.toSet().union(categories2.toSet()).length;

    return intersection / union;
  }

  double _calculateTechStackSimilarity(List<String> tech1, List<String> tech2) {
    if (tech1.isEmpty || tech2.isEmpty) return 0.0;

    final intersection = tech1.where((tech) => tech2.contains(tech)).length;
    final union = tech1.toSet().union(tech2.toSet()).length;

    return intersection / union;
  }

  double _calculateTeamSizeSimilarity(int size1, int size2) {
    final maxSize = max(size1, size2);
    if (maxSize == 0) return 0.0;

    final difference = (size1 - size2).abs();
    return 1.0 - (difference / maxSize);
  }

  double _calculateRevenueSimilarity(double revenue1, double revenue2) {
    final maxRevenue = max(revenue1, revenue2);
    if (maxRevenue == 0) return 0.0;

    final difference = (revenue1 - revenue2).abs();
    return 1.0 - (difference / maxRevenue);
  }

  List<String> getAllCategories() {
    return _companies.expand((company) => company.category).toSet().toList()
      ..sort();
  }

  List<String> getAllTechStacks() {
    return _companies.expand((company) => company.techStack).toSet().toList()
      ..sort();
  }

  List<String> getAllBusinessModels() {
    return _companies.map((company) => company.businessModel).toSet().toList()
      ..sort();
  }

  List<String> getAllIndustries() {
    return _companies.expand((company) => company.industry).toSet().toList()
      ..sort();
  }

  void saveFilterState(Map<String, dynamic> state) {
    _filterState.clear();
    _filterState.addAll(state);
  }

  Map<String, dynamic> getFilterState() {
    return Map.from(_filterState);
  }

  List<Company> filterCompanies(
    List<Company> companies, {
    List<String>? categories,
    List<String>? industries,
    List<String>? techStacks,
    List<String>? businessModels,
    DateTime? startDate,
    double? minRevenue,
    double? maxRevenue,
    int? minTeamSize,
    int? maxTeamSize,
  }) {
    return companies.where((company) {
      if (categories != null && categories.isNotEmpty) {
        if (!company.category.any((cat) => categories.contains(cat))) {
          return false;
        }
      }

      if (industries != null && industries.isNotEmpty) {
        if (!company.industry.any((ind) => industries.contains(ind))) {
          return false;
        }
      }

      if (techStacks != null && techStacks.isNotEmpty) {
        if (!company.techStack.any((tech) => techStacks.contains(tech))) {
          return false;
        }
      }

      if (businessModels != null && businessModels.isNotEmpty) {
        if (!businessModels.contains(company.businessModel)) {
          return false;
        }
      }

      if (startDate != null) {
        if (company.startDate.isBefore(startDate)) {
          return false;
        }
      }

      if (minRevenue != null) {
        if (company.revenue.arr < minRevenue) {
          return false;
        }
      }

      if (maxRevenue != null) {
        if (company.revenue.arr > maxRevenue) {
          return false;
        }
      }

      if (minTeamSize != null) {
        if (company.teamSize < minTeamSize) {
          return false;
        }
      }

      if (maxTeamSize != null) {
        if (company.teamSize > maxTeamSize) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  List<Company> sortCompanies(
    List<Company> companies, {
    required SortField sortField,
    required SortOrder sortOrder,
  }) {
    companies.sort((a, b) {
      int comparison;
      switch (sortField) {
        case SortField.date:
          comparison = a.startDate.compareTo(b.startDate);
          break;
        case SortField.revenue:
          comparison = a.revenue.arr.compareTo(b.revenue.arr);
          break;
        case SortField.teamSize:
          comparison = a.teamSize.compareTo(b.teamSize);
          break;
      }
      return sortOrder == SortOrder.ascending ? comparison : -comparison;
    });
    return companies;
  }
}

class _CompanySimilarity {
  final Company company;
  final double score;

  _CompanySimilarity({
    required this.company,
    required this.score,
  });
}
