import 'dart:io';
import 'dart:math';

import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/auth/login_reponse_model.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/parsing.dart';
import 'package:atobuy_vendor_flutter/helper/regex_helper.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/cart_icon.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:url_launcher/url_launcher.dart';

class Utility {
  static void showAPIError(final DioException error) {
    String message = '';

    if (Map<dynamic, dynamic>.from(error.response?.data).entries.first.value
        is List) {
      message = Map<dynamic, dynamic>.from(error.response?.data)
          .entries
          .first
          .value[0];
    } else if (Map<dynamic, dynamic>.from(error.response?.data)
        .entries
        .first
        .value is String) {
      message =
          Map<dynamic, dynamic>.from(error.response?.data).entries.first.value;
    }
    showCustomSnackBar(message: message);
  }

  static Future<dynamic> launchUrl({required final String url}) async {
    if (!await launchUrl(url: url)) {
      debugPrint('could not launch url');
    }
  }

  static void saveUserDetails(final LoginUserResponse loginResponse,
      {final bool? isRememberMeTicked, final String? password}) async {
    final SharedPreferenceHelper sharedPref =
        Get.find<SharedPreferenceHelper>();
    await sharedPref.saveIsLoggedIn(true);
    await sharedPref.saveAuthToken(loginResponse.token ?? '');
    if (loginResponse.user != null) {
      await sharedPref.saveUser(loginResponse.user!);
    }

    if (isRememberMeTicked ?? false) {
      await sharedPref.saveIsRememberMe(true);
      await sharedPref.saveEmail(loginResponse.user?.email ?? '');
      await sharedPref.setUserPassword(password ?? '');
    } else {
      await sharedPref.saveIsRememberMe(false);
      await sharedPref.saveEmail('');
      await sharedPref.setUserPassword('');
    }
    await sharedPref
        .saveIsKycVerify(loginResponse.user?.isKycApproved ?? false);
  }

