
import '../dto/fcm_token_response.dart';
import '../dto/purchase_notification_request.dart';
import '../dto/refresh_fcm_token_request.dart';

abstract class FcmDataSource {
  /// FCM 토큰 갱신 또는 등록
  Future<bool> refreshFcmToken({
    required RefreshFcmTokenRequest request,
  });

  /// FCM 토큰 비활성화 (로그아웃, 탈퇴 등)
  Future<bool> deactivateToken(String memberId);

  /// 구매 알림 전송 (구매자/판매자에게)
  Future<bool> sendPurchaseNotification({
    required PurchaseNotificationRequest request,
  });

  Future<FcmTokenResponse> fetchFcmTokenByMember({required String memberId});



}