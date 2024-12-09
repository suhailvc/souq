import 'package:atobuy_vendor_flutter/controller/contact_us_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactUsBottomWidget extends StatelessWidget {
  const ContactUsBottomWidget({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<ContactUsController>(
        builder: (final ContactUsController controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Gap(40),
          InkWell(
            onTap: () {
              launchUrlString('mailto:${AppConstants.contactUsEmail}')
                  .catchError(
                (final e) {
                  debugPrint('Error: $e');
                },
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset(
                  Assets.svg.icEmailFill,
                  colorFilter:
                      ColorFilter.mode(AppColors.color12658E, BlendMode.srcIn),
                ),
                Gap(15),
                Text(
                  'Email'.tr,
                  style: mullerW500.copyWith(
                      color: AppColors.color757474, fontSize: 16),
                ),
                Gap(6),
                Text(
                  AppConstants.contactUsEmail,
                  style: mullerW500.copyWith(
                      color: AppColors.color1D1D1D, fontSize: 16),
                ),
              ],
            ),
          ),
          Gap(30),
          InkWell(
            onTap: () async {
              final String url = 'tel://${AppConstants.contactUsWhatsAppPhone}';
              if (await canLaunchUrlString(url)) {
                launchUrlString(url);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset(
                  Assets.svg.icCallFill,
                  colorFilter:
                      ColorFilter.mode(AppColors.color12658E, BlendMode.srcIn),
                ),
                Gap(15),
                Text(
                  'Phone'.tr,
                  style: mullerW500.copyWith(
                      color: AppColors.color757474, fontSize: 16),
                ),
                Gap(6),
                Text(
                  AppConstants.contactUsWhatsAppPhone,
                  style: mullerW500.copyWith(
                      color: AppColors.color1D1D1D, fontSize: 16),
                ),
              ],
            ),
          ),
          Gap(30),
          SvgPicture.asset(
            Assets.svg.icLocationFill,
            colorFilter:
                ColorFilter.mode(AppColors.color12658E, BlendMode.srcIn),
          ),
          Gap(15),
          Text(
            'Address'.tr,
            style:
                mullerW500.copyWith(color: AppColors.color757474, fontSize: 16),
          ),
          Gap(6),
          Text(
            Get.find<SharedPreferenceHelper>().getLanguageCode ==
                    AppConstants.arabicLangCode
                ? AppConstants.contactUsArabicAddress
                : AppConstants.contactUsAddress,
            style:
                mullerW500.copyWith(color: AppColors.color1D1D1D, fontSize: 16),
          ),
        ],
      );
    });
  }
}
