import 'package:atobuy_vendor_flutter/controller/auth/signup_controller.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/auth/signup/widgets/signup_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppbarWithBackIconAndTitle(),
          body: SafeArea(
            child: GetBuilder<SignupController>(
                initState: (final GetBuilderState<SignupController> state) {
              Get.find<SignupController>().initialise();
            }, builder: (final SignupController signupController) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Gap(32),
                    Text(
                      'Let’s Create'.tr,
                      style: mullerW700.copyWith(
                          fontSize: 28, color: AppColors.color2E236C),
                    ),
                    Gap(16),
                    Text(
                      'Enter your details to complete your sign up'.tr,
                      style: mullerW400.copyWith(
                          fontSize: 16, color: AppColors.color6A6982),
                    ),
                    Gap(24),
                    SignupFormWidget(),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
