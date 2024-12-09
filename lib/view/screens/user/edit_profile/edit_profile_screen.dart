import 'package:atobuy_vendor_flutter/controller/user/user_controller.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/edit_profile/widgets/edit_profile_form_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/edit_profile/widgets/profile_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: GetBuilder<UserProfileController>(
            initState: (final GetBuilderState<UserProfileController> state) {
          Get.find<UserProfileController>().resetData();
        }, builder: (final UserProfileController controller) {
          return Scaffold(
            appBar: AppbarWithBackIconAndTitle(
              title: 'Edit Profile'.tr,
            ),
            body: Column(
              children: <Widget>[
                Gap(24.0),
                EditProfileImageWidget(
                  onTapEditProfileImage: () {
                    controller.onProfileImageUpdate();
                  },
                ),
                EditProfileFormWidget(),
                CommonButton(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    controller.onSaveProfileChanges();
                  },
                  title: 'Save Changes'.tr,
                ),
                Gap(MediaQuery.of(context).padding.bottom > 0
                    ? MediaQuery.of(context).padding.bottom
                    : 16)
              ],
            ).paddingSymmetric(horizontal: 16.0),
          );
        }),
      ),
    );
  }
}
