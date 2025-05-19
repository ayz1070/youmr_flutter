import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/fcm_provider.dart';
import '../../../../core/theme/app_text_styles.dart';

class PushAgreeToggleSwitch extends ConsumerWidget {
  final String text;

  const PushAgreeToggleSwitch({super.key, required this.text});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(fcmNotifierProvider);
    final notifier = ref.read(fcmNotifierProvider.notifier);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: AppTextStyles.body3),
            Transform.scale(
              scale: 1,
              child: Switch(
                value: state.isActive,
                onChanged: (value) {
                  notifier.toggleNotification(value);
                },
                // activeColor: AppColors.badgeTextColor,
                // activeTrackColor: AppColors.badgePinkColor,
                // inactiveThumbColor: AppColors.badgeTextColor,
                // inactiveTrackColor: AppColors.checkBtnBorderColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}