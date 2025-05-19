import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youmr_flutter/core/di/dio_provider.dart';
import 'package:youmr_flutter/features/fcm/data/datasources/fcm_remote_data_source.dart';
import 'package:youmr_flutter/features/fcm/data/repository/fcm_repository_impl.dart';
import 'package:youmr_flutter/features/fcm/domain/repository/fcm_repository.dart';
import 'package:youmr_flutter/features/fcm/domain/usecase/deactivate_fcm_token_use_case.dart';
import 'package:youmr_flutter/features/fcm/domain/usecase/fetch_fcm_token_use_case.dart';

import '../../features/fcm/data/datasources/fcm_data_source.dart';
import '../../features/fcm/domain/usecase/refresh_fcm_token_use_case.dart';
import '../../features/fcm/presentation/fcm_notifier.dart';
import '../../features/fcm/presentation/state/fcm_state.dart';


final fcmRemoteDataSourceProvider = Provider<FcmDataSource>(
    (ref) {
      return FcmRemoteDataSource(dio: ref.read(dioProvider));
    }
);

final fcmRepositoryProvider = Provider<FcmRepository>(
        (ref) {
      return FcmRepositoryImpl(remoteDataSource: ref.read(fcmRemoteDataSourceProvider));
    }
);

final refreshFcmTokenUseCaseProvider = Provider<RefreshFcmTokenUseCase>(
        (ref) {
      return RefreshFcmTokenUseCase(repository : ref.read(fcmRepositoryProvider));
    }
);

final deactivateFcmTokenUseCaseProvider = Provider<DeactivateFcmTokenUseCase>(
        (ref) {
      return DeactivateFcmTokenUseCase(repository : ref.read(fcmRepositoryProvider));
    }
);

final fetchFcmTokenUseCaseProvider = Provider<FetchFcmTokenUseCase>(
        (ref) {
      return FetchFcmTokenUseCase(repository : ref.read(fcmRepositoryProvider));
    }
);


final fcmNotifierProvider = StateNotifierProvider<FcmNotifier, FcmState>((ref) {
  return FcmNotifier(
    refreshFcmTokenUseCase: ref.watch(refreshFcmTokenUseCaseProvider),
    deactivateFcmTokenUseCase: ref.watch(deactivateFcmTokenUseCaseProvider),
    fetchFcmTokenUseCase: ref.watch(fetchFcmTokenUseCaseProvider),
  );
});