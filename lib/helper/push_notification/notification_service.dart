import 'dart:convert';
import 'dart:io';

import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/main.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationService {
  static FirebaseMessaging ms = FirebaseMessaging.instance;
  final SharedPreferenceHelper sharedPref = Get.find<SharedPreferenceHelper>();
  final GlobalController globalController = Get.find<GlobalController>();
  late AndroidNotificationChannel androidChannel;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> setupInteractedMessage() async {
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
          messagingSenderId: AppConstants.firebaseMessageSenderId,
          projectId: AppConstants.firebaseProjectId,
        ),
      );
    }
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    FirebaseMessaging.onMessageOpenedApp.listen((final RemoteMessage message) {
      debugPrint('onMessageOpenedApp: ${message.data}');
    });

    apnsPermission();
    getFCMToken();
    enableIOSNotifications();
    androidChannel = androidNotificationChannel();
    await registerNotificationListeners();

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  void getFCMToken() {
    FirebaseMessaging.instance.onTokenRefresh.listen((final String newToken) {
      debugPrint('New FCM token--=-=-=-=-=->> $newToken');

      if (sharedPref.fcmToken != newToken) {
        sharedPref.saveFcmToken(newToken);
        final String? authToken = sharedPref.authToken;
        if (sharedPref.isLoggedIn &&
            authToken != null &&
            authToken.isNotEmpty) {}
      }
      if (sharedPref.isLoggedIn) {
        globalController.updateFCMToken(fcmToken: newToken);
      }
    });

    FirebaseMessaging.instance.getToken().then((final String? value) {
      debugPrint('FCM token--=-=-=-=-=->> $value');

      if (sharedPref.fcmToken != (value ?? '')) {
        sharedPref.saveFcmToken(value ?? '');
        final String? authToken = sharedPref.authToken;
        if (sharedPref.isLoggedIn &&
            authToken != null &&
            authToken.isNotEmpty) {}
      }
      if (sharedPref.isLoggedIn) {
        globalController.updateFCMToken(fcmToken: value ?? '');
      }
    });
  }

  Future<void> registerNotificationListeners() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@drawable/ic_notification');

    const DarwinInitializationSettings iOSSettings =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: false,
      requestAlertPermission: true,
    );

    const InitializationSettings initSettings =
        InitializationSettings(android: androidSettings, iOS: iOSSettings);

    flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (final NotificationResponse details) {
        if ((details.payload ?? '').isNotEmpty) {
          final Map<String, dynamic> messagePayload =
              json.decode((details.payload ?? ''));
          debugPrint('notification message: ${details}');
          debugPrint('onDidReceiveNotificationResponse: $messagePayload');
        }
      },
      onDidReceiveBackgroundNotificationResponse:
          (final NotificationResponse details) {
        if ((details.payload ?? '').isNotEmpty) {
          final Map<String, dynamic> messagePayload =
              json.decode(details.payload ?? '');
          debugPrint('notification message: ${details}');
          debugPrint(
              'onDidReceiveBackgroundNotificationResponse: $messagePayload');
        }
      },
    );

    FirebaseMessaging.onMessage.listen((final RemoteMessage? message) async {
      final RemoteNotification? notification = message?.notification;
      // final AndroidNotification? android = message?.notification?.android; // TODO:- will use in future
      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      debugPrint('notification Data: ${message?.data}');
      debugPrint('notification title: ${message?.notification?.title}');
      debugPrint('notification body: ${message?.notification?.body}');
      displayNotification(message);

      /**
       * Manage when open this screen reload view according to status and other notification
       * if Date listing screen is open refresh listing in background
       */
    });
  }

  Future<void> displayNotification(final RemoteMessage? message) async {
    if (message?.notification != null) {
      await flutterLocalNotificationsPlugin.show(
        message!.notification!.hashCode,
        message.notification?.title ?? 'SOUQ NO1 : New Notification',
        message.notification?.body,
        payload: jsonEncode(message.data),
        NotificationDetails(
          android: AndroidNotificationDetails(
            androidChannel.id,
            androidChannel.name,
            channelDescription: androidChannel.description,
            icon: '@drawable/ic_notification',
            sound: RawResourceAndroidNotificationSound('notification'),
          ),
          iOS: const DarwinNotificationDetails(
              sound: 'notification.wav',
              presentAlert: true,
              presentSound: true),
        ),
      );
    }
  }

  Future<void> enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  static Future<void> apnsPermission() async {
    final FirebaseMessaging messaging = FirebaseMessaging.instance;
    try {
      // ignore: unused_local_variable
      final NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  AndroidNotificationChannel androidNotificationChannel() =>
      const AndroidNotificationChannel(
        'fcm_fallback_notification_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.max,
        sound: RawResourceAndroidNotificationSound('notification'),
        playSound: true,
      );
}
