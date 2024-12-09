class RegexHelper {
  static final RegExp regexPhone = RegExp('[0-9]');
  static final RegExp regexDecimal = RegExp(r'^\d+\.?\d{0,2}'); //'[0-9.]');
  static final RegExp regexCountWord = RegExp(r'[\w-._]+');
  static final RegExp regexPassword =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  static final RegExp nameRegex = RegExp('[a-zA-Z ]');
  static final RegExp companyNameRegex = RegExp('[a-zA-Z .]');
}
