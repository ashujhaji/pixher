import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../screens/home/home.dart';

class NotificationHandler {
  NotificationHandler._privateConstructor();

  static BuildContext? context; // To handle on tap of notification.
  static final NotificationHandler instance =
      NotificationHandler._privateConstructor();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettings;

  /// Create a [AndroidNotificationChannel] for heads up notifications
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  void listenForMessages() {
    if (Platform.isIOS) {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
    initializePlatformSpecifics();
    // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    sendNotification();
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      // Save newToken ** Not Required as of now.
    });
  }

  void sendNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: (payload) async {
        onNotificationClick(payload, message.notification?.title);
      });

      // * Note: As price alert is fullfilled remove it from the list.

      showNotification(notification);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // TODO: On click of notification route to price alert related app screen.
      // * To be done using context i.e after calling the NotificationHandler in the
      // * HomePage initState.
      if (context != null) {
        Navigator.of(context!).pushNamed(HomePage.tag);
      }
    });
    FirebaseMessaging.onBackgroundMessage((message) async {
      RemoteNotification? notification = message.notification;
      showNotification(notification);
    });
  }

  void showNotification(RemoteNotification? notification) async {
    try {
      if (notification != null) {}
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  initializePlatformSpecifics() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        // RemoteNotification notification = message.notification;
        // AndroidNotification android = message.notification?.android;
        flutterLocalNotificationsPlugin.initialize(initializationSettings,
            onSelectNotification: (payload) async {
          onNotificationClick(payload, title);
        });

        flutterLocalNotificationsPlugin.show(
          id,
          title,
          body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              importance: Importance.max,
              priority: Priority.high,
              playSound: true,
              styleInformation: const DefaultStyleInformation(true, true),
              icon: '@mipmap/ic_launcher',
            ),
            iOS: const IOSNotificationDetails(
              presentAlert: true,
              presentSound: true,
              presentBadge: true,
            ),
          ),
          payload: payload,
        );

        // your call back to the UI
      },
    );
    initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  }

  Future<String?> getToken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      print('firebase token,$token');
      return token;
    } catch (e) {
      return '';
    }
  }

  void requestForPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      listenForMessages();
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void onNotificationClick(String? payload, String? title) {
    Navigator.of(context!).pushNamed(HomePage.tag);
  }
}
