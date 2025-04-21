import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // 제목 스타일
  static const TextStyle headline1 = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle headline3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  // 본문 스타일
  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle body3 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle body4 = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.normal,
  );

  // 버튼 스타일
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  // 캡션 및 보조 텍스트
  static const TextStyle caption = TextStyle(
    fontSize: 8,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary
  );

  static const TextStyle overLine = TextStyle(
      fontSize: 6,
      fontWeight: FontWeight.normal,
  );

  static const TextStyle name1 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle title1 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle content1 = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle comment1 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}