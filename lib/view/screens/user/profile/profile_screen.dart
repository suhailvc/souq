import 'package:atobuy_vendor_flutter/controller/user/user_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_bottombar.dart';
import 'package:atobuy_vendor_flutter/view/base/user_default_avatar.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/profile/widgets/profile_options_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: Scaffold(
        appBar: AppbarWithTitle(
          title: 'My Profile'.tr,
        ),
        body: SafeArea(
          child: GetBuilder<UserProfileController>(
              builder: (final UserProfileController controller) {
            return Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Gap(30),
                  controller.sharedPreferenceHelper.isLoggedIn
                      ? GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.profileDetail);
                          },
                          child: Row(
                            children: <Widget>[
                              CachedNetworkImage(
                                imageUrl:
                                    controller.userProfile.profileImage ?? '',
                                imageBuilder: (final BuildContext context,
                                    final ImageProvider<Object> imageProvider) {
                                  return Container(
                                    padding: EdgeInsets.all(4),
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.colorB1D2E3,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(14),
                                      child: Image(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                errorWidget: (final BuildContext context,
                                    final String url, final Object error) {
                                  return _userProfilePlaceholder();
                                },
                                placeholder: (final BuildContext context,
                                    final String url) {
                                  return _userProfilePlaceholder();
                                },
                              ),
                              Gap(15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${controller.sharedPreferenceHelper.user?.firstName ?? ''} ${controller.sharedPreferenceHelper.user?.lastName ?? ''}',
                                      softWrap: true,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: mullerW700.copyWith(
                                          fontSize: 18,
                                          color: AppColors.color1D1D1D),
                                    ),
                                    Gap(8),
                                    Text(
                                      '${controller.sharedPreferenceHelper.user?.email ?? ''}',
                                      style: mullerW400.copyWith(
                                          fontSize: 14,
                                          color: AppColors.color757474),
                                    )
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Get.toNamed(RouteHelper.profileDetail);
                                },
                                icon: SvgPicture.asset(
                                  Assets.svg.icRightArrowRound,
                                  height: 20,
                                  width: 20,
                                  matchTextDirection: true,
                                  colorFilter: ColorFilter.mode(
                                      AppColors.color1679AB, BlendMode.srcIn),
                                ),
                              )
                            ],
                          ),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              UserDefaultAvatar(
                                border: Border.all(
                                    color: AppColors.colorDCE4E7, width: 2),
                              ),
                              Gap(5.0),
                              Text(
                                'Guest User'.tr,
                                style: mullerW500.copyWith(
                                  color: AppColors.color12658E,
                                  fontSize: 18.0,
                                ),
                              ),
                              Gap(20.0),
                              ElevatedButton(
                                child: Text(
                                  "${'Login'.tr}/ ${'Sign Up'.tr}",
                                  style: mullerW700.copyWith(
                                    fontSize: 16,
                                    color: AppColors.white,
                                  ),
                                ),
                                onPressed: () {
                                  Get.toNamed(RouteHelper.login);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.color3D8FB9,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 24),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                            ],
                          ),
                        ),
                  Gap(40),
                  Text(
                    'My Account'.tr,
                    style: mullerW500.copyWith(
                        fontSize: 16, color: AppColors.color1D1D1D),
                  ),
                  Gap(10),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder:
                          (final BuildContext context, final int index) {
                        return ProfileScreenOptionsWidget(
                            svgImage: controller.profileOptionList[index].item1,
                            optionTitle:
                                controller.profileOptionList[index].item2.tr,
                            onTap: controller.profileOptionList[index].item3);
                      },
                      separatorBuilder:
                          (final BuildContext context, final int index) => Gap(
                        10,
                      ), // h
                      itemCount: controller.profileOptionList.length,
                    ),
                  ),
                  Gap(10),
                ],
              ),
            );
          }),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentSelectedIndex: 3,
          isStoreCreated: Get.find<UserProfileController>()
                  .sharedPreferenceHelper
                  .user
                  ?.vendorStoreExist ??
              false,
        ),
      ),
    );
  }

  Widget _userProfilePlaceholder() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: UserDefaultAvatar(
        border: Border.all(color: AppColors.colorB1D2E3, width: 2),
      ),
    );
  }
}
