abstract class ValidationRule<T> {
  String validationMessage;

  bool check(T value);
}
