import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Car extends StatelessWidget {
  final String? carName;
  final String? carModel;
  final String? carYear;
  final String? carColor;
  final int? carPrice;
  final String? carPhoto;

  Car({required this.carName, required this.carModel, required this.carYear, required this.carColor, required this.carPrice, required this.carPhoto});

  Map<String, dynamic> toJson() => {
    'carName': carName,
    'carModel': carModel,
    'carYear': carYear,
    'carColor': carColor,
    'carPrice': carPrice,
    'carPhoto': carPhoto,
  };

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
