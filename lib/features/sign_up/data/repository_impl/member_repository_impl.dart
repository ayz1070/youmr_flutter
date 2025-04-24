import '../../domain/entity/member_entity.dart';
import '../../domain/repository/member_repository.dart';
import '../data_source/member_data_source.dart';
import '../dto/member_response.dart';
import '../dto/social_sign_up_request_dto.dart';

class MemberRepositoryImpl implements MemberRepository {
  final MemberDataSource dataSource;

  MemberRepositoryImpl({required this.dataSource});

  @override
  Future<MemberEntity> signUpWithSocial(MemberEntity memberEntity) async {
    final requestDto = SocialSignUpRequestDto(
      provider: memberEntity.provider,
      socialId: memberEntity.socialId,
      name: memberEntity.name,
      nickname: memberEntity.nickname,
      profileImageUrl: memberEntity.profileImage,
    );

    final response = await dataSource.signUpWithSocial(requestDto);
    return response.toEntity(); // MemberResponse → MemberEntity
  }

  @override
  Future<MemberEntity> fetchMember(int memberId) async {
    final response = await dataSource.fetchMember(memberId);
    return response.toEntity();
  }

  @override
  Future<void> deleteMember(int memberId) async {
    await dataSource.deleteMember(memberId);
  }
}