import 'package:cosetic1/features/fcm/domain/entity/fcm_token_entity.dart';

import '../entity/device_type.dart';

abstract class FcmRepository {
  Future<bool> refreshFcmToken({
    required String memberId,
    required String token,
    required DeviceType deviceType,
  });

  Future<bool> deactivateToken({required String memberId});

  Future<bool> sendPurchaseNotification({
    required String buyerId,
    required String sellerId,
  });

  Future<FcmTokenEntity> fetchFcmTokenByMember({required String memberId});
}