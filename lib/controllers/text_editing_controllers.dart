import 'package:flutter/material.dart';

class FormControllers {
  final TextEditingController carNameController = TextEditingController();
  final TextEditingController carModelController = TextEditingController();
  final TextEditingController carYearController = TextEditingController();
  final TextEditingController carColorController = TextEditingController();
  final TextEditingController carPriceController = TextEditingController();
  final TextEditingController carPhotoController = TextEditingController();

  checkControllers(dynamic carName, dynamic carModel, dynamic carYear, dynamic carColor,
      dynamic carPrice, dynamic carWikipediaLink) {
    if (carName.toString().trim().length < 3) return false;
    if (carModel.toString().trim().length < 2) return false;
    if (carYear.toString().trim().length < 4) return false;
    if (carPrice < 99) return false;
    if (carColor.toString().trim().length < 3) return false;
    if (carWikipediaLink.toString().trim().length < 6) return false;
    return true;
  }

  // cand adaugam un obiect casa, stergem tot ce e in atributele noastre
  resetController(
      TextEditingController carNameController,
      TextEditingController carModelController,
      TextEditingController carYearController,
      TextEditingController carColorController,
      TextEditingController carPriceController,
      TextEditingController carPhotoController) {
    carNameController.clear(); // ni se fac null de ex
    carModelController.clear();
    carYearController.clear();
    carColorController.clear();
    carPriceController.clear();
    carPhotoController.clear();
  }
}
