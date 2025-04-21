import '../entity/user_entity.dart';

abstract class MemberRepository {
  Future<UserEntity> signUpWithSocial(UserEntity userEntity);

  Future<UserEntity> fetchMember(int memberId);

  Future<void> deleteMember(int memberId);
}