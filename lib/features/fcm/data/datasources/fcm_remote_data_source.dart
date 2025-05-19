import 'package:dio/dio.dart';
import '../../../../core/util/app_logger.dart';
import '../dto/fcm_token_response.dart';
import '../dto/purchase_notification_request.dart';
import '../dto/refresh_fcm_token_request.dart';
import 'fcm_data_source.dart';

class FcmRemoteDataSource implements FcmDataSource {
  final Dio dio;

  FcmRemoteDataSource({required this.dio});


  @override
  Future<bool> refreshFcmToken({
    required RefreshFcmTokenRequest request,
  }) async {
    try {
      await dio.post('/fcm/token', data: request.toJson());
      AppLogger.i('FCM 토큰 갱신 성공');
      return true;
    } catch (e, s) {
      AppLogger.e('FCM 토큰 갱신 실패', tag: 'FcmRemoteDataSource');
      rethrow;
    }
  }

  @override
  Future<bool> deactivateToken(String memberId) async {
    try {
      await dio.put('/fcm/token/deactivate/$memberId');
      AppLogger.i('FCM 토큰 비활성화 성공', tag: 'FcmRemoteDataSource');
      return true;
    } catch (e, s) {
      AppLogger.e('FCM 토큰 비활성화 실패', tag: 'FcmRemoteDataSource');
      rethrow;
    }
  }

  @override
  Future<bool> sendPurchaseNotification({
    required PurchaseNotificationRequest request,
  }) async {
    try {
      await dio.post('/fcm/notify/purchase', data: request.toJson());
      AppLogger.i('구매 알림 전송 성공');
      return true;
    } catch (e, s) {
      AppLogger.e('구매 알림 전송 실패', tag: 'FcmRemoteDataSource');
      rethrow;
    }
  }

  @override
  Future<FcmTokenResponse> fetchFcmTokenByMember(
      {required String memberId}) async {
    try {
      final response = await dio.get('/fcm/token/${memberId}');
      AppLogger.i('fetchFcmTokenByMember -> response : ${response}',
          tag: 'FcmRemoteDataSource');
      return FcmTokenResponse.fromJson(response.data);
    } catch (e, s) {
      AppLogger.e('fetchFcmTokenByMember 실패', tag: 'FcmRemoteDataSource');
      rethrow;
    }
  }
}