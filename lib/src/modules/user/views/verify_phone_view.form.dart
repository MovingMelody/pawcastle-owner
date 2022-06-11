// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String VerificationValueKey = 'verification';

mixin $VerifyPhoneView on StatelessWidget {
  final TextEditingController verificationController = TextEditingController();
  final FocusNode verificationFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    verificationController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            VerificationValueKey: verificationController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    verificationController.dispose();
    verificationFocusNode.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String? get verificationValue => this.formValueMap[VerificationValueKey];

  bool get hasVerification =>
      this.formValueMap.containsKey(VerificationValueKey);
}

extension Methods on FormViewModel {}
