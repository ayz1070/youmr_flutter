import '../repository/fcm_repository.dart';
import '../entity/device_type.dart';

class RefreshFcmTokenUseCase {
  final FcmRepository repository;

  RefreshFcmTokenUseCase({required this.repository});

  Future<bool> call({
    required String memberId,
    required String token,
    required DeviceType deviceType,
  }) async {
    return await repository.refreshFcmToken(
      memberId: memberId,
      token: token,
      deviceType: deviceType,
    );
  }
}