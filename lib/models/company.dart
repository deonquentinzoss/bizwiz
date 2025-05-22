import 'package:flutter/foundation.dart';
import 'milestone.dart';

class Company {
  final String id;
  final String name;
  final String logo;
  final String elevatorPitch;
  final DateTime startDate;
  final Revenue revenue;
  final int teamSize;
  final List<String> category;
  final Founder founder;
  final String companyHistory;
  final List<Milestone> milestones;
  final List<String> techStack;
  final String businessModel;
  final List<String> marketingStrategies;
  final List<String> relatedCompanies;

  const Company({
    required this.id,
    required this.name,
    required this.logo,
    required this.elevatorPitch,
    required this.startDate,
    required this.revenue,
    required this.teamSize,
    required this.category,
    required this.founder,
    required this.companyHistory,
    required this.milestones,
    required this.techStack,
    required this.businessModel,
    required this.marketingStrategies,
    required this.relatedCompanies,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'] as String,
      name: json['name'] as String,
      logo: json['logo'] as String,
      elevatorPitch: json['elevatorPitch'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      revenue: Revenue.fromJson(json['revenue'] as Map<String, dynamic>),
      teamSize: json['teamSize'] as int,
      category: List<String>.from(json['category'] as List),
      founder: Founder.fromJson(json['founder'] as Map<String, dynamic>),
      companyHistory: json['companyHistory'] as String,
      milestones: (json['milestones'] as List)
          .map((e) => Milestone.fromJson(e as Map<String, dynamic>))
          .toList(),
      techStack: List<String>.from(json['techStack'] as List),
      businessModel: json['businessModel'] as String,
      marketingStrategies:
          List<String>.from(json['marketingStrategies'] as List),
      relatedCompanies: List<String>.from(json['relatedCompanies'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'elevatorPitch': elevatorPitch,
      'startDate': startDate.toIso8601String(),
      'revenue': revenue.toJson(),
      'teamSize': teamSize,
      'category': category,
      'founder': founder.toJson(),
      'companyHistory': companyHistory,
      'milestones': milestones.map((e) => e.toJson()).toList(),
      'techStack': techStack,
      'businessModel': businessModel,
      'marketingStrategies': marketingStrategies,
      'relatedCompanies': relatedCompanies,
    };
  }

  @override
  String toString() {
    return 'Company(id: $id, name: $name, teamSize: $teamSize)';
  }
}

class Revenue {
  final double mrr;
  final double arr;
  final DateTime lastUpdated;

  const Revenue({
    required this.mrr,
    required this.arr,
    required this.lastUpdated,
  });

  factory Revenue.fromJson(Map<String, dynamic> json) {
    return Revenue(
      mrr: (json['mrr'] as num).toDouble(),
      arr: (json['arr'] as num).toDouble(),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mrr': mrr,
      'arr': arr,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}

class Founder {
  final String name;
  final String bio;
  final SocialLinks socialLinks;

  const Founder({
    required this.name,
    required this.bio,
    required this.socialLinks,
  });

  factory Founder.fromJson(Map<String, dynamic> json) {
    return Founder(
      name: json['name'] as String,
      bio: json['bio'] as String,
      socialLinks:
          SocialLinks.fromJson(json['socialLinks'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'bio': bio,
      'socialLinks': socialLinks.toJson(),
    };
  }
}

class SocialLinks {
  final String? twitter;
  final String? linkedin;
  final String? github;

  const SocialLinks({
    this.twitter,
    this.linkedin,
    this.github,
  });

  factory SocialLinks.fromJson(Map<String, dynamic> json) {
    return SocialLinks(
      twitter: json['twitter'] as String?,
      linkedin: json['linkedin'] as String?,
      github: json['github'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'twitter': twitter,
      'linkedin': linkedin,
      'github': github,
    };
  }
}
