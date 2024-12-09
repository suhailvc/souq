import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/translations/app_translations.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

bool initialUriIsHandled = false;

class AtoBuyVendorApp extends StatelessWidget {
  AtoBuyVendorApp({super.key});

  final SharedPreferenceHelper sharedPref = Get.find<SharedPreferenceHelper>();

  @override
  Widget build(final BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: <PointerDeviceKind>{
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch
        },
      ),
      theme: Theme.of(context).copyWith(
        scaffoldBackgroundColor: AppColors.white,
        iconTheme: IconThemeData(color: AppColors.color1679AB),
      ),
      initialRoute: redirectUser(),
      getPages: RouteHelper.routes,
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
      translations: AppTranslation(),
      locale: Locale(sharedPref.getLanguageCode, sharedPref.getCountryCode),
      fallbackLocale: const Locale('en', 'US'),
      localizationsDelegates: <LocalizationsDelegate<Object>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: <Locale>[
        Locale(AppConstants.englishLangCode, 'US'),
        Locale(AppConstants.arabicLangCode, 'QA'),
      ],
      builder: EasyLoading.init(),
    );
  }

  String redirectUser() {
    if (Get.find<SharedPreferenceHelper>().isLoggedIn &&
        (Get.find<SharedPreferenceHelper>().user?.vendorStoreExist ?? false)) {
      return RouteHelper.home;
    } else {
      return RouteHelper.shop;
    }
  }
}
