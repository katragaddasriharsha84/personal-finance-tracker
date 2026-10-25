import 'package:flutter/material.dart';

class SpendingCategoryModel {
  final String name;
  final double amount;
  final double percentage; // e.g. 0.36
  final Color color;

  const SpendingCategoryModel({
    required this.name,
    required this.amount,
    required this.percentage,
    required this.color,
  });

  String get formattedPercentage => '${(percentage * 100).toInt()}%';
  String get formattedAmount => '\$${amount.toStringAsFixed(0)}';
}
