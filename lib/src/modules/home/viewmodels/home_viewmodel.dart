import 'package:petowner/src/exceptions/firestore_exception.dart';
import 'package:petowner/src/modules/home/models/species_group.dart';
import 'package:petowner/src/modules/home/services/firestore.dart';
import 'package:petowner/src/app/setup.locator.dart';
import 'package:petowner/src/app/setup.logger.dart';
import 'package:petowner/src/app/setup.router.dart';
import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _log = getLogger("HomeViewModel");
  final _firestoreApi = locator<FirestoreApi>();

  List<String> homePageBanners = [];
  List<SpeciesGroup> animalsData = [];

  List<String> get getHomePageBanners => homePageBanners;
  List<SpeciesGroup> get getAnimalCategories => animalsData;

  List<MedicineOrder> paymentOrders = [];

  void fetchHomePageData() async {
    setBusy(true);

    try {
      List banners = [
        "https://www.yashodahospitals.com/online-doctor-consultation/wp-content/uploads/2020/05/Covid-campine-banner-mobile.jpg",
        "https://firebasestorage.googleapis.com/v0/b/vetremedihq.appspot.com/o/ui_utils%2Fbanners%2FFrame%206.png?alt=media&token=ad8760f2-3ebf-4aa4-b767-4c6e2c8a5171",
      ];

      banners.forEach((element) {
        homePageBanners.add(element.toString());
      });

      List species = await _firestoreApi.fetchAnimalCategories();

      animalsData = species.map((e) => SpeciesGroup.fromMap(e)).toList();
    } on FirestoreApiException catch (error) {
      _log.e(error);
    }

    setBusy(false);
  }

  void getPaymentOrders() {
    setBusy(true);
    _firestoreApi.getPaymentOrders().listen((event) {
      paymentOrders = event;
      notifyListeners();
    });
    setBusy(false);
  }

  void navigateToAvailableDoctors(String selectedSpecies) {
    _log.v("user selected animal is : $selectedSpecies");
    _navigationService.navigateTo(Routes.availableDoctorsView,
        arguments: AvailableDoctorsViewArguments(
            userSelectedSpeciesType: selectedSpecies));
  }

  void payOrder(MedicineOrder order) =>
      _navigationService.navigateTo(Routes.treatmentDetailsView,
          arguments: TreatmentDetailsViewArguments(
              caseId: order.caseId, startPayment: true));
}
