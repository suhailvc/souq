import 'package:atobuy_vendor_flutter/helper/regex_helper.dart';

extension PasswordValidator on String {
  bool isValidPassword() {
    return RegexHelper.regexPassword.hasMatch(this);
  }
}
