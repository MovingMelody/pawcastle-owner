/// Exception raised when the order can't be cancelled.
/// Note: only paid orders are allowed to be cancelled
class CancelOrderError implements Exception {
  final String message;

  CancelOrderError({this.message = "order can't be cancelled!"});

  @override
  String toString() {
    return 'CancelOrderError: $message';
  }
}
