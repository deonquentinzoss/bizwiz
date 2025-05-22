import 'package:flutter/material.dart';
import '../models/company.dart';
import 'package:intl/intl.dart';
import '../utils/animations.dart';

class CompanyCard extends StatelessWidget {
  final Company company;
  final VoidCallback onTap;
  final bool isLoading;

  const CompanyCard({
    super.key,
    required this.company,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currencyFormat = NumberFormat.compactCurrency(symbol: '\$');

    return Animations.fadeSlideIn(
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: isLoading ? null : onTap,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company Logo
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      company.logo,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: theme.colorScheme.surfaceContainerHighest,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: theme.colorScheme.surfaceContainerHighest,
                          child: Center(
                            child: Icon(
                              Icons.business,
                              size: 48,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Company Name
                        Text(
                          company.name,
                          style: theme.textTheme.titleLarge,
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
                              backgroundColor:
                                  theme.colorScheme.primaryContainer,
                              labelStyle: TextStyle(
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 8),
                        // Elevator Pitch
                        Text(
                          company.elevatorPitch,
                          style: theme.textTheme.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 16),
                        // Key Metrics
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildMetric(
                              context,
                              'MRR',
                              currencyFormat.format(company.revenue.mrr),
                            ),
                            _buildMetric(
                              context,
                              'Team',
                              '${company.teamSize}',
                            ),
                            _buildMetric(
                              context,
                              'Founded',
                              DateFormat.yMMM().format(company.startDate),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (isLoading)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetric(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
