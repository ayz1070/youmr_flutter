import 'package:flutter/material.dart';

class SignUpWelcomeStep extends StatefulWidget {
  const SignUpWelcomeStep({Key? key}) : super(key: key);

  @override
  State<SignUpWelcomeStep> createState() => _SignUpWelcomeStepState();
}

class _SignUpWelcomeStepState extends State<SignUpWelcomeStep> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
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
    return FadeTransition(
      opacity: _animation,
      child: const Center(
        child: Text(
          "환영합니다!",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}