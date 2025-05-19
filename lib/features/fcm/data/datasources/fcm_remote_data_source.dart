import 'package:cosetic1/features/fcm/data/dto/fcm_token_response.dart';
import 'package:dio/dio.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../../core/logger/dio_logging_interceptor.dart';
import '../dto/purchase_notification_request.dart';
import '../dto/refresh_fcm_token_request.dart';
import 'fcm_data_source.dart';

class FcmRemoteDataSource implements FcmDataSource {
  final String baseUrl;
  final Dio dio;

  FcmRemoteDataSource({required this.baseUrl, Dio? dio})
      : dio = (dio ?? Dio(BaseOptions(baseUrl: baseUrl)))
    ..interceptors.add(DioLoggingInterceptor());

  @override
  Future<bool> refreshFcmToken({
    required RefreshFcmTokenRequest request,
  }) async {
    try {
      await dio.post('$baseUrl/api/fcm/token', data: request.toJson());
      AppLogger.i('FCM 토큰 갱신 성공');
      return true;
    } catch (e, s) {
      AppLogger.e('FCM 토큰 갱신 실패', tag: 'FcmRemoteDataSource', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<bool> deactivateToken(String memberId) async {
    try {
      await dio.put('$baseUrl/api/fcm/token/deactivate/$memberId');
      AppLogger.i('FCM 토큰 비활성화 성공', tag: 'FcmRemoteDataSource');
      return true;
    } catch (e, s) {
      AppLogger.e('FCM 토큰 비활성화 실패', tag: 'FcmRemoteDataSource', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<bool> sendPurchaseNotification({
    required PurchaseNotificationRequest request,
  }) async {
    try {
      await dio.post('$baseUrl/api/fcm/notify/purchase', data: request.toJson());
      AppLogger.i('구매 알림 전송 성공');
      return true;
    } catch (e, s) {
      AppLogger.e('구매 알림 전송 실패', tag: 'FcmRemoteDataSource', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<FcmTokenResponse> fetchFcmTokenByMember({required String memberId}) async {
    try{
      final response = await dio.get('${baseUrl}/api/fcm/token/${memberId}');
      AppLogger.i('fetchFcmTokenByMember -> response : ${response}', tag: 'FcmRemoteDataSource');
      return FcmTokenResponse.fromJson(response.data);
    }catch(e,s){
      AppLogger.e('fetchFcmTokenByMember 실패', tag: 'FcmRemoteDataSource', error: e, stackTrace: s);
      rethrow;
    }
  }
}