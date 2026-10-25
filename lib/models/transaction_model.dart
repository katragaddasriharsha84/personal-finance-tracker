import 'package:flutter/material.dart';

enum TransactionIconType { initials, salary, bill, coffee, grocery, transport, transfer }

class TransactionModel {
  final String id;
  final String title;
  final String category;
  final String dateGroup; // 'TODAY', 'YESTERDAY', 'SEP 24'
  final String timestamp; // 'Today, 9:12 AM', 'Yesterday', 'Sep 24'
  final double amount;
  final bool isIncome;
  final TransactionIconType iconType;
  final String? initials;
  final Color? avatarBg;
  final Color? avatarFg;
  final String reference;
  final double fee;
  final double cashback;
  final String status;
  final String paidWith;

  const TransactionModel({
    required this.id,
    required this.title,
    required this.category,
    required this.dateGroup,
    required this.timestamp,
    required this.amount,
    required this.isIncome,
    this.iconType = TransactionIconType.transfer,
    this.initials,
    this.avatarBg,
    this.avatarFg,
    this.reference = 'FNR-2L9D-77QA',
    this.fee = 0.00,
    this.cashback = 0.00,
    this.status = 'Completed',
    this.paidWith = 'Visa •••• 4821',
  });

  String get formattedAmount {
    final prefix = isIncome ? '+\$' : '−\$';
    return '$prefix${amount.toStringAsFixed(2)}';
  }
}
