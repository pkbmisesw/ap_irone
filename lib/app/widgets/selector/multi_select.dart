import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectItem<T extends Object> {
  final String label;
  final T value;

  SelectItem({
    required this.label,
    required this.value,
  });
}
