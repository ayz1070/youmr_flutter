import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youmr_flutter/features/fcm/presentation/state/fcm_state.dart';

import '../domain/entity/device_type.dart';
import '../domain/usecase/deactivate_fcm_token_use_case.dart';
import '../domain/usecase/fetch_fcm_token_use_case.dart';
import '../domain/usecase/refresh_fcm_token_use_case.dart';

class FcmNotifier extends StateNotifier<FcmState> {
  final RefreshFcmTokenUseCase refreshFcmTokenUseCase;
  final DeactivateFcmTokenUseCase deactivateFcmTokenUseCase;
  final FetchFcmTokenUseCase fetchFcmTokenUseCase;

  FcmNotifier({
    required this.refreshFcmTokenUseCase,
    required this.deactivateFcmTokenUseCase,
    required this.fetchFcmTokenUseCase,
  }) : super(FcmState());

  Future<void> initialize() async {
    state = state.copyWith(status: FcmStatus.loading);

    try {
      final permission = await FirebaseMessaging.instance.requestPermission();
      if (permission.authorizationStatus != AuthorizationStatus.authorized) {
        state = state.copyWith(
          status: FcmStatus.failure,
          error: '알림 권한 거부됨',
        );
        return;
      }

      final token = await FirebaseMessaging.instance.getToken();
      final memberId = FirebaseAuth.instance.currentUser?.email;
      if (token == null || memberId == null) {
        state = state.copyWith(
          status: FcmStatus.failure,
          error: '토큰 또는 사용자 정보 없음',
        );
        return;
      }

      final deviceType = Platform.isAndroid ? DeviceType.ANDROID : DeviceType.IOS;
      await refreshFcmTokenUseCase(memberId: memberId, token: token, deviceType: deviceType);

      state = state.copyWith(status: FcmStatus.success, isActive: true);
    } catch (e) {
      state = state.copyWith(status: FcmStatus.failure, error: e.toString());
    }
  }

  Future<void> toggleNotification(bool enable) async {
    final memberId = FirebaseAuth.instance.currentUser?.email;
    if (memberId == null) return;

    try {
      if (enable) {
        final token = await FirebaseMessaging.instance.getToken();
        final deviceType = Platform.isAndroid ? DeviceType.ANDROID : DeviceType.IOS;
        if (token != null) {
          await refreshFcmTokenUseCase(memberId: memberId, token: token, deviceType: deviceType);
          state = state.copyWith(isActive: true);
        }
      } else {
        await deactivateFcmTokenUseCase(memberId);
        state = state.copyWith(isActive: false);
      }
    } catch (_) {
      // 에러는 상태에 반영하지 않음
    }
  }

  Future<void> fetchTokenStatus() async {
    final memberId = FirebaseAuth.instance.currentUser?.email;
    if (memberId == null) return;

    try {
      final tokenEntity = await fetchFcmTokenUseCase(memberId);
      state = state.copyWith(isActive: tokenEntity.isActive);
    } catch (_) {
      // 상태 무시 가능
    }
  }

  Future<void> syncFcmTokenIfNeeded() async {
    final token = await FirebaseMessaging.instance.getToken();
    final memberId = FirebaseAuth.instance.currentUser?.email;
    if (token == null || memberId == null) return;

    final serverToken = await fetchFcmTokenUseCase(memberId);
    if (serverToken.token != token || !serverToken.isActive) {
      final deviceType = Platform.isAndroid ? DeviceType.ANDROID : DeviceType.IOS;
      await refreshFcmTokenUseCase(
        memberId: memberId,
        token: token,
        deviceType: deviceType,
      );
    }
  }
}