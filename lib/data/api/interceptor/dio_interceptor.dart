import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as gett;

class DioInterceptor extends InterceptorsWrapper {
  final SharedPreferenceHelper sharedPrefHelper =
      gett.Get.find<SharedPreferenceHelper>();
  @override
  void onRequest(final RequestOptions options,
      final RequestInterceptorHandler handler) async {
    final Map<String, dynamic> header = <String, dynamic>{
      'Content-Type': 'application/json',
    };
    if (sharedPrefHelper.authToken.isNotEmpty) {
      header['Authorization'] = 'Token ${sharedPrefHelper.authToken}';
    }
    if (sharedPrefHelper.getLanguageCode.isNotEmpty) {
      header['Accept-Language'] = sharedPrefHelper.getLanguageCode;
    }
    debugPrint('header ${header}');
    options.headers = header;
    super.onRequest(options, handler);
  }

  @override
  void onResponse(final Response<dynamic> response,
      final ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(final DioException err, final ErrorInterceptorHandler handler) {
    if (sharedPrefHelper.isLoggedIn) {
      if (err.response?.statusCode == 401) {
        if (gett.Get.find<SharedPreferenceHelper>().authToken.isNotEmpty) {
          showCustomSnackBar(
              isError: true, message: err.response?.data['detail']);

          Utility.logout();
        }
      }
    }
    super.onError(err, handler);
  }
}
