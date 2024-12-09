import 'dart:io';

import 'package:atobuy_vendor_flutter/app/app.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/get_di.dart' as di;
import 'package:atobuy_vendor_flutter/helper/push_notification/notification_service.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/cart_icon.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> firebaseMessagingBackgroundHandler(
    final RemoteMessage message) async {
  debugPrint('Handling a background message: ${message.messageId}');
  debugPrint(message.notification?.title);
  debugPrint(message.notification?.body);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  if (Platform.isIOS) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: AppConstants.firebaseApiKey,
          appId: AppConstants.firebaseAppId,
          messagingSenderId: AppConstants.firebaseMessageSenderId,
          projectId: AppConstants.firebaseProjectId),
    );
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: AppConstants.firebaseAndroidApiKey,
        appId: AppConstants.firebaseAndroidAppId,
        messagingSenderId: AppConstants.firebaseAndroidMsgSenderId,
        projectId: AppConstants.firebaseAndroidProjectId,
      ),
    );
  }
  await NotificationService().setupInteractedMessage();

  await Permission.notification.isDenied.then(
    (final bool value) {
      if (value) {
        if (Platform.isAndroid) {
          Permission.notification.request();
        } else {
          // TODO: will use latter on
          // Future<void>.delayed(Duration(milliseconds: 500), () {
          //   _showNotificationPermissionAlert();
          // });
        }
      }
    },
  );

  SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp]);

  SouqCart.initSouqCart(
      child: SvgPicture.asset(
        Assets.svg.icCart,
        matchTextDirection: true,
      ),
      cartCount: 0,
      cartBadgeTextColor: AppColors.color1D1D1D,
      cartBadgeBackgroundColor: Colors.red);
  runApp(
    AtoBuyVendorApp(),
  );
}

void _showNotificationPermissionAlert() {
  if (Get.context == null) {
    return;
  }
  showCupertinoDialog(
    context: Get.context!,
    builder: (final BuildContext context) {
      return CupertinoAlertDialog(
        title: Text('Notification Permission'
            .trParams(<String, String>{'app_name': '${AppConstants.appName}'})),
        actions: <Widget>[
          CupertinoDialogAction(
            textStyle: mullerW400.copyWith(color: Colors.blueAccent),
            child: Text('Cancel'.tr),
            onPressed: () {
              Get.back();
            },
          ),
          CupertinoDialogAction(
            textStyle: mullerW500.copyWith(color: Colors.blueAccent),
            child: Text('Settings'.tr),
            onPressed: () {
              openAppSettings();
              Get.back();
            },
          ),
        ],
      );
    },
  );
}
