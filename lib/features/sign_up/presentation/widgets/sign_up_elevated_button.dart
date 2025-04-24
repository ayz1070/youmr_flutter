import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class SignUpElevatedButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double iconSize;
  final Color? backgroundColor;
  final Color? iconColor;

  const SignUpElevatedButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconSize = 18.0,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primary, // 기본 배경색 (기본값: primary)
        foregroundColor: iconColor ?? AppColors.white, // 아이콘 색상
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // 라운드 버튼 디자인 적용
        ),
        elevation: 2, // 적절한 입체감 추가
      ),
      child: Icon(
        icon,
        size: iconSize, // 아이콘 크기
        color: iconColor ?? Colors.white, // 아이콘 색상
      ),
    );
  }
}