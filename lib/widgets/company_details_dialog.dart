import 'package:flutter/material.dart';
import '../models/company.dart';
import 'package:intl/intl.dart';

class CompanyDetailsDialog extends StatelessWidget {
  final Company company;

  const CompanyDetailsDialog({
    super.key,
    required this.company,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currencyFormat = NumberFormat.compactCurrency(symbol: '\$');

    return Dialog(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with close button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      company.name,
                      style: theme.textTheme.headlineSmall,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // Scrollable content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Company Logo
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        company.logo,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 200,
                            color: theme.colorScheme.surfaceVariant,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            color: theme.colorScheme.surfaceVariant,
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
                    const SizedBox(height: 24),
                    // Categories
                    Wrap(
                      spacing: 8,
                      children: company.category.map((category) {
                        return Chip(
                          label: Text(category),
                          backgroundColor: theme.colorScheme.primaryContainer,
                          labelStyle: TextStyle(
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    // Elevator Pitch
                    Text(
                      company.elevatorPitch,
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 24),
                    // Key Metrics
                    _buildMetricsSection(context, company, currencyFormat),
                    const SizedBox(height: 24),
                    // Founder Info
                    _buildFounderSection(context, company),
                    const SizedBox(height: 24),
                    // Company History
                    _buildSection(
                      context,
                      'Company History',
                      company.companyHistory,
                    ),
                    const SizedBox(height: 24),
                    // Tech Stack
                    _buildSection(
                      context,
                      'Technology Stack',
                      company.techStack.join(', '),
                    ),
                    const SizedBox(height: 24),
                    // Business Model
                    _buildSection(
                      context,
                      'Business Model',
                      company.businessModel,
                    ),
                    const SizedBox(height: 24),
                    // Marketing Strategies
                    _buildSection(
                      context,
                      'Marketing Strategies',
                      company.marketingStrategies.join(', '),
                    ),
                    const SizedBox(height: 24),
                    // Milestones
                    _buildMilestonesSection(context, company),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsSection(
    BuildContext context,
    Company company,
    NumberFormat currencyFormat,
  ) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Metrics',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMetric(
              context,
              'MRR',
              currencyFormat.format(company.revenue.mrr),
            ),
            _buildMetric(
              context,
              'ARR',
              currencyFormat.format(company.revenue.arr),
            ),
            _buildMetric(
              context,
              'Team Size',
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
    );
  }

  Widget _buildFounderSection(BuildContext context, Company company) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Founder',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Text(
          company.founder.name,
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          company.founder.bio,
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            if (company.founder.socialLinks.twitter != null)
              _buildSocialLink(
                context,
                Icons.alternate_email,
                company.founder.socialLinks.twitter!,
              ),
            if (company.founder.socialLinks.linkedin != null)
              _buildSocialLink(
                context,
                Icons.work,
                company.founder.socialLinks.linkedin!,
              ),
            if (company.founder.socialLinks.github != null)
              _buildSocialLink(
                context,
                Icons.code,
                company.founder.socialLinks.github!,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildMilestonesSection(BuildContext context, Company company) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Milestones',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ...company.milestones.map((milestone) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      DateFormat.yMMM().format(milestone.date),
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      label: Text(milestone.type.toString().split('.').last),
                      backgroundColor: theme.colorScheme.secondaryContainer,
                      labelStyle: TextStyle(
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  milestone.title,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  milestone.description,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: theme.textTheme.bodyMedium,
        ),
      ],
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
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLink(BuildContext context, IconData icon, String url) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: IconButton(
        icon: Icon(icon),
        onPressed: () {
          // TODO: Implement URL launcher
        },
      ),
    );
  }
}
