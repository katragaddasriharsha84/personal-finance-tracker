import 'package:flutter/material.dart';

class ContactModel {
  final String id;
  final String name;
  final String handle;
  final String bankOrPhone;
  final String initials;
  final Color avatarBg;
  final Color avatarFg;

  const ContactModel({
    required this.id,
    required this.name,
    required this.handle,
    required this.bankOrPhone,
    required this.initials,
    required this.avatarBg,
    required this.avatarFg,
  });
}
