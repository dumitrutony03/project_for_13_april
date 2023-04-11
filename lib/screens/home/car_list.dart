import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/car.dart';

class CarList extends StatefulWidget {
  @override
  _CarListState createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  @override
  Widget build(BuildContext context) {

    final cars = Provider.of<List<Car>>(context);
    cars.forEach((car) {
      print(car.carName);
      print(car.carColor);
    });
    return Container(
      
    );
  }
}