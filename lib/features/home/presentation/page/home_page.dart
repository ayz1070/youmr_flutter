import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/fcm_provider.dart';
import '../../../attendance/presentation/pages/attendance_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;
  bool _fcmInitialized = false;

  final List<Widget> _pages = const [
    BoardPage(),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: '게시판',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: '출석',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '마이페이지',
          ),
        ],
      ),
    );
  }
}

// 임시 페이지는 그대로 유지
class BoardPage extends StatelessWidget {
  const BoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('게시판 페이지'));
  }
}

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('마이페이지'));
  }
}