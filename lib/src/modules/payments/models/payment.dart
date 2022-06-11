class Payment {
  final String paymentId; //razorpay payment id
  final String orderId; // razorpay order id
  final String timestamp;
  final String userId;

  /// enum - `SHOP`, `TREATMENT`
  final String type;
  final double amount;
  final String reference; // document reference of the type doc

  const Payment({
    required this.amount,
    required this.paymentId,
    required this.orderId,
    required this.timestamp,
    required this.type,
    required this.userId,
    required this.reference,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'payment_id': paymentId,
      'order_id': orderId,
      'timestamp': timestamp,
      'type': type,
      'reference': reference,
      'amount': amount,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      userId: map['user_id'],
      paymentId: map['payment_id'],
      orderId: map['order_id'],
      timestamp: map['timestamp'],
      type: map['type'],
      reference: map['reference'],
      amount: map['amount'],
    );
  }

  @override
  String toString() {
    return 'Payment(paymentId: $paymentId, orderId: $orderId, timestamp: $timestamp, userId: $userId, type: $type, amount: $amount, reference: $reference)';
  }
}
