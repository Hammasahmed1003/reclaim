import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:reclaim/appServices/getRouteNames.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// class NotificationService extends GetxService {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

//   Future<void> init() async {
//     print("🔧 Initializing NotificationService...");

//     // Local notification init
//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: androidInitializationSettings,
//       // Add iOS if needed
//     );

//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       // onSelectNotification: onSelectNotification,
//     );

//     print("🔔 Local notifications initialized.");

//     await requestNotificationPermission();
//     await getFCMToken();

//     // Foreground message
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print("📲 Foreground FCM message received:");
//       print("🧾 Full Message: ${message.toMap()}");

//       RemoteNotification? notification = message.notification;

//       // If backend sent only data message
//       if (notification == null && message.data.isNotEmpty) {
//         print(
//             "📝 Data-only message in foreground. Constructing manual notification.");
//         notification = RemoteNotification(
//           title: message.data['title'],
//           body: message.data['body'],
//         );
//       }

//       _showNotification(notification);
//     });

//     // When app is in background and notification is clicked
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print("📦 App opened from background notification");
//       print("🧾 Full Message: ${message.toMap()}");
//       _navigateToPostDetails(message);
//     });

//     // Register background handler
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//     print("✅ NotificationService initialization complete.");
//   }

//   // Background handler (top-level function required!)
//   static Future<void> _firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     print("🌙 Background FCM message received:");
//     print("🧾 Full Message: ${message.toMap()}");

//     RemoteNotification? notification = message.notification;

//     if (notification == null && message.data.isNotEmpty) {
//       print(
//           "📝 Data-only background message. Constructing manual notification.");
//       notification = RemoteNotification(
//         title: message.data['title'],
//         body: message.data['body'],
//       );
//     }

//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();

//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//       'channel_id',
//       'channel_name',
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );

//     const NotificationDetails details = NotificationDetails(
//       android: androidDetails,
//     );

//     if (notification != null) {
//       await flutterLocalNotificationsPlugin.show(
//         0,
//         notification.title,
//         notification.body,
//         details,
//       );
//     }
//   }

//   // Show notification in foreground
//   Future<void> _showNotification(RemoteNotification? notification) async {
//     if (notification == null) {
//       print("⚠️ No notification to show.");
//       return;
//     }

//     print("📤 Showing local notification:");
//     print("🔸 Title: ${notification.title}");
//     print("🔹 Body: ${notification.body}");

//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//       'channel_id',
//       'channel_name',
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );

//     const NotificationDetails details = NotificationDetails(
//       android: androidDetails,
//     );

//     await flutterLocalNotificationsPlugin.show(
//       0,
//       notification.title,
//       notification.body,
//       details,
//     );
//   }

//   Future<void> requestNotificationPermission() async {
//     final NotificationSettings settings =
//         await firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     print(
//         "🔐 Notification permissions status: ${settings.authorizationStatus}");

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print("✅ User granted permission.");
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       print("🔄 User granted provisional permission.");
//     } else {
//       print("❌ User declined or has not accepted permission.");
//     }
//   }

//   Future<void> getFCMToken() async {
//     try {
//       String? token = await firebaseMessaging.getToken();
//       print("📱 FCM Token: $token");
//       // Save or send to backend here
//     } catch (e) {
//       print("❗ Error getting FCM Token: $e");
//     }
//   }

//   // Navigate based on postId in notification data
//   Future<void> _navigateToPostDetails(RemoteMessage message) async {
//     try {
//       final data = message.data;
//       if (data.containsKey('postId')) {
//         final postId = data['postId'];
//         print("➡️ Navigating to post with ID: $postId");
//         Get.toNamed(GetRouteNames.PostDetailScreen, arguments: postId);
//       } else {
//         print("ℹ️ No postId in notification data.");
//       }
//     } catch (e) {
//       print("❗ Error navigating from notification: $e");
//     }
//   }

//   // When user taps local notification
//   Future<void> onSelectNotification(String? payload) async {
//     print("👆 Notification clicked with payload: $payload");
//     if (payload != null) {
//       // Optionally navigate based on payload
//     }
//   }

//   // for evening Recollect Notification(),

//   Future<void> scheduleEveningRecollectNotification() async {
//     print("📆 Scheduling Evening Recollect Notification...");

//     final now = DateTime.now();
//     DateTime scheduledTime = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       19, // 7 PM
//       0,
//       0,
//     );

//     if (now.isAfter(scheduledTime)) {
//       // If it's already past 7 PM today, schedule for tomorrow
//       scheduledTime = scheduledTime.add(const Duration(days: 1));
//     }

