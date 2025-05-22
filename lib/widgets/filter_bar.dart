import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'search_bar.dart';

class FilterBar extends StatelessWidget {
  final List<String> categories;
  final List<String> techStacks;
  final List<String> businessModels;
  final List<String> selectedCategories;
  final DateTime? startDate;
  final double? minRevenue;
  final double? maxRevenue;
  final int? minTeamSize;
  final int? maxTeamSize;
  final List<String> selectedTechStacks;
  final List<String> selectedBusinessModels;
  final Function(List<String>) onCategoriesChanged;
  final Function(DateTime?) onStartDateChanged;
  final Function(double?) onMinRevenueChanged;
  final Function(double?) onMaxRevenueChanged;
  final Function(int?) onMinTeamSizeChanged;
  final Function(int?) onMaxTeamSizeChanged;
  final Function(List<String>) onTechStacksChanged;
  final Function(List<String>) onBusinessModelsChanged;
  final VoidCallback onClearFilters;
  final Function(String) onSearch;
  final List<String> searchHistory;
  final VoidCallback onClearHistory;

  const FilterBar({
    super.key,
    required this.categories,
    required this.techStacks,
    required this.businessModels,
    this.selectedCategories = const [],
    this.startDate,
    this.minRevenue,
    this.maxRevenue,
    this.minTeamSize,
    this.maxTeamSize,
    this.selectedTechStacks = const [],
    this.selectedBusinessModels = const [],
    required this.onCategoriesChanged,
    required this.onStartDateChanged,
    required this.onMinRevenueChanged,
    required this.onMaxRevenueChanged,
    required this.onMinTeamSizeChanged,
    required this.onMaxTeamSizeChanged,
    required this.onTechStacksChanged,
    required this.onBusinessModelsChanged,
    required this.onClearFilters,
    required this.onSearch,
    required this.searchHistory,
    required this.onClearHistory,
  });

  static final List<RevenueRange> revenueRanges = [
    const RevenueRange('Any Revenue', null, null),
    const RevenueRange('<\$100K', null, 100000.0),
    const RevenueRange('>\$100K', 100000.0, null),
    const RevenueRange('>\$500K', 500000.0, null),
    const RevenueRange('>\$1M', 1000000.0, null),
    const RevenueRange('>\$5M', 5000000.0, null),
    const RevenueRange('>\$10M', 10000000.0, null),
    const RevenueRange('>\$50M', 50000000.0, null),
    const RevenueRange('>\$100M', 100000000.0, null),
  ];

