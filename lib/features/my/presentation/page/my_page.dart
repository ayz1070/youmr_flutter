import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:youmr_flutter/features/splash/presentation/provider/member_provider.dart';

import '../../../../core/widget/common_app_bar.dart';

class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final member = ref.watch(memberProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: "마이페이지",
      ),
      body: Column(
        children: [
          // Profile Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(member?.profileImage ?? ''),
                ),
                const SizedBox(height: 12),
                Text(
                  member?.nickname ?? '',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D141C),
                  ),
                ),
                Text(
                  member?.weekType?.name ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF49709C),
                  ),
                ),
              ],
            ),
          ),

          // Menu Items
          _buildMenuItem(context, '프로필 수정', () => print('프로필 수정 클릭됨')),
          _buildMenuItem(context, '연습실 위치', () => print('연습실 위치 클릭됨')),
          _buildMenuItem(context, '오픈 라이선스', () {
            context.push('/license');
          }),
          _buildMenuItem(context, '로그아웃', () => print('로그아웃 클릭됨')),

          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 64,
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE7EDF4))),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16, color: Color(0xFF0D141C)),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFFB0B0B0),
            ),
          ],
        ),
      ),
    );
  }
}
