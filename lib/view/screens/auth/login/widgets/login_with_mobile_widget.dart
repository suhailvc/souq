import 'package:atobuy_vendor_flutter/controller/auth/login_controller.dart';
import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/country_picker/countries.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/mobile_number_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginWithMobile extends StatelessWidget {
  const LoginWithMobile({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<LoginController>(
        builder: (final LoginController controller) {
      return Form(
        key: controller.loginWithMobileFormKey,
        child: Column(
          children: <Widget>[
            GetBuilder<GlobalController>(
                builder: (final GlobalController globalController) {
              return MobileNumberWidget(
                controller: controller.txtMobileNumber,
                countryCode: controller.selectedCountryCode,
                onCountryChange: (final Country country) {
                  controller.selectedCountryCode = country.dialCode;
                },
                allowOnCountryTap:
                    Utility.isAllowCountryCodeTap(globalController),
                labelStyle: mullerW400.copyWith(
                    color: AppColors.color8ABCD5, fontSize: 12.0),
              );
            }),
          ],
        ),
      );
    });
  }
}
