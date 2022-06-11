import 'package:petowner/src/app/setup.locator.dart';
import 'package:petowner/src/app/setup.logger.dart';
import 'package:petowner/src/services/key_storage_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FcmService {
  final _fcm = FirebaseMessaging.instance;
  final _keystorageService = locator<KeyStorageService>();
  final _log = getLogger("FcmService");

  Future<String?> generateToken() async => await _fcm.getToken();

  Future<String?> getUpdatedToken(String? token) async {
    var newToken = await _fcm.getToken();
    _log.i(newToken);

    if (token == null || newToken != token)
      return newToken;
    else
      return null;
  }

  Future subscribeTopic({required String topic, required String userId}) async {
    _log.i('Subscribing to $topic');

    var key = "${userId}_$topic";
    var value = _keystorageService.get(key);

    if (value != null) {
      _log.i("already subscribed");
    }

    try {
      await _fcm.subscribeToTopic(topic);
      await _keystorageService.save<bool>(key, true);
    } catch (e) {
      _log.e('$e');
    }
  }
}
