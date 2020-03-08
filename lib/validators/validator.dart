import 'package:lightingPalazzoli/validators/validation_rule.dart';

class Validator<T> {
  final List<ValidationRule> rules;

  Validator(this.rules);

  String validate(T value) {
    for (var rule in rules) {
      if (!rule.check(value)) {
        return rule.validationMessage;
      }
    }
    return null;
  }
}
