import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:youmr_flutter/core/util/app_logger.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FCM 테스트")),
      body: Center(
        child: OutlinedButton(
          onPressed: () async {
            final token = await FirebaseMessaging.instance.getToken();
            AppLogger.i("📬 FCM Token: $token");
            // 알림은 이미 NotificationService에서 onMessage로 수신 중
          },
          child: const Text("FCM 토큰 확인"),
        ),
      ),
    );
  }
}