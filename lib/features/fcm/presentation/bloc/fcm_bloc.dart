import 'dart:io';

import 'package:cosetic1/core/init/fcm_initializer.dart';
import 'package:cosetic1/core/logger/app_logger.dart';
import 'package:cosetic1/features/fcm/domain/entity/device_type.dart';
import 'package:cosetic1/features/fcm/domain/usecase/deactivate_fcm_token_use_case.dart';
import 'package:cosetic1/features/fcm/domain/usecase/fetch_fcm_token_use_case.dart';
import 'package:cosetic1/features/fcm/domain/usecase/refresh_fcm_token_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/fcm_token_entity.dart';

part 'fcm_event.dart';
part 'fcm_state.dart';

class FcmBloc extends Bloc<FcmEvent, FcmState> {
  final RefreshFcmTokenUseCase refreshFcmTokenUseCase;
  final DeactivateFcmTokenUseCase deactivateFcmTokenUseCase;
  final FetchFcmTokenUseCase fetchFcmTokenUseCase;

  FcmBloc({
    required this.refreshFcmTokenUseCase,
    required this.deactivateFcmTokenUseCase,
    required this.fetchFcmTokenUseCase,
  }) : super(FcmInitial()) {
    AppLogger.i("FCM Bloc 생성", tag: 'FcmBloc');
    on<FcmInitializeEvent>(_onInitializeFcm);
    on<ToggleFcmNotificationEvent>(_onToggleFcmNotification);
  }

  Future<void> _onInitializeFcm(
      FcmInitializeEvent event, Emitter<FcmState> emit) async {
    emit(FcmInitializationInProgress());
    try {
      await FcmInitializer.initialize();

      final permission = await FirebaseMessaging.instance.requestPermission();
      if (permission.authorizationStatus != AuthorizationStatus.authorized) {
        AppLogger.i("알림 권한이 거부됨", tag: 'FcmBloc');
        emit(const FcmInitializationFailure("알림 권한 거부됨"));
        return;
      }

      final token = await FirebaseMessaging.instance.getToken();
      if (token == null) {
        AppLogger.e("FCM 토큰이 null입니다", tag: 'FcmBloc');
        emit(const FcmInitializationFailure("토큰 없음"));
        return;
      }

      final String? memberId = FirebaseAuth.instance.currentUser?.email;
      if (memberId == null) {
        AppLogger.w("로그인 상태가 아닙니다. FCM 토큰 저장 생략", tag: 'FcmBloc');
        emit(const FcmInitializationFailure("로그인 상태 아님"));
        return;
      }

      final deviceType = Platform.isAndroid ? DeviceType.ANDROID : DeviceType.IOS;

      await refreshFcmTokenUseCase.call(
        memberId: memberId,
        token: token,
        deviceType: deviceType,
      );

      AppLogger.i("FCM 초기화 및 토큰 저장 완료", tag: 'FcmBloc');
      emit(FcmInitializationSuccess());
    } catch (e, s) {
      AppLogger.e("FCM 초기화 실패: $e, $s", tag: 'FcmBloc');
      emit(FcmInitializationFailure(e.toString()));
    }
  }

  Future<void> _onToggleFcmNotification(
      ToggleFcmNotificationEvent event, Emitter<FcmState> emit) async {
    final memberId = FirebaseAuth.instance.currentUser?.email;
    if (memberId == null) {
      AppLogger.w("로그인 상태가 아닙니다.", tag: 'FcmBloc');
      return;
    }

    try {
      // 현재 토큰 상태 확인
      final FcmTokenEntity tokenEntity =
      await fetchFcmTokenUseCase.call(memberId);

      if (tokenEntity.isActive) {
        // 비활성화 요청
        await deactivateFcmTokenUseCase.call(memberId);
        AppLogger.i("FCM 토큰 비활성화 완료", tag: 'FcmBloc');
      } else {
        // 활성화 요청
        final token = await FirebaseMessaging.instance.getToken();
        final deviceType =
        Platform.isAndroid ? DeviceType.ANDROID : DeviceType.IOS;

        if (token == null) {
          AppLogger.e("FCM 토큰이 null입니다", tag: 'FcmBloc');
          return;
        }

        await refreshFcmTokenUseCase.call(
          memberId: memberId,
          token: token,
          deviceType: deviceType,
        );
        AppLogger.i("FCM 토큰 활성화 완료", tag: 'FcmBloc');
      }
    } catch (e, s) {
      AppLogger.e("FCM 상태 변경 실패: $e", stackTrace: s, tag: 'FcmBloc');
    }
  }
}