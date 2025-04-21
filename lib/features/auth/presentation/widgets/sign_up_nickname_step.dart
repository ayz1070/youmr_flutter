import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

class SignUpNicknameStep extends StatelessWidget {
  final TextEditingController controller;

  const SignUpNicknameStep({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("닉네임",style: AppTextStyles.headline1),
          const SizedBox(height: 250),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: '닉네임을 입력하세요',
              border: UnderlineInputBorder(), // 기본 밑줄
              focusedBorder: UnderlineInputBorder( // 포커스 시 밑줄
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
              enabledBorder: UnderlineInputBorder( // 비활성 상태일 때 밑줄
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}