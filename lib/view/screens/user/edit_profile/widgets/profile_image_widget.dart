import 'dart:io';

import 'package:atobuy_vendor_flutter/controller/user/user_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/user_default_avatar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EditProfileImageWidget extends StatelessWidget {
  const EditProfileImageWidget({super.key, this.onTapEditProfileImage});

  final Function()? onTapEditProfileImage;
  @override
  Widget build(final BuildContext context) {
    return GetBuilder<UserProfileController>(
        builder: (final UserProfileController controller) {
      return InkWell(
        splashColor: Colors.transparent,
        onTap: onTapEditProfileImage,
        child: SizedBox(
          height: 130,
          width: 130,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Positioned(
                  top: 0,
                  child: controller.selectedImage.isNotEmpty
                      ? Utility.checkIsNetworkUrl(controller.selectedImage)
                          ? CachedNetworkImage(
                              imageUrl: controller.selectedImage,
                              imageBuilder: (final BuildContext context,
                                  final ImageProvider<Object> imageProvider) {
                                return Container(
                                  padding: EdgeInsets.all(3.43),
                                  height: 113,
                                  width: 113,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.colorDCE4E7, width: 2),
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
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    padding: EdgeInsets.all(3.43),
                                    height: 113,
                                    width: 113,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.colorDCE4E7,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: UserDefaultIcon(size: 100),
                                  ),
                                );
                              },
                            )
                          : Container(
                              padding: EdgeInsets.all(3.43),
                              height: 113,
                              width: 113,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.colorDCE4E7, width: 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  fit: BoxFit.cover,
                                  File(controller.selectedImage),
                                ),
                              ),
                            )
                      : Container(
                          padding: EdgeInsets.all(3.43),
                          height: 113,
                          width: 113,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.colorDCE4E7, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: UserDefaultIcon(
                            size: 80,
                          ),
                        )),
              Positioned(
                bottom: -5,
                child: IconButton(
                  onPressed: onTapEditProfileImage,
                  icon: SvgPicture.asset(Assets.svg.icCamera),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
