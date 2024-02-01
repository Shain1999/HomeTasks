import 'package:flutter/material.dart';

enum TaskCategory { shopping, cleaning,none }

extension TaskCategoryExtension on TaskCategory {
  IconData get icon {
    switch (this) {
      case TaskCategory.shopping:
        return Icons.shopping_cart;
      case TaskCategory.cleaning:
        return Icons.cleaning_services;
      case TaskCategory.none:
        return Icons.error_outline; // or any other default icon
    }
  }
}