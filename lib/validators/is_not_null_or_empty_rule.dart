import 'package:lightingPalazzoli/validators/validation_rule.dart';
import 'package:quiver/strings.dart';

class IsNotNullOrEmptyRule implements ValidationRule<String> {
  IsNotNullOrEmptyRule(this.validationMessage);

  @override
  String validationMessage;

  @override
  bool check(String value) {
    return isNotEmpty(value);
  }
}
