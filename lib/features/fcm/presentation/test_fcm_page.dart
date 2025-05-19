// import 'package:cosetic1/core/widgets/page_button.dart';
// import 'package:cosetic1/features/fcm/domain/usecase/send_purchase_notification_use_case.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:logger/logger.dart';
//
// import '../../../core/logger/app_logger.dart';
//
// class TestFcmPage extends StatelessWidget {
//   const TestFcmPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final usecase = context.read<SendPurchaseNotificationUseCase>();
//
//     final logger = Logger();
//
//     return Scaffold(
//       body: Center(
//         child: PageButton(
//           text: "fcm 테스트",
//           paddingHorizontal: EdgeInsets.zero,
//           onPressed: () async {
//
//             String? fcmToken = await FirebaseMessaging.instance.getToken();
//             AppLogger.i('TestPage Firebase FCM 토큰: $fcmToken');
//
//             usecase.call(buyerId: "ayz1070@naver.com", sellerId: "ayz1070@naver.com");
//           },
//         ),
//       ),
//     );
//   }
// }
