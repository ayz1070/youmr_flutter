import '../../domain/entity/user_entity.dart';
import '../../domain/repository/member_repository.dart';
import '../data_source/member_data_source.dart';
import '../dto/member_dto.dart';
import '../dto/social_sign_up_request_dto.dart';

class MemberRepositoryImpl implements MemberRepository {
  final MemberDataSource dataSource;

  MemberRepositoryImpl({required this.dataSource});

  @override
  Future<UserEntity> signUpWithSocial(UserEntity userEntity) async {
    final requestDto = SocialSignUpRequestDto(
      provider: userEntity.provider?.name ?? '',
      socialId: userEntity.providerId ?? '',
      nickname: userEntity.nickname,
      profileImageUrl: userEntity.profileImage,
      mbti: userEntity.mbti,
    );

    final MemberDto response = await dataSource.signUpWithSocial(requestDto);
    return response.toEntity();
  }

  @override
  Future<UserEntity> fetchMember(int memberId) async {
    final MemberDto response = await dataSource.fetchMember(memberId);
    return response.toEntity(); // DTO → Entity 변환
  }

  @override
  Future<void> deleteMember(int memberId) async {
    await dataSource.deleteMember(memberId);
  }
}