  static Future<Media?> pickImage(final PhotoPickerType photoPickerType) async {
    try {
      Media? media;
      if (photoPickerType == PhotoPickerType.camera) {
        media =
            await ImagePickers.openCamera(cameraMimeType: CameraMimeType.photo);
      } else {
        final List<Media> medias = await ImagePickers.pickerPaths(
          galleryMode: GalleryMode.image,
          selectCount: 1,
          showGif: false,
        );
        if (medias.isNotEmpty) {
          media = medias.first;
        }
      }
      return media;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static bool checkIsNetworkUrl(final String url) {
    if (url.contains('http') || url.contains('https')) {
      return true;
    }
    return false;
  }

  static void logout() async {
    final SharedPreferenceHelper sharedPref =
        Get.find<SharedPreferenceHelper>();
    await sharedPref.clear();

    SouqCart.update(newCartCount: 0);
    if (Get.context != null) {
      Get.offAllNamed(RouteHelper.shop);
    }
  }

  static Color getProductStatusColor(final String status) {
    Color statusColor = AppColors.color12658E;
    if (status == ProductApprovalStatus.inReview.key) {
      statusColor = AppColors.colorE59825;
    } else if (status == ProductApprovalStatus.approved.key) {
      statusColor = AppColors.color12658E;
    } else if (status == ProductApprovalStatus.rejected.key) {
      statusColor = AppColors.colorEA2251;
    }
    return statusColor;
  }

  static Color getPromotionalBannerStatusColor(final String status) {
    Color statusColor = AppColors.color12658E;
    if (status == PromotionalBannerApprovalStatus.upcoming.key) {
      statusColor = AppColors.color12658E;
    } else if (status == PromotionalBannerApprovalStatus.running.key) {
      statusColor = AppColors.colorE59825;
    } else if (status == PromotionalBannerApprovalStatus.completed.key) {
      statusColor = AppColors.color2E236C;
    }
    return statusColor;
  }

  static Color getOrderStatusColor(final OrderStatus? status) {
    Color statusColor = AppColors.color12658E;

    if (status == OrderStatus.processing) {
      statusColor = AppColors.color3D8FB9;
    } else if (status == OrderStatus.pending) {
      statusColor = AppColors.colorE59825;
    } else if (status == OrderStatus.accepted) {
      statusColor = AppColors.color2E236C;
    } else if (status == OrderStatus.rejected ||
        status == OrderStatus.returned ||
        status == OrderStatus.canceled ||
        status == OrderStatus.refunded) {
      statusColor = AppColors.colorE52551;
    }
    return statusColor;
  }

  static void isUserLoggedIn(
      {required final String routeName,
      final bool isTab = false,
      final Map<String, dynamic>? arguments}) async {
    if (!Get.find<SharedPreferenceHelper>().isLoggedIn) {
      Get.toNamed(RouteHelper.login)?.whenComplete(() {
        if (Get.find<SharedPreferenceHelper>().isLoggedIn) {
          if (isTab) {
            Get.offAllNamed(
              routeName,
              arguments: arguments,
            );
          } else {
            Get.toNamed(
              routeName,
              arguments: arguments,
            );
          }
        }
      });
    } else {
      if (isTab) {
        Get.offAllNamed(
          routeName,
          arguments: arguments,
        );
      } else {
        Get.toNamed(
          routeName,
          arguments: arguments,
        );
      }
    }
  }

  static bool isAllowCountryCodeTap(final GlobalController globalController) {
    return (globalController.countryList.isNotEmpty &&
            globalController.countryList.length > 1)
        ? true
        : false;
  }

  static String getFileSizeString(
      {required final int bytes, final int decimals = 0}) {
    const List<String> suffixes = <String>['B', 'KB', 'MB', 'GB', 'TB'];
    if (bytes == 0) return '0 ${suffixes[0]}';
    final int i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }

  static String getRandomString(final int length) {
    final String _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final Random _rnd = Random();

    return String.fromCharCodes(
      Iterable<int>.generate(
        length,
        (final _) => _chars.codeUnitAt(
          _rnd.nextInt(_chars.length),
        ),
      ),
    );
  }

  static List<TextSpan> highlightOccurrences(
      final String source, final String query) {
    int findAmountValues(final String word) {
      return word.replaceAll(RegexHelper.nameRegex, '').length;
    }

    final TextStyle styleAmount =
        mullerW500.copyWith(color: AppColors.color3D8FB9, fontSize: 16);

    if (query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
      return <TextSpan>[TextSpan(text: source)];
    }
    final Iterable<Match> matches =
        query.toLowerCase().allMatches(source.toLowerCase());

    int lastMatchEnd = 0;

    final List<TextSpan> children = <TextSpan>[];
    for (int i = 0; i < matches.length; i++) {
      final Match match = matches.elementAt(i);

      //Before string values match set this style
      if (match.start != lastMatchEnd) {
        children.add(
          TextSpan(
            text: source.substring(lastMatchEnd, match.start),
            style: findAmountValues(source) == source.length ||
                    source
                        .substring(0, 2)
                        .contains(AppConstants.defaultCurrency)
                ? styleAmount
                : mullerW500.copyWith(
                    color: AppColors.color3D8FB9, fontSize: 16),
          ),
        );
      }

      //Match string values set style
      children.add(
        TextSpan(
          text: source.substring(match.start, match.end),
          style:
              mullerW500.copyWith(color: AppColors.color333333, fontSize: 16),
        ),
      );

      //After string values match set style values
      if (i == matches.length - 1 && match.end != source.length) {
        children.add(
          TextSpan(
            text: source.substring(match.end, source.length),
          ),
        );
      }

      lastMatchEnd = match.end;
    }
    return children;
  }

  static void goBack() {
    Get.key.currentState?.pop();
  }

  static RangeValues? onChangeMaxPriceRange(
      {required final String value,
      required final RangeValues filterViewRange}) {
    if (value.isNotEmpty && Parsing.doubleFrom(value) > filterViewRange.start) {
      final RangeValues rangeValues = RangeValues(
        filterViewRange.start,
        Parsing.doubleFrom(value),
      );
      return rangeValues;
    }
    return null;
  }

  static RangeValues? onChangeMinPriceRange(
      {required final String value,
      required final RangeValues filterViewRange,
      required final RangeValues listViewRange}) {
    if (value.isNotEmpty && Parsing.doubleFrom(value) > listViewRange.end) {
      return null;
    }
    if (Parsing.doubleFrom(value) >= 0.0) {
      final RangeValues rangeValues =
          RangeValues(Parsing.doubleFrom(value), filterViewRange.end);
      return rangeValues;
    }
    return null;
  }

  static Future<void> openWhatsApp({final String? orderId}) async {
    String phoneNumberCode = AppConstants.contactUsWhatsAppPhone;

    phoneNumberCode = phoneNumberCode.replaceAll('+', '');
    final String message = orderId != null
        ? 'Hi, I\'m checking on the status of my order $orderId. Can you please update me? Thanks!'
        : '';

    final Uri url =
        Uri.parse('whatsapp://send?phone=$phoneNumberCode&text=$message');
    final Uri storeUrl = Uri.parse(Platform.isAndroid
        ? AppConstants.whatsappPlayStoreUrl
        : AppConstants.whatsappAppStoreUrl);

    if (await urlLauncher.canLaunchUrl(url)) {
      await urlLauncher.launchUrl(url);
    } else {
      if (await urlLauncher.canLaunchUrl(storeUrl)) {
        await urlLauncher.launchUrl(storeUrl,
            mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $storeUrl';
      }
      throw 'Could not launch $url';
    }
  }
}
