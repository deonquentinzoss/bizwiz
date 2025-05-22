import 'package:flutter/foundation.dart';

enum MilestoneType { funding, product, growth, team, other }

class Milestone {
  final DateTime date;
  final String title;
  final String description;
  final MilestoneType type;

  const Milestone({
    required this.date,
    required this.title,
    required this.description,
    required this.type,
  });

  factory Milestone.fromJson(Map<String, dynamic> json) {
    return Milestone(
      date: DateTime.parse(json['date'] as String),
      title: json['title'] as String,
      description: json['description'] as String,
      type: MilestoneType.values.firstWhere(
        (e) => e.toString() == 'MilestoneType.${json['type']}',
        orElse: () => MilestoneType.other,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'title': title,
      'description': description,
      'type': type.toString().split('.').last,
    };
  }

  @override
  String toString() {
    return 'Milestone(date: $date, title: $title, type: $type)';
  }
}
