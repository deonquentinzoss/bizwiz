import 'package:flutter/material.dart';

enum SortField { date, revenue, teamSize }

enum SortOrder { ascending, descending }

class SortBar extends StatelessWidget {
  final SortField sortField;
  final SortOrder sortOrder;
  final Function(SortField) onSortFieldChanged;
  final Function(SortOrder) onSortOrderChanged;

  const SortBar({
    super.key,
    required this.sortField,
    required this.sortOrder,
    required this.onSortFieldChanged,
    required this.onSortOrderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownButton<SortField>(
          value: sortField,
          items: SortField.values.map((field) {
            return DropdownMenuItem<SortField>(
              value: field,
              child: Text(_getSortFieldLabel(field)),
            );
          }).toList(),
          onChanged: (field) {
            if (field != null) {
              onSortFieldChanged(field);
            }
          },
        ),
        const SizedBox(width: 16),
        IconButton(
          icon: Icon(
            sortOrder == SortOrder.ascending
                ? Icons.arrow_upward
                : Icons.arrow_downward,
          ),
          onPressed: () {
            onSortOrderChanged(
              sortOrder == SortOrder.ascending
                  ? SortOrder.descending
                  : SortOrder.ascending,
            );
          },
        ),
      ],
    );
  }

  String _getSortFieldLabel(SortField field) {
    switch (field) {
      case SortField.date:
        return 'Start Date';
      case SortField.revenue:
        return 'Revenue';
      case SortField.teamSize:
        return 'Team Size';
    }
  }
}
