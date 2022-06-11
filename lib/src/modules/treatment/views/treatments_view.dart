import 'package:petowner/src/modules/treatment/widgets/treatment_card.dart';
import 'package:petowner/src/modules/treatment/viewmodels/treatments_viewmodel.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TreatmentsView extends StatelessWidget {
  const TreatmentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TreatmentsViewModel>.reactive(
      onModelReady: (model) => model.getTreatments(),
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      builder: (context, model, child) => DefaultTabController(
        length: 1,
        child: Scaffold(
            appBar: const TabBar(
                indicatorColor: kCoreColor,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: kTextPrimaryLightColor,
                unselectedLabelColor: kTextSecondaryLightColor,
                tabs: [Tab(text: "Your Pet Treatments")]),
            backgroundColor: kBackgroundColor,
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                RefreshIndicator(
                  onRefresh: () async {
                    model.getTreatments();
                  },
                  child: Container(
                      width: double.infinity,
                      color: kBackgroundColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8.0),
                      child: model.isBusy
                          ? Center(child: BusyLoader())
                          : model.allUserTreatments.isEmpty
                              ? const Center(
                                  child: Text("No Treatments History found"),
                                )
                              : ListView(
                                  children: model.allUserTreatments
                                      .map((treatment) => InkWell(
                                          child: TreatmentCard(
                                              shareMedicines: () => model
                                                  .shareMedicines(treatment),
                                              treatment: treatment)))
                                      .toList(),
                                )),
                ),
              ],
            )),
      ),
      viewModelBuilder: () => TreatmentsViewModel(),
    );
  }
}