  static final List<TeamSizeRange> teamSizeRanges = [
    const TeamSizeRange('Any Size', null, null),
    const TeamSizeRange('1-10', 1, 10),
    const TeamSizeRange('11-50', 11, 50),
    const TeamSizeRange('51-200', 51, 200),
    const TeamSizeRange('201-500', 201, 500),
    const TeamSizeRange('501-1000', 501, 1000),
    const TeamSizeRange('1000+', 1001, null),
  ];

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    final currencyFormat = NumberFormat.compactCurrency(symbol: '\$');

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      // Basic Filters
                      _buildBasicFilters(context, currencyFormat),
                      // Clear All Button
                      TextButton.icon(
                        onPressed: onClearFilters,
                        icon: const Icon(Icons.clear_all),
                        label: const Text('Clear All'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Search Bar
                SizedBox(
                  width: 300,
                  child: CustomSearchBar(
                    onSearch: onSearch,
                    searchHistory: searchHistory,
                    onClearHistory: onClearHistory,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Advanced Filters
            _buildAdvancedFilters(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicFilters(BuildContext context, NumberFormat currencyFormat) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        // Category Filter
        SizedBox(
          width: 200,
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            decoration: const InputDecoration(
              labelText: 'Categories',
              border: UnderlineInputBorder(),
            ),
            hint: const Text('Select Categories'),
            value: null,
            items: categories.map((category) {
              final isSelected = selectedCategories.contains(category);
              return DropdownMenuItem<String>(
                value: category,
                child: Row(
                  children: [
                    if (isSelected)
                      const Icon(Icons.check, size: 20)
                    else
                      const SizedBox(width: 20),
                    const SizedBox(width: 8),
                    Expanded(child: Text(category)),
                  ],
                ),
              );
            }).toList(),
            onChanged: (category) {
              if (category != null) {
                final newSelection = List<String>.from(selectedCategories);
                if (newSelection.contains(category)) {
                  newSelection.remove(category);
                } else {
                  newSelection.add(category);
                }
                onCategoriesChanged(newSelection);
              }
            },
            selectedItemBuilder: (context) {
              return [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text(
                    selectedCategories.isEmpty
                        ? 'Select Categories'
                        : '${selectedCategories.length} Selected',
                  ),
                ),
              ];
            },
          ),
        ),
        // Business Model Filter
        SizedBox(
          width: 250,
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            decoration: const InputDecoration(
              labelText: 'Business Models',
              border: UnderlineInputBorder(),
            ),
            hint: const Text('Select Business Models'),
            value: null,
            items: businessModels.map((model) {
              final isSelected = selectedBusinessModels.contains(model);
              return DropdownMenuItem<String>(
                value: model,
                child: Row(
                  children: [
                    if (isSelected)
                      const Icon(Icons.check, size: 20)
                    else
                      const SizedBox(width: 20),
                    const SizedBox(width: 8),
                    Expanded(child: Text(model)),
                  ],
                ),
              );
            }).toList(),
            onChanged: (model) {
              if (model != null) {
                final newSelection = List<String>.from(selectedBusinessModels);
                if (newSelection.contains(model)) {
                  newSelection.remove(model);
                } else {
                  newSelection.add(model);
                }
                onBusinessModelsChanged(newSelection);
              }
            },
            selectedItemBuilder: (context) {
              return [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text(
                    selectedBusinessModels.isEmpty
                        ? 'Select Business Models'
                        : '${selectedBusinessModels.length} Selected',
                  ),
                ),
              ];
            },
          ),
        ),
        // Technology Stack Filter
        SizedBox(
          width: 200,
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            decoration: const InputDecoration(
              labelText: 'Technologies',
              border: UnderlineInputBorder(),
            ),
            hint: const Text('Select Technologies'),
            value: null,
            items: techStacks.map((tech) {
              final isSelected = selectedTechStacks.contains(tech);
              return DropdownMenuItem<String>(
                value: tech,
                child: Row(
                  children: [
                    if (isSelected)
                      const Icon(Icons.check, size: 20)
                    else
                      const SizedBox(width: 20),
                    const SizedBox(width: 8),
                    Expanded(child: Text(tech)),
                  ],
                ),
              );
            }).toList(),
            onChanged: (tech) {
              if (tech != null) {
                final newSelection = List<String>.from(selectedTechStacks);
                if (newSelection.contains(tech)) {
                  newSelection.remove(tech);
                } else {
                  newSelection.add(tech);
                }
                onTechStacksChanged(newSelection);
              }
            },
            selectedItemBuilder: (context) {
              return [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text(
                    selectedTechStacks.isEmpty
                        ? 'Select Technologies'
                        : '${selectedTechStacks.length} Selected',
                  ),
                ),
              ];
            },
          ),
        ),
        // Start Date Filter
        SizedBox(
          width: 200,
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Founded Date',
              border: UnderlineInputBorder(),
              suffixIcon: Icon(Icons.calendar_today),
            ),
            readOnly: true,
            controller: TextEditingController(
              text: startDate != null
                  ? DateFormat.yMMMd().format(startDate!)
                  : '',
            ),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: startDate ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              );
              if (date != null) {
                onStartDateChanged(date);
              }
            },
          ),
        ),
        // Revenue Range Filter
        SizedBox(
          width: 200,
          child: DropdownButtonFormField<RevenueRange>(
            isExpanded: true,
            decoration: const InputDecoration(
              labelText: 'Revenue',
              border: UnderlineInputBorder(),
            ),
            hint: const Text('Select Revenue Range'),
            value: revenueRanges.firstWhere(
              (range) => range.min == minRevenue && range.max == maxRevenue,
              orElse: () => revenueRanges.first,
            ),
            items: revenueRanges.map((range) {
              return DropdownMenuItem<RevenueRange>(
                value: range,
                child: Text(range.label),
              );
            }).toList(),
            onChanged: (range) {
              if (range != null) {
                onMinRevenueChanged(range.min);
                onMaxRevenueChanged(range.max);
              }
            },
          ),
        ),
        // Team Size Filter
        SizedBox(
          width: 200,
          child: DropdownButtonFormField<TeamSizeRange>(
            isExpanded: true,
            decoration: const InputDecoration(
              labelText: 'Team Size',
              border: UnderlineInputBorder(),
            ),
            hint: const Text('Select Team Size'),
            value: teamSizeRanges.firstWhere(
              (range) => range.min == minTeamSize && range.max == maxTeamSize,
              orElse: () => teamSizeRanges.first,
            ),
            items: teamSizeRanges.map((range) {
              return DropdownMenuItem<TeamSizeRange>(
                value: range,
                child: Text(range.label),
              );
            }).toList(),
            onChanged: (range) {
              if (range != null) {
                onMinTeamSizeChanged(range.min);
                onMaxTeamSizeChanged(range.max);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAdvancedFilters(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            // Selected Categories Display
            if (selectedCategories.isNotEmpty)
              SizedBox(
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Selected Categories'),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: selectedCategories.map((category) {
                        return Chip(
                          label: Text(category),
                          onDeleted: () {
                            final newSelection =
                                List<String>.from(selectedCategories);
                            newSelection.remove(category);
                            onCategoriesChanged(newSelection);
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            // Selected Business Models Display
            if (selectedBusinessModels.isNotEmpty)
              SizedBox(
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Selected Business Models'),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: selectedBusinessModels.map((model) {
                        return Chip(
                          label: Text(model),
                          onDeleted: () {
                            final newSelection =
                                List<String>.from(selectedBusinessModels);
                            newSelection.remove(model);
                            onBusinessModelsChanged(newSelection);
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            // Selected Technology Stack Display
            if (selectedTechStacks.isNotEmpty)
              SizedBox(
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Selected Technologies'),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: selectedTechStacks.map((tech) {
                        return Chip(
                          label: Text(tech),
                          onDeleted: () {
                            final newSelection =
                                List<String>.from(selectedTechStacks);
                            newSelection.remove(tech);
                            onTechStacksChanged(newSelection);
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class RevenueRange {
  final String label;
  final double? min;
  final double? max;

  const RevenueRange(this.label, this.min, this.max);
}

class TeamSizeRange {
  final String label;
  final int? min;
  final int? max;

  const TeamSizeRange(this.label, this.min, this.max);
}
