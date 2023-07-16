//
// import 'dart:convert';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:rklawfirm/resource/session_string.dart';
// import 'package:rklawfirm/route/route.dart';
// import 'package:rklawfirm/shared/get_storage_repository.dart';
//
// Future<void> handleBackgroundMessage(RemoteMessage message) async {
//   print('Title: ${message.notification?.title}');
//   print('Body: ${message.notification?.body}');
//   print('Payload: ${message.data}');
// }
//
// class FirebaseApi {
//    //final GetStorageRepository getStorageRepository;
//   //FirebaseApi(this.getStorageRepository);
//   final _firebaseMessaging = FirebaseMessaging.instance;
//
//   final _androidChannel = const AndroidNotificationChannel(
//     'high_importance_channel',
//     'High Importance Notification',
//     description: 'This channel is used for important notification',
//     importance: Importance.defaultImportance
//   );
//
//   final localNotifications = FlutterLocalNotificationsPlugin();
//   //FirebaseApi(this.getStorageRepository);
//
//   void handleMessage(RemoteMessage? message){
//     if(message == null) return;
//
//     Get.toNamed(AppRoute.notification,arguments: [message.notification!.title,message.notification!.body,message.data]);
//   }
//
//   Future initLocalNotification() async {
//     const iOS = IOSInitializationSettings();
//     const android = AndroidInitializationSettings("defaultIcon");
//     const settings = InitializationSettings(android: android,iOS: iOS);
//
//     await localNotifications.initialize(
//       settings,
//       onSelectNotification: (payload) {
//         final message = RemoteMessage.fromMap(jsonDecode(payload!));
//         handleMessage(message);
//       }
//     );
//
//     final platform = localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
//     await platform?.createNotificationChannel(_androidChannel);
//   }
//   Future initPushNotifications() async  {
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//     FirebaseMessaging.onMessage.listen((message) {
//       final notification = message.notification;
//       if(notification == null) return;
//       localNotifications.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//                 _androidChannel.id,
//                 _androidChannel.name,
//                 channelDescription: _androidChannel.description,
//
//             )
//           ),
//         payload: jsonEncode(message.toMap()),
//           );
//     });
//   }
//   Future<void> initNotification() async {
//     await _firebaseMessaging.requestPermission();
//     final fCMToken = await _firebaseMessaging.getToken();
//     print('Token: $fCMToken');
//
//     initPushNotifications();
//     initLocalNotification();
//   }
//
//
// }