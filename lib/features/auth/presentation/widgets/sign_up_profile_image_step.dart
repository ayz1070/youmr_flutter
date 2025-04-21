import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SignUpProfileImageStep extends StatelessWidget {
  final String? profileImagePath;
  final Function(String) onPickImage;

  const SignUpProfileImageStep({
    required this.profileImagePath,
    required this.onPickImage,
    Key? key,
  }) : super(key: key);

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      onPickImage(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("프로필",style: AppTextStyles.headline1),
        const SizedBox(height: 200),
        GestureDetector(
          onTap: _pickImage,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.grey.shade300,
            backgroundImage: profileImagePath != null ? FileImage(File(profileImagePath!)) : null,
            child: profileImagePath == null
                ? const Icon(Icons.person, size: 96, color: Colors.white)
                : null,
          ),
        ),
      ],
    );
  }
}