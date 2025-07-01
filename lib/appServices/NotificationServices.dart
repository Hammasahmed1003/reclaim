import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:reclaim/appServices/getRouteNames.dart';
import 'package:flutter/material.dart';

class NotificationService extends GetxService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // FCM Messaging instance
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  // Initialize notifications and FCM
  Future<void> init() async {
    // Initialize local notifications
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher'); // App icon

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      // iOS: IOSInitializationSettings(),
      // iOS Initialization Settings
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    // Request permission for iOS
    await requestNotificationPermission();

    // Get the FCM token
    await getFCMToken();

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message received: ${message.notification}');
      _showNotification(message.notification);
    });

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle terminated state notifications
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification caused app to open: ${message.notification}');
      _navigateToPostDetails(message);
    });
  }

  // Handle background messages
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Handling background message: ${message.messageId}");
    _showNotification(message.notification);
  }

  // Show notification on foreground, background, or terminated state
  Future<void> _showNotification(RemoteNotification? notification) async {
    if (notification != null) {
      const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      );

      const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
      );

      await flutterLocalNotificationsPlugin.show(
        0,
        notification.title,
        notification.body,
        notificationDetails,
      );
    }
  }

  // Request permission for notifications (iOS)
  Future<void> requestNotificationPermission() async {
    final NotificationSettings settings =
        await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted notification permissions");
    } else {
      print("User denied notification permissions");
    }
  }

  // Get the FCM token
  Future<void> getFCMToken() async {
    String? token = await firebaseMessaging.getToken();
    print("FCM Token: $token");
    // You can send this token to your server or store it
  }

  // Navigate to a specific screen when the user taps on a notification
  Future<void> _navigateToPostDetails(RemoteMessage message) async {
    if (message.data['postId'] != null) {
      String postId = message.data['postId'];
      Get.toNamed(GetRouteNames.PostDetailScreen, arguments: postId);
    }
  }

  // Handle notification click action
  Future<void> onSelectNotification(String? payload) async {
    if (payload != null) {
      print('Notification Payload: $payload');
      // Here you can implement your redirection logic
      Get.toNamed(GetRouteNames.PostDetailScreen, arguments: payload);
    }
  }
}