//     print("🔔 Will notify at: $scheduledTime");

//     const androidDetails = AndroidNotificationDetails(
//       'evening_recollect_channel',
//       'Evening Recollect',
//       channelDescription: 'Notify user when Evening Recollect is available',
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );

//     const notificationDetails = NotificationDetails(android: androidDetails);

//     // await flutterLocalNotificationsPlugin.zonedSchedule(

//     //   1,
//     //   'Evening Recollect Available',
//     //   'Tap to reflect on your day!',
//     //   tz.TZDateTime.from(scheduledTime, tz.local),
//     //   notificationDetails,

//     //   // androidAllowWhileIdle: true,

//     //   uiLocalNotificationDateInterpretation:
//     //       UILocalNotificationDateInterpretation.absoluteTime,
//     //   matchDateTimeComponents: DateTimeComponents.time, // triggers daily
//     // );
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       1,
//       'Evening Recollect Available Now',
//       'Claim Now',
//       tz.TZDateTime.from(scheduledTime, tz.local),
//       notificationDetails,
//       androidScheduleMode:
//           AndroidScheduleMode.exactAllowWhileIdle, // ✅ Required now
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.time,
//     );

//     print("✅ Notification scheduled successfully.");
//   }
// }

class NotificationService extends GetxService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    print("🔧 Initializing NotificationService...");

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: iosInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print("👆 Local notification tapped: ${response.payload}");
        if (response.payload != null) {
          final postId = response.payload;
          print("➡️ Navigating to post with ID (payload): $postId");
          Get.toNamed(GetRouteNames.PostDetailScreen, arguments: postId);
        }
      },
    );

    print("🔔 Local notifications initialized.");

    await requestNotificationPermission();
    await getFCMToken();

    // Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📲 Foreground FCM message received:");
      print("🧾 Full Message: ${message.toMap()}");

      RemoteNotification? notification = message.notification;

      if (notification == null && message.data.isNotEmpty) {
        print("📝 Data-only message. Creating manual notification.");
        notification = RemoteNotification(
          title: message.data['title'],
          body: message.data['body'],
        );
      }

      final postId = message.data['related_id'];
      _showNotification(notification, postId);
    });

    // Background (when tapped)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("📦 App opened from background notification");
      print("🧾 Full Message: ${message.toMap()}");
      _navigateToPostDetails(message);
    });

    // Background handler registration
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // App launched via terminated notification
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      print("🚀 App launched from terminated state via notification");
      _navigateToPostDetails(initialMessage);
    }

    print("✅ NotificationService initialization complete.");
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("🌙 Background FCM message received:");
    print("🧾 Full Message: ${message.toMap()}");

    RemoteNotification? notification = message.notification;

    if (notification == null && message.data.isNotEmpty) {
      print("📝 Data-only background message. Creating manual notification.");
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
      final postId = message.data['related_id'];
      await flutterLocalNotificationsPlugin.show(
        0,
        notification.title,
        notification.body,
        details,
        payload: postId,
      );
    }
  }

  Future<void> _showNotification(
      RemoteNotification? notification, String? postId) async {
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
      payload: postId,
    );
  }

  Future<void> _navigateToPostDetails(RemoteMessage message) async {
    try {
      final data = message.data;
      if (data.containsKey('related_id') && data['related_type'] == 'Post') {
        final postId = data['related_id'];
        print("➡️ Navigating to post with ID: $postId");
        Get.toNamed(GetRouteNames.PostDetailScreen, arguments: postId);
      } else {
        print("ℹ️ Notification doesn't relate to a post.");
      }
    } catch (e) {
      print("❗ Error navigating from notification: $e");
    }
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
    } catch (e) {
      print("❗ Error getting FCM Token: $e");
    }
  }

  Future<void> scheduleEveningRecollectNotification() async {
    print("📆 Scheduling Evening Recollect Notification...");

    final now = DateTime.now();
    DateTime scheduledTime = DateTime(
      now.year,
      now.month,
      now.day,
      19, // 7 PM
      0,
      0,
    );

    if (now.isAfter(scheduledTime)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }

    print("🔔 Will notify at: $scheduledTime");

    const androidDetails = AndroidNotificationDetails(
      'evening_recollect_channel',
      'Evening Recollect',
      channelDescription: 'Notify user when Evening Recollect is available',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      1,
      'Evening Recollect Available Now',
      'Claim Now',
      tz.TZDateTime.from(scheduledTime, tz.local),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    print("✅ Notification scheduled successfully.");
  }
}
