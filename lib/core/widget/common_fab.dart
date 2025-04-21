import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CommonFab extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String tooltip;

  const CommonFab({
    super.key,
    required this.onPressed,
    this.icon = Icons.add,
    this.tooltip = "추가",
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? AppColors.darkBackground : AppColors.primary;

    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22), // 완전한 원형
      ),
      tooltip: tooltip,
      child: Icon(icon, color: Colors.white),
    );
  }
}