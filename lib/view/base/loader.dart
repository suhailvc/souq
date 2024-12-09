import 'package:flutter_easyloading/flutter_easyloading.dart';

class Loader {
  static Future<void> load(final bool value) async {
    if (value) {
      await EasyLoading.show(
        status: 'Loading...',
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false,
      );
    } else {
      await EasyLoading.dismiss();
    }
  }
}
