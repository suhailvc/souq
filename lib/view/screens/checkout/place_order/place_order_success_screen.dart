import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PlaceOrderSuccessScreen extends StatelessWidget {
  PlaceOrderSuccessScreen({
    super.key,
  });

  AudioPlayer player = AudioPlayer();

  @override
  Widget build(final BuildContext context) {
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);

    WidgetsBinding.instance
        .addPostFrameCallback((final Duration duration) async {
      // Sound file from Assets gen not working here
      await player.setSource(AssetSource('sounds/success.mp3'));
      await player.resume();
    });
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: PopScope(
        canPop: false,
        onPopInvoked: (final bool didPop) async {
          if (didPop) return;
          Get.offAllNamed(
            (Get.find<SharedPreferenceHelper>().user?.vendorStoreExist ?? false)
                ? RouteHelper.home
                : RouteHelper.shop,
          );
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Gap(172),
                  SvgPicture.asset(Assets.svg.icAccountCreated),
                  Gap(20),
                  Text(
                    'Order Placed\nSuccessfully.'.tr,
                    textAlign: TextAlign.center,
                    style: mullerW500.copyWith(
                        fontSize: 28, color: AppColors.color2E236C),
                  ),
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: CommonButton(
                        onTap: () {
                          player.stop();
                          Get.offAllNamed(
                            (Get.find<SharedPreferenceHelper>()
                                        .user
                                        ?.vendorStoreExist ??
                                    false)
                                ? RouteHelper.home
                                : RouteHelper.shop,
                          );
                        },
                        title: 'Continue To Dashboard'.tr,
                      ).paddingOnly(bottom: 20.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
