import 'package:dio/dio.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/util/app_logger.dart';
import '../dto/member_response.dart';
import '../dto/social_sign_up_request_dto.dart';
import 'member_data_source.dart';

class MemberRemoteDataSource implements MemberDataSource {
  final Dio dio;

  MemberRemoteDataSource({required this.dio});

  static const String _endPoint = '/members';

  @override
  Future<MemberResponse> signUpWithSocial(SocialSignUpRequestDto request) async {
    try {
      final response = await dio.post('$_endPoint/signup', data: request.toJson());
      return MemberResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(handleDioError(e, '회원가입 실패'));
    }
  }

  @override
  Future<MemberResponse> fetchMember(int memberId) async {
    try {
      final response = await dio.get('$_endPoint/$memberId');
      return MemberResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(handleDioError(e, '회원 정보 조회 실패'));
    }
  }

  @override
  Future<void> deleteMember(int memberId) async {
    try {
      final response = await dio.delete('$_endPoint/$memberId');
      if (response.statusCode != 200) {
        throw Exception('회원 삭제 실패: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(handleDioError(e, '회원 삭제 실패'));
    }
  }
}