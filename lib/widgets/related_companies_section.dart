import 'package:flutter/material.dart';
import '../models/company.dart';
import 'company_card.dart';

class RelatedCompaniesSection extends StatelessWidget {
  final List<Company> companies;
  final Function(Company) onCompanyTap;

  const RelatedCompaniesSection({
    super.key,
    required this.companies,
    required this.onCompanyTap,
  });

  @override
  Widget build(BuildContext context) {
    if (companies.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Related Companies',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.4,
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: companies.length,
            itemBuilder: (context, index) {
              final company = companies[index];
              return Padding(
                padding: EdgeInsets.only(
                  right: 16,
                  left: index == 0 ? 0 : 0,
                ),
                child: SizedBox(
                  width: 300,
                  child: Card(
                    child: InkWell(
                      onTap: () => onCompanyTap(company),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Company Logo
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                company.logo,
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 120,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceVariant,
                                    child: Center(
                                      child: Icon(
                                        Icons.business,
                                        size: 48,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Company Name
                            Text(
                              company.name,
                              style: Theme.of(context).textTheme.titleMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            // Category
                            Wrap(
                              spacing: 8,
                              children: company.category.map((category) {
                                return Chip(
                                  label: Text(category),
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  labelStyle: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 8),
                            // Elevator Pitch
                            Text(
                              company.elevatorPitch,
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
