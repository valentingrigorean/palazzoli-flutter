import 'package:flutter/material.dart';
import 'package:lightingPalazzoli/validators/validation_rule.dart';

class CompareRule<T> implements ValidationRule<T> {
  final ValueGetter<T> other;

  CompareRule(this.validationMessage, this.other);

  @override
  String validationMessage;

  @override
  bool check(T value) {
    return other() == value;
  }
}
