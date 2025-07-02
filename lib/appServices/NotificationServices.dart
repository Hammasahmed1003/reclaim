// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:reclaim/appServices/getRouteNames.dart';
// import 'package:flutter/material.dart';

// class NotificationService extends GetxService {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   // FCM Messaging instance
//   FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

//   // Initialize notifications and FCM
//   Future<void> init() async {
//     // Initialize local notifications
//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher'); // App icon

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: androidInitializationSettings,
//       // iOS: IOSInitializationSettings(),
//       // iOS Initialization Settings
//     );

//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//     );

//     // Request permission for iOS
//     await requestNotificationPermission();

//     // Get the FCM token
//     await getFCMToken();

//     // Handle foreground messages
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Foreground message received: ${message.notification}');
//       _showNotification(message.notification);
//     });

//     // Handle background messages
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//     // Handle terminated state notifications
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('Notification caused app to open: ${message.notification}');
//       _navigateToPostDetails(message);
//     });
//   }

//   // Handle background messages
//   Future<void> _firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     print("Handling background message: ${message.messageId}");
//     _showNotification(message.notification);
//   }

//   // Show notification on foreground, background, or terminated state
//   Future<void> _showNotification(RemoteNotification? notification) async {
//     if (notification != null) {
//       const AndroidNotificationDetails androidNotificationDetails =
//           AndroidNotificationDetails(
//         'channel_id',
//         'channel_name',
//         importance: Importance.max,
//         priority: Priority.high,
//         ticker: 'ticker',
//       );

//       const NotificationDetails notificationDetails = NotificationDetails(
//         android: androidNotificationDetails,
//       );

//       await flutterLocalNotificationsPlugin.show(
//         0,
//         notification.title,
//         notification.body,
//         notificationDetails,
//       );
//     }
//   }

//   // Request permission for notifications (iOS)
//   Future<void> requestNotificationPermission() async {
//     final NotificationSettings settings =
//         await firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print("User granted notification permissions");
//     } else {
//       print("User denied notification permissions");
//     }
//   }

//   // Get the FCM token
//   Future<void> getFCMToken() async {
//     String? token = await firebaseMessaging.getToken();
//     print("FCM Token: $token");
//     // You can send this token to your server or store it
//   }

//   // Navigate to a specific screen when the user taps on a notification
//   Future<void> _navigateToPostDetails(RemoteMessage message) async {
//     if (message.data['postId'] != null) {
//       String postId = message.data['postId'];
//       Get.toNamed(GetRouteNames.PostDetailScreen, arguments: postId);
//     }
//   }

//   // Handle notification click action
//   Future<void> onSelectNotification(String? payload) async {
//     if (payload != null) {
//       print('Notification Payload: $payload');
//       // Here you can implement your redirection logic
//       // Get.toNamed(GetRouteNames.PostDetailScreen, arguments: payload);
//     }
//   }
// }

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:reclaim/appServices/getRouteNames.dart';

class NotificationService extends GetxService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    print("🔧 Initializing NotificationService...");

    // Local notification init
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      // Add iOS if needed
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: onSelectNotification,
    );

    print("🔔 Local notifications initialized.");

    await requestNotificationPermission();
    await getFCMToken();

    // Foreground message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📲 Foreground FCM message received:");
      print("🧾 Full Message: ${message.toMap()}");

      RemoteNotification? notification = message.notification;

      // If backend sent only data message
      if (notification == null && message.data.isNotEmpty) {
        print(
            "📝 Data-only message in foreground. Constructing manual notification.");
        notification = RemoteNotification(
          title: message.data['title'],
          body: message.data['body'],
        );
      }

      _showNotification(notification);
    });

    // When app is in background and notification is clicked
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("📦 App opened from background notification");
      print("🧾 Full Message: ${message.toMap()}");
      _navigateToPostDetails(message);
    });

    // Register background handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    print("✅ NotificationService initialization complete.");
  }

  // Background handler (top-level function required!)
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("🌙 Background FCM message received:");
    print("🧾 Full Message: ${message.toMap()}");

    RemoteNotification? notification = message.notification;

    if (notification == null && message.data.isNotEmpty) {
      print(
          "📝 Data-only background message. Constructing manual notification.");
      notification = RemoteNotification(
        title: message.data['title'],
        body: message.data['body'],
      );
    }

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    if (notification != null) {
      await flutterLocalNotificationsPlugin.show(
        0,
        notification.title,
        notification.body,
        details,
      );
    }
  }

  // Show notification in foreground
  Future<void> _showNotification(RemoteNotification? notification) async {
    if (notification == null) {
      print("⚠️ No notification to show.");
      return;
    }

    print("📤 Showing local notification:");
    print("🔸 Title: ${notification.title}");
    print("🔹 Body: ${notification.body}");

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      notification.title,
      notification.body,
      details,
    );
  }

  Future<void> requestNotificationPermission() async {
    final NotificationSettings settings =
        await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print(
        "🔐 Notification permissions status: ${settings.authorizationStatus}");

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("✅ User granted permission.");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("🔄 User granted provisional permission.");
    } else {
      print("❌ User declined or has not accepted permission.");
    }
  }

  Future<void> getFCMToken() async {
    try {
      String? token = await firebaseMessaging.getToken();
      print("📱 FCM Token: $token");
      // Save or send to backend here
    } catch (e) {
      print("❗ Error getting FCM Token: $e");
    }
  }

  // Navigate based on postId in notification data
  Future<void> _navigateToPostDetails(RemoteMessage message) async {
    try {
      final data = message.data;
      if (data.containsKey('postId')) {
        final postId = data['postId'];
        print("➡️ Navigating to post with ID: $postId");
        Get.toNamed(GetRouteNames.PostDetailScreen, arguments: postId);
      } else {
        print("ℹ️ No postId in notification data.");
      }
    } catch (e) {
      print("❗ Error navigating from notification: $e");
    }
  }

  // When user taps local notification
  Future<void> onSelectNotification(String? payload) async {
    print("👆 Notification clicked with payload: $payload");
    if (payload != null) {
      // Optionally navigate based on payload
    }
  }
}
