import 'package:atobuy_vendor_flutter/controller/wallet/wallet_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class WalletTopView extends StatelessWidget {
  const WalletTopView({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<WalletController>(
        builder: (final WalletController controller) {
      return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            image: DecorationImage(
              image: AssetImage(Assets.images.icTempProfile.path),
              fit: BoxFit.cover,
            )),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Your Balance'.tr,
                style: mullerW400.copyWith(color: AppColors.white),
              ),
              Gap(16),
              Text(
                controller.walletBalance?.getWalletBalance() ?? '',
                style:
                    mullerW700.copyWith(color: AppColors.white, fontSize: 32),
              ),
            ],
          ).paddingSymmetric(vertical: 40),
        ),
      );
    });
  }
}
