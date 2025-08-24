import 'package:flutter/material.dart';

class IoTComponent {
  final String name;
  final String description;
  final IconData icon;
  final String category;
  final Color color;
  final List<String> specifications;
  final String usage;
  final void Function(BuildContext context)? onTap;

  IoTComponent({
    required this.name,
    required this.description,
    required this.icon,
    required this.category,
    required this.color,
    required this.specifications,
    required this.usage,
    this.onTap,
  });
}
