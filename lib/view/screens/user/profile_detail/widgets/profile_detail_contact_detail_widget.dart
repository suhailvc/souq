import 'package:atobuy_vendor_flutter/controller/user/user_controller.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProfileDetailContactDetailWidget extends StatelessWidget {
  const ProfileDetailContactDetailWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<UserProfileController>(
        builder: (final UserProfileController controller) {
      return Container(
        width: Get.width,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  'Address'.tr,
                  style: mullerW400.copyWith(
                    color: AppColors.color757474,
                    fontSize: 12,
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  child: Text(
                    'Edit'.tr,
                    style: mullerW500.copyWith(
                      fontSize: 12,
                      color: AppColors.white,
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed(RouteHelper.editAddress,
                        arguments: <String, String>{
                          'come_from': UserProfileFromPage.personal.name
                        });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.color3D8FB9,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    minimumSize: Size.zero,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                )
              ],
            ),
            Text(
              controller.userAddress,
              style: mullerW500.copyWith(
                color: AppColors.color1D1D1D,
                fontSize: 16,
              ),
            ),
            Gap(12),
            Text(
              'Mobile Number'.tr,
              style: mullerW400.copyWith(
                color: AppColors.color757474,
                fontSize: 12,
              ),
            ),
            Gap(6),
            Text(
              controller.userProfile.contactNumber ?? '-',
              style: mullerW500.copyWith(
                color: AppColors.color1D1D1D,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    });
  }
}