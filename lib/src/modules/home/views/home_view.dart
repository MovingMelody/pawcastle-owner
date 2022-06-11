import 'package:carousel_slider/carousel_slider.dart';
import 'package:petowner/src/constants/assets.dart';
import 'package:petowner/src/localization/animal_names.dart';
import 'package:petowner/src/modules/home/widgets/home_tile.dart';
import 'package:petowner/src/modules/home/widgets/species_tile.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../viewmodels/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) {
        model.fetchHomePageData();
        model.getPaymentOrders();
      },
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      builder: (context, model, child) => Scaffold(
        backgroundColor: kBackgroundColor,
        body: model.isBusy
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: CarouselSlider(
                        options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 16 / 6,
                            viewportFraction: 1,
                            enlargeCenterPage: true),
                        items: model.getHomePageBanners
                            .map((item) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Center(
                                        child: FadeInImage.assetNetwork(
                                            placeholder: bannerPlaceHolder,
                                            image: item.toString(),
                                            fit: BoxFit.cover,
                                            width: double.infinity)),
                                  ),
                                ))
                            .toList(),
                      )),
                  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      HomeTile(
                          onTap: () =>
                              model.navigateToAvailableDoctors("cattle"),
                          asset: kConsultAsset,
                          subtitle: "Talk to doctor instantly",
                          title: "Consult"),
                    ],
                  ),
                  verticalSpaceSmall,
                  ...model.getAnimalCategories
                      .map((e) => (e.type != "farm animals" &&
                              e.type != "exotic birds/others")
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                UIText.label(getAnimalName(context, e.type)),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 5,
                                  margin: const EdgeInsets.only(top: 4),
                                  child: ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: e.species
                                        .map((eachSpecies) => InkWell(
                                              onTap: () => model
                                                  .navigateToAvailableDoctors(
                                                      eachSpecies.name),
                                              child: SpeciesTile(
                                                species: eachSpecies,
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox())
                      .toList()
                ],
              ),
      ),
    );
  }
}
