import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/auth_module.dart';
import '../../../../core/theme/app_text_styles.dart';

class SignUpNicknameStep extends StatefulWidget {
  final TextEditingController controller;

  const SignUpNicknameStep({required this.controller, Key? key}) : super(key: key);

  @override
  State<SignUpNicknameStep> createState() => _SignUpNicknameStepState();
}

class _SignUpNicknameStepState extends State<SignUpNicknameStep> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _scale = Tween<double>(begin: 0.94, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Material 3의 outline 스타일에 맞춘 TextField
    return FadeTransition(
      opacity: _fade,
      child: ScaleTransition(
        scale: _scale,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "닉네임",
                style: AppTextStyles.headline1.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  color: Colors.black, // 검은색
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 36),
              _Material3NicknameTextField(controller: widget.controller),
            ],
          ),
        ),
      ),
    );
  }
}

class _Material3NicknameTextField extends ConsumerWidget {
  final TextEditingController controller;
  const _Material3NicknameTextField({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Material 3 TextField: filled, outline, label 스타일 반영
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black87),
      decoration: InputDecoration(
        labelText: '닉네임을 입력하세요',
        labelStyle: const TextStyle(color: Colors.black54, fontSize: 16),
        prefixIcon: const Icon(Icons.person_outline, color: Colors.black38),
        filled: true,
        fillColor: Colors.grey[50], // Material 3에서 살짝 밝은 배경
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFBDBDBD)), // Material 3 outline color
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFBDBDBD)), // 연한 그레이
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.black87, width: 2), // 포커스 시 딥블랙
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        floatingLabelBehavior: FloatingLabelBehavior.auto, // Material 3의 플로팅 라벨 효과
      ),
      textAlign: TextAlign.center,
    );
  }
}