import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AppbarWithBackIconAndTitle extends StatelessWidget
    implements PreferredSizeWidget {
  const AppbarWithBackIconAndTitle({
    super.key,
    this.title = '',
    this.onBackPress,
  });
  final String title;
  final Function()? onBackPress;

  @override
  Widget build(final BuildContext context) {
    return SafeArea(
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Gap(7.0),
            IconButton(
              onPressed: onBackPress ??
                  () {
                    Get.back();
                  },
              icon: SvgPicture.asset(
                Assets.svg.icBack,
                matchTextDirection: true,
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: mullerW500.copyWith(
                    fontSize: 18,
                    color: AppColors.color1D1D1D,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: 50,
            ),
            Gap(7.0),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}

class AppbarWithTitle extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWithTitle({
    super.key,
    this.title = '',
  });

  final String title;

  @override
  Widget build(final BuildContext context) {
    return SafeArea(
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Text(
              title,
              style: mullerW500.copyWith(
                fontSize: 18,
                color: AppColors.color1D1D1D,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}

class AppbarWithBackIconTitleAndSuffixWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const AppbarWithBackIconTitleAndSuffixWidget(
      {super.key,
      required this.title,
      required this.suffixWidget,
      this.backIcon,
      this.showBackIcon});

  final String title;
  final Widget suffixWidget;
  final String? backIcon;
  final bool? showBackIcon;

  @override
  Widget build(final BuildContext context) {
    return SafeArea(
      child: Center(
        child: Row(
          children: <Widget>[
            Gap(7.0),
            Visibility(
              visible: (showBackIcon ?? true),
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: SvgPicture.asset(
                  backIcon ?? Assets.svg.icBack,
                  matchTextDirection: true,
                ),
              ),
              replacement: SizedBox(
                height: 50,
                width: 50,
              ),
            ),
            Gap(10),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: mullerW500.copyWith(
                    fontSize: 18,
                    color: AppColors.color1D1D1D,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Gap(10),
            suffixWidget,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
