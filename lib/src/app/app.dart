import 'package:petowner/src/app/setup.locator.dart';
import 'package:petowner/src/app/setup.router.dart';
import 'package:petowner/src/services/key_storage_service.dart';
import 'package:petowner/src/localization/l10n.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:petowner/src/services/localization_service.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';

final _sharedPrefs = locator<KeyStorageService>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);
          return MaterialApp(
            title: 'PawCastle',
            supportedLocales: L10n.allLocales,
            theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                appBarTheme: const AppBarTheme(
                    iconTheme: IconThemeData(color: kTextPrimaryLightColor)),
                fontFamily: 'AppFont'),
            locale: _sharedPrefs.get("language") == null
                ? provider.locale
                : L10n.allLocales[L10n.allLocales.lastIndexOf(L10n.allLocales
                    .where((element) =>
                        element.languageCode == _sharedPrefs.get("language"))
                    .first)],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            navigatorKey: StackedService.navigatorKey,
            onGenerateRoute: StackedRouter().onGenerateRoute,
            debugShowCheckedModeBanner: false,
          );
        },
      );
}
