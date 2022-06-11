// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:pawcastle_phoneauth/pawcastle_phoneauth.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../config/injection.dart';
import '../modules/home/services/firestore.dart';
import '../modules/payments/services/payment_service.dart';
import '../modules/treatment/services/call_service.dart';
import '../modules/treatment/services/rating_service.dart';
import '../modules/treatment/services/treatment_service.dart';
import '../modules/user/services/user_service.dart';
import '../services/env_service.dart';
import '../services/fcm_service.dart';
import '../services/key_storage_service.dart';
import '../services/location_service.dart';
import '../services/open_link_service.dart';

final locator = StackedLocator.instance;

Future setupLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  final environmentService = await EnvironmentService.getInstance();
  locator.registerSingleton(environmentService);

  final hiveInjection = await HiveInjection.getInstance();
  locator.registerSingleton(hiveInjection);

  final packageInjection = await PackageInjection.getInstance();
  locator.registerSingleton(packageInjection);

  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton(sharedPreferences);

  final rtcInjection = await RtcInjection.getAgoraEngine();
  locator.registerSingleton(rtcInjection);

  locator.registerLazySingleton(() => KeyStorageService());
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => OpenLinkService());
  locator.registerLazySingleton(() => FcmService());
  locator.registerFactory(() => Razorpay());
  locator.registerLazySingleton(() => FirebaseAuthApi());
  locator.registerLazySingleton(() => FirestoreApi());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => CallService());
  locator.registerLazySingleton(() => TreatmentService());
  locator.registerLazySingleton(() => TreatmentRatingService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => PaymentService());
}
