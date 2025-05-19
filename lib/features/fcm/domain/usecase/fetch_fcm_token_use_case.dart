import '../entity/fcm_token_entity.dart';
import '../repository/fcm_repository.dart';

class FetchFcmTokenUseCase {
  final FcmRepository repository;

  FetchFcmTokenUseCase({required this.repository});

  Future<FcmTokenEntity> call(String memberId) async{
    return await repository.fetchFcmTokenByMember(memberId: memberId);
  }
}