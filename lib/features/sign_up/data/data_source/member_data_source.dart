import '../dto/member_response.dart';
import '../dto/social_sign_up_request_dto.dart';

abstract class MemberDataSource {
  Future<MemberResponse> signUpWithSocial(SocialSignUpRequestDto request);
  Future<MemberResponse> fetchMember(int memberId);
  Future<void> deleteMember(int memberId);
}