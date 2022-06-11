import 'package:petowner/src/config/injection.dart';
import 'package:petowner/src/modules/payments/services/payment_service.dart';
import 'package:petowner/src/modules/treatment/services/rating_service.dart';
import 'package:petowner/src/modules/treatment/services/treatment_service.dart';
import 'package:petowner/src/modules/treatment/views/treatment_rating_view.dart';
import 'package:petowner/src/modules/onboarding/views/choose_language_view.dart';
import 'package:petowner/src/services/fcm_service.dart';
import 'package:pawcastle_phoneauth/pawcastle_phoneauth.dart';
import 'package:petowner/src/modules/home/services/firestore.dart';
import 'package:petowner/src/modules/treatment/services/call_service.dart';
import 'package:petowner/src/services/env_service.dart';
import 'package:petowner/src/services/key_storage_service.dart';
import 'package:petowner/src/services/location_service.dart';
import 'package:petowner/src/services/open_link_service.dart';
import 'package:petowner/src/modules/user/services/user_service.dart';
import 'package:petowner/src/modules/treatment/views/caller_screen.dart';
import 'package:petowner/src/modules/treatment/views/available_doctors_view.dart';
import 'package:petowner/src/modules/home/views/main_view.dart';
import 'package:petowner/src/modules/user/views/create_profile_view.dart';
import 'package:petowner/src/modules/user/views/login_view.dart';
import 'package:petowner/src/modules/onboarding/views/onboarding_view.dart';
import 'package:petowner/src/modules/onboarding/views/startup_view.dart';
import 'package:petowner/src/modules/user/views/verify_phone_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

/// Note: After making changes please run
/// flutter pub run build_runner build --delete-conflicting-outputs
@StackedApp(
  routes: [
    /// All your application routes needs to be injected here
    /// Two default routes available -
    ///   #1. MaterialRoute(page: page)
    ///   #2. CupertinoRoute(page: page)
    MaterialRoute(page: StartUpView, initial: true),
    MaterialRoute(page: ChooseLanguageView),
    MaterialRoute(page: OnboardingView),

    MaterialRoute(page: LoginView),
    MaterialRoute(page: VerifyPhoneView),
    MaterialRoute(page: CreateProfileView),

    MaterialRoute(page: MainView),
    MaterialRoute(page: AvailableDoctorsView),
    MaterialRoute(page: CallerScreen),
    MaterialRoute(page: TreatmentRatingView),

  ],
  dependencies: [
    /// Inject your dependencies here
    /// Basic Format: ObjectType(classType: Class)
    /// Singletons - Singleton(classType: NavigationService),
    /// LazySingleton - LazySingleton(classType: NavigationService),
    /// Factory - Factory(classType: NavigationService),
    Presolve(
      classType: EnvironmentService,
      presolveUsing: EnvironmentService.getInstance,
    ),
    Presolve(
      classType: HiveInjection,
      presolveUsing: HiveInjection.getInstance,
    ),
    Presolve(
      classType: PackageInjection,
      presolveUsing: PackageInjection.getInstance,
    ),
    Presolve(
      classType: SharedPreferences,
      presolveUsing: SharedPrefsInjection.getInstance,
    ),
    Presolve(
        classType: RtcInjection, presolveUsing: RtcInjection.getAgoraEngine),

    LazySingleton(classType: KeyStorageService),
    LazySingleton(classType: LocationService),
    LazySingleton(classType: OpenLinkService),
    LazySingleton(classType: FcmService),

    Factory(classType: Razorpay),

    LazySingleton(classType: FirebaseAuthApi),
    LazySingleton(classType: FirestoreApi),
    LazySingleton(classType: UserService),
    LazySingleton(classType: CallService),
    LazySingleton(classType: TreatmentService),
    LazySingleton(classType: TreatmentRatingService),

    // Stacked Services
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: PaymentService),
  ],
  logger: StackedLogger(),
)
class Setup {
  /** Serves no purpose besides having an annotation attached to it */
}
