import '../entity/member_entity.dart';

abstract class MemberRepository {
  Future<MemberEntity> signUpWithSocial(MemberEntity memberEntity);

  Future<MemberEntity> fetchMember(int memberId);

  Future<void> deleteMember(int memberId);
}