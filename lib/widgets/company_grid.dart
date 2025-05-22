import 'package:flutter/material.dart';
import '../models/company.dart';
import 'company_card.dart';

class CompanyGrid extends StatelessWidget {
  final List<Company> companies;
  final Function(Company) onCompanyTap;
  final bool Function(Company)? isFavorite;
  final Function(Company)? onFavoriteToggle;
  final List<String>? selectedCategories;
  final List<String>? selectedTechStacks;
  final List<String>? selectedBusinessModels;
  final List<String>? selectedIndustries;

  const CompanyGrid({
    super.key,
    required this.companies,
    required this.onCompanyTap,
    this.isFavorite,
    this.onFavoriteToggle,
    this.selectedCategories,
    this.selectedTechStacks,
    this.selectedBusinessModels,
    this.selectedIndustries,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1200;

    // Calculate number of columns based on screen width
    int crossAxisCount;
    if (isMobile) {
      crossAxisCount = 1;
    } else if (isTablet) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 3;
    }

    // Calculate child aspect ratio based on screen size
    final childAspectRatio = isMobile ? 0.85 : 0.75;

    return GridView.builder(
      padding: EdgeInsets.all(isMobile ? 8 : 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: isMobile ? 8 : 16,
        mainAxisSpacing: isMobile ? 8 : 16,
      ),
      itemCount: companies.length,
      itemBuilder: (context, index) {
        final company = companies[index];
        return CompanyCard(
          company: company,
          onTap: () => onCompanyTap(company),
          isFavorite: isFavorite != null ? isFavorite!(company) : false,
          onFavoriteToggle: () =>
              onFavoriteToggle != null ? onFavoriteToggle!(company) : () {},
        );
      },
    );
  }
}
