import 'package:atobuy_vendor_flutter/controller/user/user_controller.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/string_ext.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/user_default_avatar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProfileDetailProfileWidget extends StatelessWidget {
  const ProfileDetailProfileWidget({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<UserProfileController>(
        builder: (final UserProfileController controller) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  controller.userProfile.profileImage.isNotNullAndEmpty()
                      ? CachedNetworkImage(
                          imageUrl: controller.userProfile.profileImage ?? '',
                          imageBuilder: (final BuildContext context,
                              final ImageProvider<Object> imageProvider) {
                            return Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          errorWidget: (final BuildContext context,
                              final String url, final Object error) {
                            return UserDefaultAvatar();
                          },
                        )
                      : UserDefaultAvatar(),
                  Gap(12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          '${controller.userProfile.firstName ?? ''} ${controller.userProfile.lastName ?? ''}',
                          style: mullerW700.copyWith(
                            color: AppColors.color1D1D1D,
                            fontSize: 16,
                          ),
                        ),
                        Gap(3),
                        Text(
                          controller.userProfile.email ?? '',
                          style: mullerW400.copyWith(
                            color: AppColors.color757474,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: !(controller.userProfile.isEmailVerified ?? false),
              child: InkWell(
                onTap: () {
                  controller.isFromEmailVerification = true;
                  controller.sendOTPForEmailVerification();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Verify Email'.tr,
                    style: mullerW700.copyWith(
                        color: Colors.blue,
                        fontSize: 12,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
