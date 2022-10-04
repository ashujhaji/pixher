import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pixer/util/dictionary.dart';

import '../screens/home/home.dart';
import '../util/navigation_helper.dart';

class NotificationService {
  NotificationService._privateConstructor();

  static final NotificationService instance =
      NotificationService._privateConstructor();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Create a [AndroidNotificationChannel] for heads up notifications
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  /// Notification Data Payload definition
  static const _kOpenTemplateCategory = 'OpenTemplateCategory';
  static const _kOpenTemplate = 'OpenTemplate';
  static const _kOpenHahstagSuggestion = 'OpenHahstagSuggestion';
  static const _kOpenWebInsideApp = 'OpenWebInsideApp';
  static const _kOpenWebOutsideApp = 'OpenWebOutsideApp';

  void listenForMessages(BuildContext? context) {
    InitializationSettings initializationSettings;
    if (Platform.isIOS) {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      initializationSettings = InitializationSettings(
        iOS: IOSInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          onDidReceiveLocalNotification: (id, title, body, payload) async {
            onNotificationClick(payload, context);
          },
        ),
      );
    } else {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
      initializationSettings = const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      );
    }
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (payload) async {
      onNotificationClick(payload, context);
    });
    startListeningNotifications();
  }

  void startListeningNotifications() {
    //Foreground message handling
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //TODO : Handle notification click
    });

    //Background message handling
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      showNotification(message);
    });
  }

  void showNotification(RemoteMessage? message) async {
    if (message == null) return;
    if (message.notification == null) return;
    if (message.notification!.title == null) return;
    final largeImage = message.data['image'];
    flutterLocalNotificationsPlugin.show(
      message.notification.hashCode,
      message.notification!.title,
      message.notification!.body.toString(),
      NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
            channelDescription: channel.description,
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            styleInformation: const DefaultStyleInformation(true, true),
            icon: '@mipmap/ic_launcher',
            largeIcon:
                largeImage == null ? null : FilePathAndroidBitmap(largeImage)),
        iOS: const IOSNotificationDetails(
          presentAlert: true,
          presentSound: true,
          presentBadge: true,
        ),
      ),
      payload: message.data.toString(),
    );
  }

  Future<String?> getToken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      debugPrint('firebase token,$token');
      return token;
    } catch (e) {
      return '';
    }
  }

  Future<bool> requestForPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  void onNotificationClick(String? data, BuildContext? context) {
    if (data == null) return;
    if (context == null) return;
    List<String> str = data.replaceAll("{", "").replaceAll("}", "").split(",");
    Map<String, dynamic> payload = {};
    for (int i = 0; i < str.length; i++) {
      List<String> s = str[i].split(":");
      payload.putIfAbsent(s[0].trim(), () => s[1].trim());
    }
    final todo = payload['TODO'];
    switch (todo) {
      case _kOpenTemplateCategory:
        {
          final categoryId = payload['category_id'];
          final templateType = payload['template_type'];
          if (templateType == null) return;
          final dimension = TemplateDimension.fromName(templateType);
          if (categoryId == null) return;
          NavigationHelper.instance
              .onOpenCategory(context, dimension, categoryId);
          break;
        }
      case _kOpenTemplate:
        {
          final templateId = payload['template_id'];
          final templateType = payload['template_type'];
          if (templateType == null) return;
          if (templateId == null) return;
          final dimension = TemplateDimension.fromName(templateType);
          NavigationHelper.instance
              .onOpenTemplate(context, dimension, templateId);
          break;
        }
      case _kOpenHahstagSuggestion:
        {
          break;
        }
      case _kOpenWebInsideApp:
        {
          break;
        }
      case _kOpenWebOutsideApp:
        {
          break;
        }
      default:
        {
          Navigator.of(context).pushNamed(HomePage.tag);
          break;
        }
    }
  }
}
