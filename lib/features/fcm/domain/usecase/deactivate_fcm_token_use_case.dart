import '../repository/fcm_repository.dart';

class DeactivateFcmTokenUseCase {
  final FcmRepository repository;

  DeactivateFcmTokenUseCase({required this.repository});

  Future<bool> call(String memberId) async{
    return await repository.deactivateToken(memberId: memberId);
  }
}