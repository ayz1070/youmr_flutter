import '../repository/fcm_repository.dart';

class SendPurchaseNotificationUseCase {
  final FcmRepository repository;

  SendPurchaseNotificationUseCase({required this.repository});

  Future<bool> call({
    required String buyerId,
    required String sellerId,
  }) async{
    return await repository.sendPurchaseNotification(
      buyerId: buyerId,
      sellerId: sellerId,
    );
  }
}