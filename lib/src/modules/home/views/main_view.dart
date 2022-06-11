import 'package:badges/badges.dart';
import 'package:petowner/src/constants/assets.dart';
import 'package:petowner/src/services/localization_service.dart';
import 'package:petowner/src/utils/iconpack.dart';
import 'package:petowner/src/widgets/appbar_logo.dart';
import 'package:petowner/src/widgets/lazy_indexed_stack.dart';
import 'package:petowner/src/modules/home/viewmodels/main_viewmodel.dart';
import 'package:petowner/src/modules/home/views/home_view.dart';
import 'package:petowner/src/modules/home/views/profile_view.dart';
import 'package:petowner/src/modules/treatment/views/treatments_view.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainView extends StatelessWidget {
  MainView({Key? key}) : super(key: key);

  final _views = [
    HomeView(),
    const TreatmentsView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context, listen: false);

    return ViewModelBuilder<MainViewModel>.reactive(
      builder: (context, model, child) => WillPopScope(
        onWillPop: () => model.showExitDialog(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kBackgroundColor,
            elevation: .5,
            title: const AppbarLogo(
              centerTitle: false,
              logoImage: kAppIcon,
            ),
            automaticallyImplyLeading: false,
            actions: [
              PopupMenuButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.translate),
                tooltip: "Change Language",
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: GestureDetector(
                        onTap: () {
                          provider.setLocale('en');
                          Navigator.pop(context);
                        },
                        child: const Text("English")),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: GestureDetector(
                        onTap: () {
                          provider.setLocale('te');
                          Navigator.pop(context);
                        },
                        child: const Text("తెలుగు")),
                    value: 2,
                  ),
                ],
              ),
            ],
          ),
          body: LazyIndexedStack(
            reuse: true,
            index: model.currentIndex,
            itemCount: _views.length,
            itemBuilder: (_, index) => _views[index],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: kBackgroundColor,
            currentIndex: model.currentIndex,
            onTap: model.setIndex,
            items: [
              BottomNavigationBarItem(
                label: AppLocalizations.of(context)!.menuHome,
                icon: const Icon(IconPack.home),
              ),
              BottomNavigationBarItem(
                label: AppLocalizations.of(context)!.menuMedicines,
                icon: const Icon(IconPack.receipt),
              ),
              BottomNavigationBarItem(
                label: AppLocalizations.of(context)!.menuProfile,
                icon: const Icon(IconPack.person),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => MainViewModel(),
    );
  }
}
