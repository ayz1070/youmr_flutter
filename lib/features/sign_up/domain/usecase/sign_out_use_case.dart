import '../../../../core/constants/social_provider.dart';
import '../repository/member_repository.dart';

// class SignOutUseCase {
//   final MemberRepository memberRepository;
//
//   SignOutUseCase(this.memberRepository);
//
//   /// 소셜 계정 로그아웃
//   Future<void> call({
//     required SocialProvider provider,
//   }) async {
//     switch (provider) {
//       case SocialProvider.google:
//         await memberRepository.signOut(provider: SocialProvider.google);
//         break;
//       case SocialProvider.kakao:
//         await memberRepository.signOut(provider: SocialProvider.kakao);
//         break;
//       case SocialProvider.apple:
//         await memberRepository.signOut(provider: SocialProvider.apple);
//         break;
//     }
//   }
// }