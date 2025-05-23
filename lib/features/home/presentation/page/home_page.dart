import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youmr_flutter/features/gemini/presentation/page/gemini_page.dart';

import '../../../../core/di/fcm_provider.dart';
import '../../../attendance/presentation/pages/attendance_page.dart';
import '../../../my/presentation/page/my_page.dart';
import '../widget/custom_bottom_nav_bar.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;
  bool _fcmInitialized = false;

  final List<Widget> _pages = const [
    GeminiPage(),
    AttendancePage(),
    MyPage(),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_fcmInitialized) {
      _fcmInitialized = true;

      /// FCM 토큰을 확인하고 서버에 저장하는 로직 수행
      ref.read(fcmNotifierProvider.notifier).syncFcmTokenIfNeeded();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
