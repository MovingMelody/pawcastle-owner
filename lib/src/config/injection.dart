import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:petowner/src/constants/keys.dart';
import 'package:petowner/src/services/env_service.dart';
import 'package:petowner/src/app/setup.locator.dart';
import 'package:hive/hive.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class HiveInjection {
  /// To setup [Hive], you need to configure path and adapater registrations
  /// Inorder to presolve the additional config we make use of [HiveInjection]
  static Future<HiveInterface> getInstance() async {
    final appDocumentDir =
        await pathProvider.getApplicationDocumentsDirectory();

    final path = appDocumentDir.path;
    final hive = Hive;

    hive.init(path);


    return hive;
  }
}

class RtcInjection {
  static Future<RtcEngine> getAgoraEngine() async {
    final environnmentService = locator<EnvironmentService>();

    final String _appId = environnmentService.getValue(kAgoraAppId);
    var engine = await RtcEngine.create(_appId);

    await engine.enableAudio();
    await engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await engine.setClientRole(ClientRole.Broadcaster);

    return engine;
  }
}

class SharedPrefsInjection {
  /// Injects the regular [SharedPreferences] instance instead of [Future]
  static Future<SharedPreferences> getInstance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }
}

class PackageInjection {
  /// Injects the regular [PackageInfo] instance instead of [Future]
  static Future<PackageInfo> getInstance() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }
}
