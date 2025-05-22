import 'package:flutter/material.dart';
import '../models/company.dart';
import 'company_card.dart';

class CompanyGrid extends StatelessWidget {
  final List<Company> companies;
  final Function(Company) onCompanyTap;

  const CompanyGrid({
    super.key,
    required this.companies,
    required this.onCompanyTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate the number of columns based on the available width
        final width = constraints.maxWidth;
        final crossAxisCount = (width / 400).floor().clamp(1, 4);

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 0.75,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: companies.length,
          itemBuilder: (context, index) {
            final company = companies[index];
            return CompanyCard(
              company: company,
              onTap: () => onCompanyTap(company),
            );
          },
        );
      },
    );
  }
}
