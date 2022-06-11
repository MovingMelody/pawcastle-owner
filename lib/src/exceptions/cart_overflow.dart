class CartOverFlowException implements Exception {
  final String message = "Items in the cart exceeded the limit";

  @override
  String toString() {
    return 'CartOverFlowException: $message';
  }
}

class NoStockException implements Exception {
  final String message;

  NoStockException({this.message = "The desired quantity is not available"});

  @override
  String toString() {
    return 'NoStockException: $message';
  }
}

class CartWeightOverflowException implements Exception {
  final String message;

  CartWeightOverflowException(
      {this.message = "Max cart products weight : 10kg"});

  @override
  String toString() {
    return 'CartWeightOverflowException: $message';
  }
}
