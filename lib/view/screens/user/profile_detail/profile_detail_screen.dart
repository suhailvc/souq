import 'package:atobuy_vendor_flutter/controller/user/user_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/profile_detail/widgets/item_with_icon_title_and_right_icon_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/profile_detail/widgets/profile_detail_business_detail_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/profile_detail/widgets/profile_detail_contact_detail_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/profile_detail/widgets/profile_detail_profile_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/profile_detail/widgets/title_with_bullet_and_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: Scaffold(
        appBar: AppbarWithBackIconAndTitle(
          title: 'Profile Details'.tr,
        ),
        body: GetBuilder<UserProfileController>(
            builder: (final UserProfileController controller) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: AppColors.colorB1D2E3.withOpacity(0.05),
                        border: Border.all(
                          color: AppColors.colorB1D2E3,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ProfileDetailProfileWidget(),
                          Gap(16),
                          TitleWithBulletAndDividerWidget(
                              title: 'Contact Details'.tr),
                          ProfileDetailContactDetailWidget(),
                          Gap(8),
                          TitleWithBulletAndDividerWidget(
                              title: 'Business Details'.tr),
                          ProfileDetailBusinessDetailWidget(),
                          Gap(16),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: ElevatedButton(
                        child: Text(
                          'Edit Profile Details'.tr,
                          style: mullerW700.copyWith(
                            fontSize: 16,
                            color: AppColors.white,
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed(RouteHelper.editProfile);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.color3D8FB9,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          minimumSize: Size.zero,
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ),
                  ],
                ),
                ItemWithIconTitleAndRightIconWidget(
                  title: 'Change Password'.tr,
                  prefixSvgIcon: Assets.svg.icChangePassword,
                  onTap: () {
                    Get.toNamed(RouteHelper.changePassword);
                  },
                ),
                Gap(12),
              ],
            ),
          );
        }),
      ),
    );
  }
}
