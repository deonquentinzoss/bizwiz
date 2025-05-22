import 'package:flutter/material.dart';

enum SortField {
  date,
  revenue,
  teamSize,
}

enum SortOrder {
  ascending,
  descending,
}

class SortBar extends StatelessWidget {
  final SortField? selectedField;
  final SortOrder sortOrder;
  final Function(SortField?) onFieldChanged;
  final Function(SortOrder) onOrderChanged;

  const SortBar({
    super.key,
    this.selectedField,
    required this.sortOrder,
    required this.onFieldChanged,
    required this.onOrderChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Text(
              'Sort by:',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(width: 16),
            // Sort Field Dropdown
            DropdownButton<SortField>(
              value: selectedField,
              hint: const Text('Select field'),
              items: SortField.values.map((field) {
                return DropdownMenuItem<SortField>(
                  value: field,
                  child: Text(_getFieldLabel(field)),
                );
              }).toList(),
              onChanged: onFieldChanged,
            ),
            const SizedBox(width: 16),
            // Sort Order Toggle
            if (selectedField != null) ...[
              IconButton(
                icon: Icon(
                  sortOrder == SortOrder.ascending
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                ),
                onPressed: () {
                  onOrderChanged(
                    sortOrder == SortOrder.ascending
                        ? SortOrder.descending
                        : SortOrder.ascending,
                  );
                },
                tooltip: sortOrder == SortOrder.ascending
                    ? 'Sort ascending'
                    : 'Sort descending',
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _getFieldLabel(SortField field) {
    switch (field) {
      case SortField.date:
        return 'Founding Date';
      case SortField.revenue:
        return 'Revenue';
      case SortField.teamSize:
        return 'Team Size';
    }
  }
}
