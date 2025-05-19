
import '../../data/dto/purchase_notification_request.dart';
import '../../data/dto/refresh_fcm_token_request.dart';
import '../../domain/entity/device_type.dart';
import '../../domain/entity/fcm_token_entity.dart';
import '../../domain/repository/fcm_repository.dart';
import '../datasources/fcm_data_source.dart';

class FcmRepositoryImpl implements FcmRepository {
  final FcmDataSource remoteDataSource;

  FcmRepositoryImpl({required this.remoteDataSource});

  @override
  Future<bool> refreshFcmToken({
    required String memberId,
    required String token,
    required DeviceType deviceType,
  }) {

    final request = RefreshFcmTokenRequest(
      memberId: memberId,
      token: token,
      deviceType: deviceType.name, // enum → string 변환
    );
    return remoteDataSource.refreshFcmToken(request: request);
  }

  @override
  Future<bool> deactivateToken({required String memberId}) {
    return remoteDataSource.deactivateToken(memberId);
  }

  @override
  Future<bool> sendPurchaseNotification({
    required String buyerId,
    required String sellerId,
  }) {

    final request = PurchaseNotificationRequest(
      buyerId: buyerId,
      sellerId: sellerId,
    );
    return remoteDataSource.sendPurchaseNotification(request: request);
  }

  @override
  Future<FcmTokenEntity> fetchFcmTokenByMember({required String memberId}) async {
    final response = await remoteDataSource.fetchFcmTokenByMember(memberId: memberId);

    return response.toEntity();
  }

}