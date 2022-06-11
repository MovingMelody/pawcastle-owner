// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String NameValueKey = 'name';
const String CityNameValueKey = 'cityName';
const String PlaceOrBuildingNameValueKey = 'placeOrBuildingName';
const String LandmarkValueKey = 'landmark';

mixin $CreateProfileView on StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityNameController = TextEditingController();
  final TextEditingController placeOrBuildingNameController =
      TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode cityNameFocusNode = FocusNode();
  final FocusNode placeOrBuildingNameFocusNode = FocusNode();
  final FocusNode landmarkFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    nameController.addListener(() => _updateFormData(model));
    cityNameController.addListener(() => _updateFormData(model));
    placeOrBuildingNameController.addListener(() => _updateFormData(model));
    landmarkController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            NameValueKey: nameController.text,
            CityNameValueKey: cityNameController.text,
            PlaceOrBuildingNameValueKey: placeOrBuildingNameController.text,
            LandmarkValueKey: landmarkController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    nameController.dispose();
    nameFocusNode.dispose();
    cityNameController.dispose();
    cityNameFocusNode.dispose();
    placeOrBuildingNameController.dispose();
    placeOrBuildingNameFocusNode.dispose();
    landmarkController.dispose();
    landmarkFocusNode.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String? get nameValue => this.formValueMap[NameValueKey];
  String? get cityNameValue => this.formValueMap[CityNameValueKey];
  String? get placeOrBuildingNameValue =>
      this.formValueMap[PlaceOrBuildingNameValueKey];
  String? get landmarkValue => this.formValueMap[LandmarkValueKey];

  bool get hasName => this.formValueMap.containsKey(NameValueKey);
  bool get hasCityName => this.formValueMap.containsKey(CityNameValueKey);
  bool get hasPlaceOrBuildingName =>
      this.formValueMap.containsKey(PlaceOrBuildingNameValueKey);
  bool get hasLandmark => this.formValueMap.containsKey(LandmarkValueKey);
}

extension Methods on FormViewModel {}
