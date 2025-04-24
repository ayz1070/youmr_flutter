import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/auth_module.dart';
import '../../domain/entity/role.dart';

class SignUpMemberCheckStep extends StatefulWidget {
  const SignUpMemberCheckStep({Key? key}) : super(key: key);

  @override
  State<SignUpMemberCheckStep> createState() => _SignUpMemberCheckStepState();
}

class _SignUpMemberCheckStepState extends State<SignUpMemberCheckStep> with SingleTickerProviderStateMixin {
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
    _scale = Tween<double>(begin: 0.95, end: 1.0).animate(
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
    return Consumer(
      builder: (context, ref, _) {
        final isOfflineMember =
        ref.watch(signUpViewModelProvider.select((state) => state.role == Role.offlineMember));

        return FadeTransition(
          opacity: _fade,
          child: ScaleTransition(
            scale: _scale,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '오프라인 회원이십니까?',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 36),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _CustomRadio(
                        label: '네',
                        value: true,
                        groupValue: isOfflineMember,
                        onChanged: (value) {
                          ref.read(signUpViewModelProvider.notifier)
                              .setOfflineMember(true);
                        },
                      ),
                      const SizedBox(width: 32),
                      _CustomRadio(
                        label: '아니요',
                        value: false,
                        groupValue: isOfflineMember,
                        onChanged: (value) {
                          ref.read(signUpViewModelProvider.notifier)
                              .setOfflineMember(false);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// 예쁜 체크 스타일의 라디오 버튼 (Material 3 느낌)
class _CustomRadio extends StatelessWidget {
  final String label;
  final bool value;
  final bool groupValue;
  final ValueChanged<bool?> onChanged;

  const _CustomRadio({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    final color = isSelected ? Colors.blueAccent : Colors.grey[400];

    return GestureDetector(
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.ease,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.12) : Colors.grey[100],
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: color!,
            width: isSelected ? 2.2 : 1.2,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colors.blue.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected ? Colors.blueAccent : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: color,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.blueAccent : Colors.black54,
                fontSize: 17,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}