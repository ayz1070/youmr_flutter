import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../../core/di/auth_module.dart';
import '../widgets/sign_up_elevated_button.dart';
import '../widgets/sign_up_nickname_step.dart';
import '../widgets/sign_up_profile_image_step.dart';

class SignUpPage extends ConsumerStatefulWidget {


  const SignUpPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final PageController _pageController = PageController();
  final TextEditingController _nicknameController = TextEditingController();
  String? _selectedMbti;
  String? _profileImagePath;
  int _currentStep = 0;


  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
      _pageController.animateToPage(_currentStep,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.animateToPage(_currentStep,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _signUp() async {
    final viewModel = ref.read(signUpViewModelProvider.notifier);

    if (_nicknameController.text.isEmpty ||
        _selectedMbti == null ||
        _profileImagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('모든 필드를 입력해주세요!')),
      );
      return;
    }

    final success = await viewModel.signUp(
      nickname: _nicknameController.text,
      mbti: _selectedMbti!,
      profileImagePath: _profileImagePath!,
    );

    if (success) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('회원가입에 실패했습니다. 다시 시도해주세요.')),
      );
    }


  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(signUpViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('회원 가입')),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SignUpNicknameStep(controller: _nicknameController),
                SignUpProfileImageStep(
                  profileImagePath: _profileImagePath,
                  onPickImage: (imagePath) =>
                      setState(() => _profileImagePath = imagePath),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _currentStep > 0
                    ? SignUpElevatedButton(
                        icon: Icons.arrow_back, onPressed: _previousStep)
                    : const SizedBox.shrink(),
                _currentStep < 1
                    ? SignUpElevatedButton(icon: Icons.arrow_forward, onPressed: _nextStep)
                    : SignUpElevatedButton(icon: Icons.done, onPressed: _signUp)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
