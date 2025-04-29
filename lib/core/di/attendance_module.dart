import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:youmr_flutter/core/constants/app_config.dart';

import '../../features/attendance/data/data_source/attendance_remote_data_source.dart';
import '../../features/attendance/data/repository_impl/attendance_repository_impl.dart';
import '../../features/attendance/domain/repository/attendance_repository.dart';
import '../../features/attendance/domain/usecase/create_attendance_use_case.dart';
import '../../features/attendance/domain/usecase/delete_attendance_use_case.dart';
import '../../features/attendance/domain/usecase/fetch_attendance_use_case.dart';
import '../../features/attendance/presentation/state/attendance_state.dart';
import '../../features/attendance/presentation/viewmodel/attendance_view_model.dart';


/// 1. Dio Provider (공통 네트워크 모듈에서 이미 존재한다면 생략 가능)
final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: 'http://localhost:8080/api/v1', // ✅ 실제 서버 주소로 수정
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {'Content-Type': 'application/json'},
  ));
});

/// 2. AttendanceRemoteDataSource Provider
final attendanceRemoteDataSourceProvider = Provider<AttendanceRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return AttendanceRemoteDataSource(baseUrl: AppConfig.baseUrl);
});

/// 3. AttendanceRepository Provider
final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  final remoteDataSource = ref.watch(attendanceRemoteDataSourceProvider);
  return AttendanceRepositoryImpl(remoteDataSource: remoteDataSource);
});

/// 4. CreateAttendanceUseCase Provider
final createAttendanceUseCaseProvider = Provider<CreateAttendanceUseCase>((ref) {
  final repository = ref.watch(attendanceRepositoryProvider);
  return CreateAttendanceUseCase(repository);
});

/// 5. FetchAttendancesUseCase Provider
final fetchAttendancesUseCaseProvider = Provider<FetchAttendancesUseCase>((ref) {
  final repository = ref.watch(attendanceRepositoryProvider);
  return FetchAttendancesUseCase(repository);
});

/// 6. DeleteAttendanceUseCase Provider
final deleteAttendanceUseCaseProvider = Provider<DeleteAttendanceUseCase>((ref) {
  final repository = ref.watch(attendanceRepositoryProvider);
  return DeleteAttendanceUseCase(repository);
});

/// 7. AttendanceViewModel Provider (StateNotifierProvider)
final attendanceViewModelProvider = StateNotifierProvider<AttendanceViewModel, AttendanceState>(
      (ref) => AttendanceViewModel(
    createAttendanceUseCase: ref.watch(createAttendanceUseCaseProvider),
    fetchAttendancesUseCase: ref.watch(fetchAttendancesUseCaseProvider),
  ),
);