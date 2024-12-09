import 'package:atobuy_vendor_flutter/controller/auth/login_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:atobuy_vendor_flutter/view/screens/auth/login/widgets/dont_have_account_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/auth/login/widgets/error_info_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/auth/login/widgets/login_tab_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/auth/login/widgets/login_with_email_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/auth/login/widgets/login_with_mobile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
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
          body: SafeArea(
            child: GetBuilder<LoginController>(
                initState: (final GetBuilderState<LoginController> state) {
              Get.find<LoginController>().init();
              Get.find<LoginController>().resetFieldsAndValidations();
            }, builder: (final LoginController controller) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Gap(34),
                    SvgPicture.asset(Assets.svg.icLogoColored),
                    Gap(51.87),
                    Text(
                      'Hi, Welcome Back'.tr,
                      style: mullerW700.copyWith(
                          fontSize: 28, color: AppColors.color1D1D1D),
                    ),
                    Gap(9),
                    Text(
                      'Login to continue using our platform'.tr,
                      style: mullerW400.copyWith(
                          fontSize: 16, color: AppColors.color757474),
                    ),
                    Gap(controller.loginError != null ? 24 : 0),
                    controller.loginError != null
                        ? ErrorInfoView(
                            message: controller.loginError!,
                          )
                        : SizedBox(),
                    Gap(24),
                    LoginTab(
                      onSelectTab: (final SelectedLoginType type) {
                        controller.loginError = null;
                        controller.selectedTab = type;
                        controller.update();
                      },
                      selectedTab: controller.selectedTab,
                    ),
                    Gap(30),
                    controller.selectedTab == SelectedLoginType.email
                        ? LoginFormWidget()
                        : LoginWithMobile(),
                    Gap(30),
                    CommonButton(
                      onTap: () {
                        controller.onTapLogin();
                      },
                      title: 'Login'.tr,
                    ),
                    Gap(50),
                    const DontHaveAccountWidget(),
                    Gap(10),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Get.offAllNamed(RouteHelper.shop);
                        },
                        child: Text(
                          'Continue as guest'.tr,
                          style: mullerW500.copyWith(
                              fontSize: 20, color: AppColors.color2E236C),
                        ),
                      ),
                    ),
                    Gap(30),
                  ],
                ).paddingSymmetric(horizontal: 16),
              );
            }),
          ),
        ),
      ),
    );
  }
}
