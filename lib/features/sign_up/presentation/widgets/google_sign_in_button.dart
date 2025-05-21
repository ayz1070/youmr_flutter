import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // ✅ 최대 너비
      height: 48,             // ✅ 공식 가이드 최소 높이
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFDADCE0)), // ✅ 테두리 색상
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF3C4043), // ✅ 텍스트 색상
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/images/logo_google.png',
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 12),
            const Text(
              'Google로 로그인',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}