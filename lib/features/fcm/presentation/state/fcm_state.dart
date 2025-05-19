import 'package:equatable/equatable.dart';

enum FcmStatus { initial, loading, success, failure }

class FcmState extends Equatable {
  final FcmStatus status;
  final bool isActive;
  final String? error;

  FcmState({
    this.status = FcmStatus.initial,
    this.isActive = true,
    this.error,
  });

  FcmState copyWith({
    FcmStatus? status,
    bool? isActive,
    String? error,
  }) {
    return FcmState(
      status: status ?? this.status,
      isActive: isActive ?? this.isActive,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, isActive, error];
}
