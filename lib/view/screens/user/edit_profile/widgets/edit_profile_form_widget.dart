import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/controller/user/user_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/auth/business_type_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/country_picker/countries.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/company_name_widget.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/email_widget.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/first_name_widget.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/last_name_widget.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/mobile_number_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/auth/signup/widgets/business_type_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class EditProfileFormWidget extends StatelessWidget {
  const EditProfileFormWidget({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<UserProfileController>(
        builder: (final UserProfileController controller) {
      return Expanded(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: GetBuilder<GlobalController>(
              builder: (final GlobalController globalController) {
            return Form(
              key: controller.editProfileFormKey,
              child: Column(
                children: <Widget>[
                  Gap(24),
                  FirstNameWidget(controller: controller.txtFirstNameEc),
                  Gap(16),
                  LastNameWidget(controller: controller.txtLastNameEc),
                  Gap(16),
                  EmailWidget(controller: controller.txtEmailEc),
                  Gap(16),
                  MobileNumberWidget(
                    labelStyle: mullerW400.copyWith(
                        color: AppColors.color8ABCD5, fontSize: 12),
                    controller: controller.txtMobileNumberEc,
                    countryCode: controller.countryCode,
                    onCountryChange: (final Country country) {
                      controller.setPhoneDialCode(country);
                    },
                    allowOnCountryTap:
                        Utility.isAllowCountryCodeTap(globalController),
                  ),
                  Gap(16),
                  CompanyNameWidget(
                    controller: controller.txtCompanyNameEc,
                    image: Assets.svg.icBusiness,
                  ),
                  Gap(16),
                  BusinessTypeTextFieldWidget(
                    selectedTypes: controller.selectedBusinessTypes,
                    onChangeType: (final List<BusinessCategory>? type) {
                      controller.selectedBusinessTypes =
                          type ?? <BusinessCategory>[];
                      controller.update();
                    },
                    arrBusinessType: controller.arrBusinessTypes,
                  ),
                  Gap(16),
                ],
              ),
            );
          }),
        ),
      );
    });
  }
}
