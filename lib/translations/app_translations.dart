import 'package:atobuy_vendor_flutter/translations/ar-qa/ar_qa_translations.dart';
import 'package:atobuy_vendor_flutter/translations/en_US/en_us_translations.dart';
import 'package:get/get.dart';

Map<String, Map<String, String>> translations = <String, Map<String, String>>{
  'en_US': enUs,
  'ar': arQa,
};

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => translations;
}
