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
import 'dio_provider.dart';

final attendanceRemoteDataSourceProvider = Provider<AttendanceRemoteDataSource>(
  (ref) {
    return AttendanceRemoteDataSource(dio: ref.watch(dioProvider));
  },
);

final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  final remoteDataSource = ref.watch(attendanceRemoteDataSourceProvider);
  return AttendanceRepositoryImpl(remoteDataSource: remoteDataSource);
});

final createAttendanceUseCaseProvider = Provider<CreateAttendanceUseCase>((
  ref,
) {
  final repository = ref.watch(attendanceRepositoryProvider);
  return CreateAttendanceUseCase(repository);
});

final fetchAttendancesUseCaseProvider = Provider<FetchAttendancesUseCase>((
  ref,
) {
  final repository = ref.watch(attendanceRepositoryProvider);
  return FetchAttendancesUseCase(repository);
});

final deleteAttendanceUseCaseProvider = Provider<DeleteAttendanceUseCase>((
  ref,
) {
  final repository = ref.watch(attendanceRepositoryProvider);
  return DeleteAttendanceUseCase(repository);
});

final attendanceViewModelProvider =
    StateNotifierProvider<AttendanceViewModel, AttendanceState>(
      (ref) => AttendanceViewModel(
        createAttendanceUseCase: ref.watch(createAttendanceUseCaseProvider),
        fetchAttendancesUseCase: ref.watch(fetchAttendancesUseCaseProvider),
        deleteAttendanceUseCase: ref.watch(deleteAttendanceUseCaseProvider),
        ref: ref,
      ),
    );
