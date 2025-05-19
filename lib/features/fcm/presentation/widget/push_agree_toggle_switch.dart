import 'package:cosetic1/features/fcm/presentation/bloc/fcm_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_padding.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class PushAgreeToggleSwitch extends StatefulWidget {
  const PushAgreeToggleSwitch({
    super.key,
    required this.text,
  });

  final String text;

  @override
  State<PushAgreeToggleSwitch> createState() => _PushToggleSwitchState();
}

class _PushToggleSwitchState extends State<PushAgreeToggleSwitch> {
  bool? isSwitched;

  @override
  void initState() {
    super.initState();

    // Bloc 상태에서 현재 활성화 여부를 가져와 초기화
    final state = context.read<FcmBloc>().state;
    if (state is FcmTokenLoadedState) {
      isSwitched = state.token.isActive;
    } else {
      isSwitched = true; // 기본값 (네트워크 응답 전)
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FcmBloc, FcmState>(
      listener: (context, state) {
        if (state is FcmTokenLoadedState) {
          setState(() {
            isSwitched = state.token.isActive;
          });
        }
      },
      builder: (context, state) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Padding(
            padding: AppPadding.h20v8Padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.text, style: AppTextStyles.medium16),
                Transform.scale(
                  scale: 1,
                  child: Switch(
                    value: isSwitched ?? true,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });

                      context.read<FcmBloc>().add(
                        ToggleFcmNotificationEvent(value),
                      );
                    },
                    activeColor: AppColors.badgeTextColor,
                    activeTrackColor: AppColors.badgePinkColor,
                    inactiveThumbColor: AppColors.badgeTextColor,
                    inactiveTrackColor: AppColors.checkBtnBorderColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}