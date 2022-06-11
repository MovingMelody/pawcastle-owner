// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../modules/home/views/main_view.dart';
import '../modules/onboarding/views/choose_language_view.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/onboarding/views/startup_view.dart';
import '../modules/treatment/views/available_doctors_view.dart';
import '../modules/treatment/views/caller_screen.dart';
import '../modules/treatment/views/treatment_rating_view.dart';
import '../modules/user/views/create_profile_view.dart';
import '../modules/user/views/login_view.dart';
import '../modules/user/views/verify_phone_view.dart';

class Routes {
  static const String startUpView = '/';
  static const String chooseLanguageView = '/choose-language-view';
  static const String onboardingView = '/onboarding-view';
  static const String loginView = '/login-view';
  static const String verifyPhoneView = '/verify-phone-view';
  static const String createProfileView = '/create-profile-view';
  static const String mainView = '/main-view';
  static const String availableDoctorsView = '/available-doctors-view';
  static const String callerScreen = '/caller-screen';
  static const String treatmentRatingView = '/treatment-rating-view';
  static const String treatmentDetailsView = '/treatment-details-view';
  static const all = <String>{
    startUpView,
    chooseLanguageView,
    onboardingView,
    loginView,
    verifyPhoneView,
    createProfileView,
    mainView,
    availableDoctorsView,
    callerScreen,
    treatmentRatingView,
    treatmentDetailsView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startUpView, page: StartUpView),
    RouteDef(Routes.chooseLanguageView, page: ChooseLanguageView),
    RouteDef(Routes.onboardingView, page: OnboardingView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.verifyPhoneView, page: VerifyPhoneView),
    RouteDef(Routes.createProfileView, page: CreateProfileView),
    RouteDef(Routes.mainView, page: MainView),
    RouteDef(Routes.availableDoctorsView, page: AvailableDoctorsView),
    RouteDef(Routes.callerScreen, page: CallerScreen),
    RouteDef(Routes.treatmentRatingView, page: TreatmentRatingView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    StartUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const StartUpView(),
        settings: data,
      );
    },
    ChooseLanguageView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ChooseLanguageView(),
        settings: data,
      );
    },
    OnboardingView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const OnboardingView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    VerifyPhoneView: (data) {
      var args = data.getArgs<VerifyPhoneViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => VerifyPhoneView(
          key: args.key,
          phoneNumber: args.phoneNumber,
        ),
        settings: data,
      );
    },
    CreateProfileView: (data) {
      var args = data.getArgs<CreateProfileViewArguments>(
        orElse: () => CreateProfileViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => CreateProfileView(key: args.key),
        settings: data,
      );
    },
    MainView: (data) {
      var args = data.getArgs<MainViewArguments>(
        orElse: () => MainViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => MainView(key: args.key),
        settings: data,
      );
    },
    AvailableDoctorsView: (data) {
      var args = data.getArgs<AvailableDoctorsViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => AvailableDoctorsView(
          key: args.key,
          userSelectedSpeciesType: args.userSelectedSpeciesType,
        ),
        settings: data,
      );
    },
    CallerScreen: (data) {
      var args = data.getArgs<CallerScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => CallerScreen(
          key: args.key,
          voicecall: args.voicecall,
        ),
        settings: data,
      );
    },
    TreatmentRatingView: (data) {
      var args = data.getArgs<TreatmentRatingViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => TreatmentRatingView(
          key: args.key,
          caseId: args.caseId,
          doctorId: args.doctorId,
        ),
        settings: data,
      );
    },
    
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// VerifyPhoneView arguments holder class
class VerifyPhoneViewArguments {
  final Key? key;
  final String phoneNumber;
  VerifyPhoneViewArguments({this.key, required this.phoneNumber});
}

/// CreateProfileView arguments holder class
class CreateProfileViewArguments {
  final Key? key;
  CreateProfileViewArguments({this.key});
}

/// MainView arguments holder class
class MainViewArguments {
  final Key? key;
  MainViewArguments({this.key});
}

/// AvailableDoctorsView arguments holder class
class AvailableDoctorsViewArguments {
  final Key? key;
  final String userSelectedSpeciesType;
  AvailableDoctorsViewArguments(
      {this.key, required this.userSelectedSpeciesType});
}

/// CallerScreen arguments holder class
class CallerScreenArguments {
  final Key? key;
  final Voicecall voicecall;
  CallerScreenArguments({this.key, required this.voicecall});
}

/// TreatmentRatingView arguments holder class
class TreatmentRatingViewArguments {
  final Key? key;
  final String caseId;
  final String doctorId;
  TreatmentRatingViewArguments(
      {this.key, required this.caseId, required this.doctorId});
}

/// TreatmentDetailsView arguments holder class
class TreatmentDetailsViewArguments {
  final Key? key;
  final String caseId;
  final bool startPayment;
  TreatmentDetailsViewArguments(
      {this.key, required this.caseId, this.startPayment = false});
}
