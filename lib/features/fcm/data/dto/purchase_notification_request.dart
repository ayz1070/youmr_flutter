class PurchaseNotificationRequest {
  final String buyerId;
  final String sellerId;

  PurchaseNotificationRequest({
    required this.buyerId,
    required this.sellerId,
  });

  Map<String, dynamic> toJson() {
    return {
      'buyer_id': buyerId,
      'seller_id': sellerId,
    };
  }
}