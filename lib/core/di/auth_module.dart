import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youmr_flutter/core/di/dio_provider.dart';
import 'package:youmr_flutter/features/sign_up/data/service/social_auth_service.dart';

import '../../features/sign_up/data/data_source/member_data_source.dart';
import '../../features/sign_up/data/data_source/member_remote_data_source.dart';
import '../../features/sign_up/data/repository_impl/member_repository_impl.dart';
import '../../features/sign_up/domain/repository/member_repository.dart';
import '../../features/sign_up/domain/usecase/fetch_member_by_social_id_use_case.dart';
import '../../features/sign_up/domain/usecase/sign_in_with_social_account_use_case.dart';
import '../../features/sign_up/domain/usecase/sign_up_with_social_account_use_case.dart';
import '../../features/sign_up/presentation/state/sign_in_state.dart';
import '../../features/sign_up/presentation/state/sign_up_state.dart';
import '../../features/sign_up/presentation/viewmodel/sign_in_view_model.dart';
import '../../features/sign_up/presentation/viewmodel/sign_up_view_model.dart';


final memberDataSourceProvider = Provider<MemberDataSource>((ref) {
  return MemberRemoteDataSource(dio: ref.read(dioProvider));
});

final socialAuthServiceProvider = Provider<SocialAuthService>((ref) {
  return SocialAuthService();
});

final memberRepositoryProvider = Provider<MemberRepository>((ref){
  return MemberRepositoryImpl(dataSource: ref.read(memberDataSourceProvider));
});

// UseCase Providers
final signUpUseCaseProvider = Provider<SignUpWithSocialAccountUseCase>((ref) {
  return SignUpWithSocialAccountUseCase(ref.read(memberRepositoryProvider));
});

final signInUseCaseProvider = Provider<SignInWithSocialAccountUseCase>((ref) {
  return SignInWithSocialAccountUseCase();
});

final fetchMemberBySocialIdUseCaseProvider = Provider<FetchMemberBySocialIdUseCase>((ref) {
  return FetchMemberBySocialIdUseCase(ref.read(memberRepositoryProvider));
});

// ViewModel Providers
final signUpViewModelProvider = StateNotifierProvider<SignUpViewModel, SignUpState>(
      (ref) => SignUpViewModel(ref.read(signUpUseCaseProvider)),
);

final signInViewModelProvider = StateNotifierProvider<SignInViewModel, SignInState>(
      (ref) => SignInViewModel(ref.read(socialAuthServiceProvider)),
);