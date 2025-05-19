import 'package:cosetic1/core/logger/app_logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class FcmInitializer {
  final FirebaseMessaging messaging;
  final FlutterLocalNotificationsPlugin localNotifications;

  FcmInitializer({
    required this.messaging,
    required this.localNotifications,
  });

  /// 정적 초기화 진입점
  static Future<void> initialize() async {
    final messaging = FirebaseMessaging.instance;

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    final initializer = FcmInitializer(
      messaging: messaging,
      localNotifications: flutterLocalNotificationsPlugin,
    );
    await initializer._initializeFcm();
  }

  /// 전체 초기화 로직
  Future<void> _initializeFcm() async {
    await _initializeLocalNotifications();
    await _requestPermission();
    _onMessageListener();
    _onMessageOpenedListener();
    await _checkInitialMessage();
  }

  /// 로컬 알림 초기화
  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        AppLogger.i('알림 클릭됨: ${response.payload}', tag: 'FcmInitializer');
        _handleNotificationClick(response.payload);
      },
    );
    AppLogger.i('로컬 알림 초기화 완료 (Android/iOS)', tag: 'FcmInitializer');
  }

  /// 알림 권한 요청
  Future<void> _requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      AppLogger.i('알림 권한이 허용됨', tag: 'FcmInitializer');
    } else {
      AppLogger.i('알림 권한이 거부됨', tag: 'FcmInitializer');
    }
  }

  /// Foreground 메시지 수신 처리
  void _onMessageListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final title = message.notification?.title ?? message.data['title'];
      final body = message.notification?.body ?? message.data['body'];
      AppLogger.i('Foreground 알림 수신: $title - $body', tag: 'FcmInitializer');
      _showLocalNotification(title, body, message.data['screen']);
    });
  }

  /// 백그라운드 상태에서 알림 클릭 처리
  void _onMessageOpenedListener() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      AppLogger.i(
        '백그라운드에서 알림 클릭됨: ${message.notification?.title ?? message.data['title']}',
        tag: 'FcmInitializer',
      );
      _handleNotificationClick(message.data["screen"]);
    });
  }

  /// 종료 상태에서 알림 클릭 처리
  Future<void> _checkInitialMessage() async {
    RemoteMessage? message = await messaging.getInitialMessage();
    if (message != null) {
      AppLogger.i(
        '앱이 종료된 상태에서 알림 클릭됨: ${message.notification?.title ?? message.data['title']}',
        tag: 'FcmInitializer',
      );
      _handleNotificationClick(message.data["screen"]);
    }
  }

  /// Foreground 알림 표시
  void _showLocalNotification(String? title, String? body, String? screen) {
    final int notificationId =
    DateTime.now().millisecondsSinceEpoch.remainder(100000);

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    localNotifications.show(
      notificationId,
      title ?? '알림',
      body ?? '메시지가 도착했습니다.',
      notificationDetails,
      payload: screen,
    );
  }

  /// 알림 클릭 시 콜백 처리
  void _handleNotificationClick(String? screen) {
    if (screen != null) {
      AppLogger.i("이동할 화면: $screen", tag: 'FcmInitializer');
      // TODO: 화면 이동 처리 필요 시 여기에 추가
    }
  }
}