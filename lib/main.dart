import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'core/navigation/app_router.dart';
import 'core/theme/app_theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // 꼭 추가! (비동기 코드에서 안전)
  //await dotenv.load();

  // .env에서 환경변수 불러오기
  //final kakaoAppKey = dotenv.env['KAKAO_NATIVE_APP_KEY'] ?? '';


  KakaoSdk.init(nativeAppKey: "6a5a8f251a4aeec1c6d5db62830f9528");

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'YouMR',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}