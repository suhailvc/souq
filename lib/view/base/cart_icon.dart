import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

ValueNotifier<int> souqCartCount = ValueNotifier<int>(0);
ValueNotifier<Widget> souqCartWidget = ValueNotifier<Widget>(const SizedBox());
ValueNotifier<Color> souqCartCountColor =
    ValueNotifier<Color>(const Color(0xff000000));
ValueNotifier<Color> souqCartCountBackgroundColor =
    ValueNotifier<Color>(const Color(0xff000000));

class SouqCart with ChangeNotifier {
  static void initSouqCart({
    required final Widget child,
    required final int cartCount,
    required final Color cartBadgeTextColor,
    required final Color cartBadgeBackgroundColor,
  }) {
    souqCartCount.value = cartCount;
    souqCartCount.notifyListeners();
    souqCartWidget.value = child;
    souqCartWidget.notifyListeners();
    souqCartCountColor.value = cartBadgeTextColor;
    souqCartCountColor.notifyListeners();
    souqCartCountBackgroundColor.value = cartBadgeBackgroundColor;
    souqCartCountBackgroundColor.notifyListeners();
  }

  static Widget icon() {
    return Center(
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          Get.toNamed(Get.find<SharedPreferenceHelper>().isLoggedIn
              ? RouteHelper.cart
              : RouteHelper.login);
        },
        child: ValueListenableBuilder<int>(
          valueListenable: souqCartCount,
          builder: (final BuildContext context, final int cartCountValue,
              final Widget? child) {
            return cartCountValue == 0
                ? souqCartWidget.value
                : badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -12, end: -5),
                    badgeContent: Text(
                      '$cartCountValue',
                      style: mullerW400.copyWith(
                          color: souqCartCountColor.value, fontSize: 12),
                    ),
                    child: souqCartWidget.value,
                    badgeStyle: badges.BadgeStyle(
                      badgeColor: souqCartCountBackgroundColor.value,
                    ),
                    badgeAnimation: badges.BadgeAnimation.rotation(
                      toAnimate: false,
                    ),
                  );
          },
        ),
      ),
    );
  }

  static void add() {
    souqCartCount.value = souqCartCount.value + 1;
    souqCartCount.notifyListeners();
  }

  static void remove() {
    if (souqCartCount.value > 0) {
      souqCartCount.value = souqCartCount.value - 1;
      souqCartCount.notifyListeners();
    }
  }

  static void update({required final int newCartCount}) {
    souqCartCount.value = newCartCount;
    souqCartCount.notifyListeners();
  }

  static void clear() {
    souqCartCount.value = 0;
    souqCartCount.notifyListeners();
  }
}
