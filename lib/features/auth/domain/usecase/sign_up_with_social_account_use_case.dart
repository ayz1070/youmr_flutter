import '../../../../core/constants/social_provider.dart';
import '../entity/user_entity.dart';
import '../repository/member_repository.dart';

class SignUpWithSocialAccountUseCase {
  final MemberRepository memberRepository;

  SignUpWithSocialAccountUseCase(this.memberRepository);

  /// 소셜 계정으로 회원가입 (비즈니스 로직 수행)
  Future<UserEntity?> call({
    required String nickname,
    required String mbti,
    required String profileImage,
  }) async {
    // UserEntity 생성 (비즈니스 로직이 UseCase에 있음)
    final userEntity = UserEntity(
      id: '', // ID는 백엔드에서 생성됨
      nickname: nickname,
      mbti: mbti,
      profileImage: profileImage,
      provider: SocialProvider.KAKAO, // 예시로 Google로 설정 (추후 동적 처리 가능)
    );

    return await memberRepository.signUpWithSocial(userEntity);
  }
}
