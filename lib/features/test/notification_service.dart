import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/util/app_logger.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
  FlutterLocalNotificationsPlugin();

  static const String _channelId = 'youmr_channel';

  static Future<void> initialize() async {
    // 🔐 알림 권한 요청 (Android 13 이상 대응)
    final permission = await Permission.notification.status;
    if (!permission.isGranted) {
      await Permission.notification.request();
    }

    // 🔔 Android 채널 등록
    const androidChannel = AndroidNotificationChannel(
      _channelId,
      'YouMR 알림',
      description: 'YouMR 앱의 기본 알림 채널입니다.',
      importance: Importance.high,
    );

    final androidPlugin =
    _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.createNotificationChannel(androidChannel);

    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        // 알림 클릭 시 로직
        AppLogger.i("🔔 Notification tapped: ${details.payload}");
      },
    );
    // 🔥 포그라운드 메시지 수신 → 로컬 알림으로 표시
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final title = message.notification?.title ?? '제목 없음';
      final body = message.notification?.body ?? '내용 없음';

      showNotification(title, body);
    });
  }

  static Future<void> showNotification(String title, String body) async {
    const androidDetails = AndroidNotificationDetails(
      _channelId,
      'YouMR 알림',
      channelDescription: 'YouMR 알림을 위한 채널입니다.',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
        icon: '@mipmap/ic_launcher'
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await _plugin.show(0, title, body, notificationDetails);
  }
}