/// Validates form buit-in methods.
class Validator {
  static String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    return null;
  }
}
