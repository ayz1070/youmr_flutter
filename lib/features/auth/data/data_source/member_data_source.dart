import '../dto/member_dto.dart';
import '../dto/social_sign_up_request_dto.dart';

abstract class MemberDataSource {
  Future<MemberDto> signUpWithSocial(SocialSignUpRequestDto request);
  Future<MemberDto> fetchMember(int memberId);
  Future<void> deleteMember(int memberId);
}