import 'package:flutter/material.dart';

extension PickColorSteppsExtension on int {
  Color get getStepProgressColor {
    switch (this) {
      case 0:
        return Colors.grey;
      case 1:
        return Colors.blue;
      case 2:
        return Colors.amberAccent;
      case 3:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
