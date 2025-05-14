import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:youmr_flutter/core/util/app_logger.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging messaging = FirebaseMessaging.instance;


    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          OutlinedButton(
            onPressed: () async {
              // 토큰 확인
              final fcmToken = await messaging.getToken();
              AppLogger.i("FCM Token: $fcmToken");

              // 포그라운드 메시지 처리
              FirebaseMessaging.onMessage.listen((RemoteMessage message) {
                AppLogger.i('📬 포그라운드 메시지 수신됨: ${message.notification?.title}');
              });
            },
            child: Text("FCM 테스트"),
          ),
        ],
      ),
    );
  }
}
