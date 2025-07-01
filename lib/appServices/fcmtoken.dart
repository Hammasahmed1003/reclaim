import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../firebase_options.dart'; // Replace with your actual Firebase options file

class FirebaseDB {
  static Future<void> init() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      print("Firebase initialized 🔥✅");

      // Subscribe to a topic (optional)
      FirebaseMessaging.instance.subscribeToTopic('subscription');

      // Get FCM Token
      final fcmToken = await FirebaseMessaging.instance.getToken();
      print("FCM Token: $fcmToken");

      // Get Device Info
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.androidInfo;
      print("Device ID: ${deviceInfo.id}");

      // Save Token and Device ID to Storage
      // LocalDataStorage().insertDeviceAndFCMInformation(
      //   FcmToken: fcmToken,
      //   deviceID: deviceInfo.id,
      // );

      FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {});

      // Handle Foreground Notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("Foreground Notification: ${message.notification?.title}");
        print("Foreground Notification: ${message.notification?.body}");
        print("Foreground Notification: ${message.data}");
        // LocalNotificationService.display(message);
      });

      // Handle Background Notifications
      FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);

      // Handle Notifications Clicked (when app is in background/terminated)
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print("Notification Clicked: ${message.notification?.title}");
        // LocalNotificationService.getInstance.handleNotification(message.data);
      });

      // Handle Initial Notification (when app is opened via a notification)
      final initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        print(
            "Notification from Terminated State: ${initialMessage.notification?.title}");
        print('Notification from Terminated State');
        // Fluttertoast.showToast(msg: 'Notification from Terminated State');
        // await await LocalNotificationService.getInstance
        //     .handleNotification(initialMessage.data);
      }
    } catch (e) {
      print("Error initializing Firebase: $e");
    }
  }

  static Future<void> _onBackgroundMessage(RemoteMessage message) async {
    print("Background Notification: ${message.notification?.title}");
  }
}
