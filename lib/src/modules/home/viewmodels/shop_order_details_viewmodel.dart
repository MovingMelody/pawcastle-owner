import 'package:petowner/src/app/setup.logger.dart';
import 'package:petowner/src/constants/keys.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopOrderDetailsViewModel extends BaseViewModel {
  final _log = getLogger("ShopOrderDetailsViewModel");

  needHelp(String orderId) {
    String url =
        "https://wa.me/${kSupportPhone}/?text=Hello, I need help with shop order with id: $orderId";
    var encoded = Uri.encodeFull(url);
    launch(encoded);
  }
}
