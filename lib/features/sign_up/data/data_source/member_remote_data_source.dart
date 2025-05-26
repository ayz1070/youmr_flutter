import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/error_handler.dart';
import '../dto/member_response.dart';
import '../dto/sign_up_response.dart';
import '../dto/social_sign_up_request_dto.dart';
import 'member_data_source.dart';

class MemberRemoteDataSource implements MemberDataSource {
  final Dio dio;

  MemberRemoteDataSource({required this.dio});

  static const String _endPoint = '/members';

  @override
  Future<SignUpResponse> signUpWithSocial(SocialSignUpRequestDto request) async {
    try {
      final response = await dio.post('$_endPoint/signup', data: request.toJson());
      final signUpResponse = SignUpResponse.fromJson(response.data);

      // 서버에서 생성된 Firebase Custom Token으로 로그인 (초기 1회)
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        await FirebaseAuth.instance.signInWithCustomToken(signUpResponse.firebaseToken);
      }

      return signUpResponse;
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
  Future<MemberResponse> fetchMemberBySocialId(String socialId) async {
    try {
      final response = await dio.get('$_endPoint/social/$socialId');
      return MemberResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return Future.error('회원 정보가 존재하지 않습니다.');
      }
      throw Exception(handleDioError(e, '소셜 아이디로 회원 조회 실패'));
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