import 'package:atobuy_vendor_flutter/controller/auth/signup_controller.dart';
import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/auth/business_type_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/user_profile/address_list_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:atobuy_vendor_flutter/view/base/country_picker/countries.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/company_name_widget.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/confirm_password_widget.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/email_widget.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/first_name_widget.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/last_name_widget.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/mobile_number_widget.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/password_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/auth/signup/widgets/already_have_account_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/auth/signup/widgets/business_type_textfield_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/auth/signup/widgets/tnc_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/edit_personal_address/widgets/country_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SignupFormWidget extends GetWidget<SignupController> {
  const SignupFormWidget({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<SignupController>(
        builder: (final SignupController signUpController) {
      return Expanded(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: GetBuilder<GlobalController>(
              builder: (final GlobalController globalController) {
            return Form(
              key: controller.signUpFormKey,
              child: Column(
                children: <Widget>[
                  Gap(24),
                  FirstNameWidget(controller: signUpController.firstNameEC),
                  Gap(16),
                  LastNameWidget(controller: signUpController.lastNameEC),
                  Gap(16),
                  CompanyNameWidget(
                      image: Assets.svg.icCompany,
                      controller: signUpController.companyEC),
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
                  EmailWidget(controller: signUpController.emailEC),
                  Gap(16),
                  MobileNumberWidget(
                    labelStyle: mullerW400.copyWith(
                        color: AppColors.color8ABCD5, fontSize: 12.0),
                    controller: signUpController.phoneEC,
                    countryCode: signUpController.countryCode,
                    onCountryChange: (final Country country) {
                      controller.setPhoneDialCode(country);
                    },
                    allowOnCountryTap:
                        Utility.isAllowCountryCodeTap(globalController),
                  ),
                  Gap(16),
                  CountryTextFieldWidget(
                    selectedCountry: controller.selectedCountry,
                    onCountryChange: (final CountryModel? country) {
                      controller.setSelectedCountry(country);
                    },
                  ),
                  Gap(16),
                  PasswordWidget(
                      controller: signUpController.passwordEC,
                      isPasswordVisible: signUpController.isPasswordVisible,
                      onChange: (final String value) {
                        signUpController.update();
                      },
                      onPasswordVisibility: (final bool result) {
                        signUpController.changePasswordVisibility(result);
                      }),
                  Gap(16),
                  ConfirmPasswordWidget(
                      controller: signUpController.confirmPasswordEC,
                      password: signUpController.passwordEC.text,
                      isPasswordVisible: signUpController.isCnfPasswordVisible,
                      onPasswordVisibility: (final bool result) {
                        signUpController.changeCnfPasswordVisibility(result);
                      }),
                  Gap(20),
                  TnCWidget(),
                  Gap(30),
                  CommonButton(
                    onTap: () {
                      signUpController.createUserAccount();
                    },
                    title: 'Sign Up'.tr,
                  ),

                  Gap(50),
                  const AlreadyHaveAnAcc(),
                  Gap(30),
                  // const GuestUserAccountWidget(),
                ],
              ),
            );
          }),
        ),
      );
    });
  }
}
