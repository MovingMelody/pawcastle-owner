import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';

extension AddressFormatter on Address {
  String get formattedAddress => _formatAddress(this);
  String _formatAddress(Address _address) {
    String? formattedAddress;
    formattedAddress = _address.name +
        " " +
        _address.phone +
        "\n" +
        _address.city +
        " " +
        _address.state +
        "\n" +
        _address.zipcode.toString();
    return formattedAddress;
  }
}

extension DiscountPercentageCalculator on double {
  int get getDiscountPercentage => calculateDiscount(this, this);
  static int calculateDiscount(double sellingPrice, double mrp) {
    int _result = 0;
    _result = (((mrp - sellingPrice) / mrp) * 100).toInt();
    return _result;
  }
}

extension FreeTreatmentParser on String {
  bool get isFarmAnimals =>
      this == "cattle" ||
      this == "buffalo" ||
      this == "sheep" ||
      this == "goat";
}
