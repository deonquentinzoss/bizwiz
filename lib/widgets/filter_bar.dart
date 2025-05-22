import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FilterBar extends StatelessWidget {
  final List<String> categories;
  final String? selectedCategory;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? minRevenue;
  final double? maxRevenue;
  final int? minTeamSize;
  final int? maxTeamSize;
  final Function(String?) onCategoryChanged;
  final Function(DateTime?) onStartDateChanged;
  final Function(DateTime?) onEndDateChanged;
  final Function(double?) onMinRevenueChanged;
  final Function(double?) onMaxRevenueChanged;
  final Function(int?) onMinTeamSizeChanged;
  final Function(int?) onMaxTeamSizeChanged;
  final VoidCallback onClearFilters;

  const FilterBar({
    super.key,
    required this.categories,
    this.selectedCategory,
    this.startDate,
    this.endDate,
    this.minRevenue,
    this.maxRevenue,
    this.minTeamSize,
    this.maxTeamSize,
    required this.onCategoryChanged,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
    required this.onMinRevenueChanged,
    required this.onMaxRevenueChanged,
    required this.onMinTeamSizeChanged,
    required this.onMaxTeamSizeChanged,
    required this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currencyFormat = NumberFormat.compactCurrency(symbol: '\$');

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Filters',
                  style: theme.textTheme.titleLarge,
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: onClearFilters,
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                // Category Filter
                SizedBox(
                  width: 200,
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    value: selectedCategory,
                    items: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text('All Categories'),
                      ),
                      ...categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }),
                    ],
                    onChanged: onCategoryChanged,
                  ),
                ),
                // Date Range Filter
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Start Date',
                      border: OutlineInputBorder(),
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
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'End Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    controller: TextEditingController(
                      text: endDate != null
                          ? DateFormat.yMMMd().format(endDate!)
                          : '',
                    ),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: endDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        onEndDateChanged(date);
                      }
                    },
                  ),
                ),
                // Revenue Range Filter
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Min Revenue',
                      border: const OutlineInputBorder(),
                      suffixText: currencyFormat.format(minRevenue ?? 0),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final revenue = double.tryParse(value);
                      onMinRevenueChanged(revenue);
                    },
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Max Revenue',
                      border: const OutlineInputBorder(),
                      suffixText: currencyFormat.format(maxRevenue ?? 0),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final revenue = double.tryParse(value);
                      onMaxRevenueChanged(revenue);
                    },
                  ),
                ),
                // Team Size Filter
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Min Team Size',
                      border: const OutlineInputBorder(),
                      suffixText: minTeamSize?.toString() ?? '0',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final size = int.tryParse(value);
                      onMinTeamSizeChanged(size);
                    },
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Max Team Size',
                      border: const OutlineInputBorder(),
                      suffixText: maxTeamSize?.toString() ?? '0',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final size = int.tryParse(value);
                      onMaxTeamSizeChanged(size);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
