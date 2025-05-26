import '../../../../core/constants/social_provider.dart';
import '../entity/member_entity.dart';
import '../entity/role.dart';
import '../repository/member_repository.dart';

class FetchMemberBySocialIdUseCase {
  final MemberRepository memberRepository;

  FetchMemberBySocialIdUseCase(this.memberRepository);

  /// 소셜 계정으로 회원가입 (비즈니스 로직 수행)
  Future<MemberEntity> call({
    required String socialId,
  }) async {

    return await memberRepository.fetchMemberBySocialId(socialId);
  }
}