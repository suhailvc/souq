import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomeNavigationBarWidget extends StatelessWidget {
  const HomeNavigationBarWidget(
      {super.key, required this.sharedPreferenceHelper});

  final SharedPreferenceHelper sharedPreferenceHelper;

  @override
  Widget build(final BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Welcome,'.tr,
                style: mullerW400.copyWith(color: AppColors.color1679AB),
              ),
              Gap(5.0),
              Text(
                '${sharedPreferenceHelper.user?.firstName ?? ''} ${sharedPreferenceHelper.user?.lastName ?? ''}',
                softWrap: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: mullerW700.copyWith(
                    color: AppColors.color1D1D1D, fontSize: 18),
              ),
            ],
          ),
        ),
        SouqCart.icon(),
        Gap(10),
        InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            Get.toNamed(Get.find<SharedPreferenceHelper>().isLoggedIn
                ? RouteHelper.notificationList
                : RouteHelper.login);
          },
          child: SvgPicture.asset(Assets.svg.icNotification),
        ),
      ],
    ).paddingSymmetric(horizontal: 16.0);
  }
}
