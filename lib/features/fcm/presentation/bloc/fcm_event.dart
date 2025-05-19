part of 'fcm_bloc.dart';

abstract class FcmEvent extends Equatable {
  const FcmEvent();

  @override
  List<Object?> get props => [];
}

/// FCM 초기화를 요청하는 이벤트
class FcmInitializeEvent extends FcmEvent {}

class ToggleFcmNotificationEvent extends FcmEvent {
  final bool isActive;

  ToggleFcmNotificationEvent(this.isActive);

  @override
  List<Object?> get props => [isActive];
}