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
    final theme = Theme.of(context);
    final currencyFormat = NumberFormat.compactCurrency(symbol: '\$');
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Card(
      margin: EdgeInsets.all(isMobile ? 8 : 16),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 8 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isMobile) ...[
              // Mobile: Search bar on top
              CustomSearchBar(
                onSearch: onSearch,
                searchHistory: searchHistory,
                onClearHistory: onClearHistory,
              ),
              const SizedBox(height: 16),
              // Mobile: Basic filters in a column
              _buildBasicFilters(context, currencyFormat, isMobile: true),
              const SizedBox(height: 8),
              // Mobile: Clear button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: onClearFilters,
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear All'),
                ),
              ),
              const SizedBox(height: 8),
              // Mobile: Selected filters
              _buildSelectedFilters(context),
            ] else ...[
              // Desktop: All filters in a single row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        _buildBasicFilters(context, currencyFormat),
                        _buildAdvancedFilters(context),
                        TextButton.icon(
                          onPressed: onClearFilters,
                          icon: const Icon(Icons.clear_all),
                          label: const Text('Clear All'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
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
              const SizedBox(height: 8),
              // Desktop: Selected filters
              _buildSelectedFilters(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBasicFilters(BuildContext context, NumberFormat currencyFormat,
      {bool isMobile = false}) {
    final filterWidth = isMobile ? double.infinity : 200.0;
    final businessModelWidth = isMobile ? double.infinity : 250.0;

    return Wrap(
      spacing: isMobile ? 0 : 16,
      runSpacing: isMobile ? 16 : 16,
      children: [
        // Category Filter
        SizedBox(
          width: filterWidth,
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
          width: businessModelWidth,
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
          width: filterWidth,
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
      ],
    );
  }

  Widget _buildAdvancedFilters(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        // Start Date Filter
        SizedBox(
          width: 200,
          child: TextFormField(
            readOnly: true,
            decoration: const InputDecoration(
              labelText: 'Start Date',
              border: UnderlineInputBorder(),
              suffixIcon: Icon(Icons.calendar_today),
            ),
            controller: TextEditingController(
              text: startDate != null
                  ? DateFormat.yMMMd().format(startDate!)
                  : 'Any Date',
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
            value: revenueRanges.firstWhere(
              (range) =>
                  range.minRevenue == minRevenue &&
                  range.maxRevenue == maxRevenue,
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
                onMinRevenueChanged(range.minRevenue);
                onMaxRevenueChanged(range.maxRevenue);
              }
            },
          ),
        ),
        // Team Size Range Filter
        SizedBox(
          width: 200,
          child: DropdownButtonFormField<TeamSizeRange>(
            isExpanded: true,
            decoration: const InputDecoration(
              labelText: 'Team Size',
              border: UnderlineInputBorder(),
            ),
            value: teamSizeRanges.firstWhere(
              (range) =>
                  range.minSize == minTeamSize && range.maxSize == maxTeamSize,
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
                onMinTeamSizeChanged(range.minSize);
                onMaxTeamSizeChanged(range.maxSize);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedFilters(BuildContext context) {
    final theme = Theme.of(context);
    final hasSelectedFilters = selectedCategories.isNotEmpty ||
        selectedTechStacks.isNotEmpty ||
        selectedBusinessModels.isNotEmpty ||
        startDate != null ||
        minRevenue != null ||
        maxRevenue != null ||
        minTeamSize != null ||
        maxTeamSize != null;

    if (!hasSelectedFilters) return const SizedBox.shrink();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ...selectedCategories.map((category) => Chip(
              label: Text(category),
              onDeleted: () {
                final newSelection = List<String>.from(selectedCategories)
                  ..remove(category);
                onCategoriesChanged(newSelection);
              },
            )),
        ...selectedTechStacks.map((tech) => Chip(
              label: Text(tech),
              onDeleted: () {
                final newSelection = List<String>.from(selectedTechStacks)
                  ..remove(tech);
                onTechStacksChanged(newSelection);
              },
            )),
        ...selectedBusinessModels.map((model) => Chip(
              label: Text(model),
              onDeleted: () {
                final newSelection = List<String>.from(selectedBusinessModels)
                  ..remove(model);
                onBusinessModelsChanged(newSelection);
              },
            )),
        if (startDate != null)
          Chip(
            label: Text('Founded after ${DateFormat.y().format(startDate!)}'),
            onDeleted: () => onStartDateChanged(null),
          ),
        if (minRevenue != null || maxRevenue != null)
          Chip(
            label: Text(
              'Revenue: ${minRevenue != null ? '>\$${NumberFormat.compact().format(minRevenue)}' : ''}'
              '${minRevenue != null && maxRevenue != null ? ' - ' : ''}'
              '${maxRevenue != null ? '<\$${NumberFormat.compact().format(maxRevenue)}' : ''}',
            ),
            onDeleted: () {
              onMinRevenueChanged(null);
              onMaxRevenueChanged(null);
            },
          ),
        if (minTeamSize != null || maxTeamSize != null)
          Chip(
            label: Text(
              'Team Size: ${minTeamSize != null ? '>$minTeamSize' : ''}'
              '${minTeamSize != null && maxTeamSize != null ? ' - ' : ''}'
              '${maxTeamSize != null ? '<$maxTeamSize' : ''}',
            ),
            onDeleted: () {
              onMinTeamSizeChanged(null);
              onMaxTeamSizeChanged(null);
            },
          ),
      ],
    );
  }
}

class RevenueRange {
  final String label;
  final double? minRevenue;
  final double? maxRevenue;

  const RevenueRange(this.label, this.minRevenue, this.maxRevenue);
}

class TeamSizeRange {
  final String label;
  final int? minSize;
  final int? maxSize;

  const TeamSizeRange(this.label, this.minSize, this.maxSize);
}
