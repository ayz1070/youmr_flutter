part of 'fcm_bloc.dart';

abstract class FcmState extends Equatable {
  const FcmState();

  @override
  List<Object?> get props => [];
}

/// 초기 상태
class FcmInitial extends FcmState {}

/// 초기화 진행 중 상태
class FcmInitializationInProgress extends FcmState {}

/// 초기화 성공 상태
class FcmInitializationSuccess extends FcmState {}

/// 초기화 실패 상태
class FcmInitializationFailure extends FcmState {
  final String error;

  const FcmInitializationFailure(this.error);

  @override
  List<Object?> get props => [error];
}