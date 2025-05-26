import '../dto/member_response.dart';
import '../dto/sign_up_response.dart';
import '../dto/social_sign_up_request_dto.dart';

abstract class MemberDataSource {
  Future<SignUpResponse> signUpWithSocial(SocialSignUpRequestDto request);
  Future<MemberResponse> fetchMember(int memberId);
  Future<MemberResponse> fetchMemberBySocialId(String socialId);
  Future<void> deleteMember(int memberId);
}