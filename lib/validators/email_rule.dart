import 'package:lightingPalazzoli/validators/validation_rule.dart';

class EmailRule implements ValidationRule<String> {
  EmailRule(this.validationMessage);

  @override
  String validationMessage;

  @override
  bool check(String value) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(value);
  }
}
