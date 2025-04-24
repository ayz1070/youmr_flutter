import '../../../../core/constants/social_provider.dart';
import '../entity/member_entity.dart';
import '../entity/role.dart';
import '../repository/member_repository.dart';

class SignUpWithSocialAccountUseCase {
  final MemberRepository memberRepository;

  SignUpWithSocialAccountUseCase(this.memberRepository);

  /// 소셜 계정으로 회원가입 (비즈니스 로직 수행)
  Future<MemberEntity> call({
    required String socialId,
    required SocialProvider provider,
    required String name,
    required String nickname,
    required String profileImage,
    required Role role,
  }) async {
    final member = MemberEntity(
      socialId: socialId,
      provider: provider,
      name: name,
      nickname: nickname,
      profileImage: profileImage,
      role: role,
    );

    return await memberRepository.signUpWithSocial(member);
  }
}