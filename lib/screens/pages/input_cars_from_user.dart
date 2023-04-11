import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/text_editing_controllers.dart';
import '../../models/car.dart';
import '../../services/database.dart';
import '../../shared/constants.dart';
import '../../shared/loading.dart';
import 'car_list_view.dart';

class InputCarsFromUser extends StatefulWidget {
  @override
  _InputCarsFromUserState createState() => _InputCarsFromUserState();
}

class _InputCarsFromUserState extends State<InputCarsFromUser> {
  @override
  void reset_textFields() {
    // give parameters
    // Clean up the controller when the widget is disposed.
    _myController.carNameController.clear();
    _myController.carColorController.clear();
    _myController.carPriceController.clear();
    _myController.carPhotoController.clear();
  }

  final _myController = FormControllers();

  String? carName = '';
  String? carModel = '';
  String? carYear = '';
  String? carColor = '';
  int? carPrice = 0;
  String? carPhoto = '';

  bool load = false;

  @override
  Widget build(BuildContext context) {

    /// Document of our CarsCollection ( Check database.dart for more informations )
    /// We are sending this to the CarListView page thorought the navigator
    final cars = Provider.of<List<Car>>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextField(
              controller: _myController.carNameController,
              keyboardType: TextInputType.text,
              obscureText: false,
              decoration: textInputDecoration.copyWith(hintText: 'carName'),
            ),
            SizedBox(height: 32),
            TextField(
              controller: _myController.carModelController,
              keyboardType: TextInputType.text,
              obscureText: false,
              decoration: textInputDecoration.copyWith(hintText: 'carModel'),
            ),
            SizedBox(height: 32),
            TextField(
              controller: _myController.carYearController,
              keyboardType: TextInputType.text,
              obscureText: false,
              decoration: textInputDecoration.copyWith(hintText: 'carYear'),
            ),
            SizedBox(height: 32),
            TextField(
              controller: _myController.carColorController,
              keyboardType: TextInputType.text,
              obscureText: false,
              decoration: textInputDecoration.copyWith(hintText: 'carColor'),
            ),
            SizedBox(height: 32),
            TextField(
              controller: _myController.carPriceController,
              keyboardType: TextInputType.number,
              obscureText: false,
              decoration: textInputDecoration.copyWith(hintText: 'carPrice'),
            ),
            SizedBox(height: 32),
            TextField(
              controller: _myController.carPhotoController,
              keyboardType: TextInputType.text,
              obscureText: false,
              decoration:
                  textInputDecoration.copyWith(hintText: 'carLinkWikipedia'),
            ),
            SizedBox(height: 32),

            // ADD CAR BUTTON
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text(
                      'Add car',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                        child: Container(
                          color: Colors.brown[400],
                          height: 50,
                          width: 75,
                          child: const Icon(
                            IconData(0xe1d7, fontFamily: 'MaterialIcons'),
                            size: 40,
                            color: Colors.white70,
                          ),
                        ),
                        onTap: () async {
                          /*final user = FirebaseAuth.instance.currentUser;
                  String? uid = user?.uid;
                  print('USER ACTUAL $uid');*/

                          /// validate controllers
                          carName = _myController.carNameController.text;
                          carModel = _myController.carModelController.text;
                          carYear = _myController.carYearController.text;
                          carColor = _myController.carColorController.text;
                          carPrice =
                              int.parse(_myController.carPriceController.text);
                          carPhoto = _myController.carPhotoController.text;

                          /// check if the input provided by the user is VALID
                          bool result = FormControllers().checkControllers(
                              carName,
                              carModel,
                              carYear,
                              carColor,
                              carPrice,
                              carPhoto);

                          print('REZULT IS $result');

                          /*
                  We can add an object into our database, with an UNIQUE ID
                  using this method:
                  -> We create a "car" object, we then add into our
                  collection "CarsCollection" our car in JSON format with
                  an ID automated generated by Firebase Google Cloud.
                   */
                          if (result) {
                            Car car = Car(
                                carName: carName,
                                carModel: carModel,
                                carYear: carYear,
                                carColor: carColor,
                                carPrice: carPrice,
                                carPhoto: carPhoto);
                            await FirebaseFirestore.instance
                                .collection("CarsCollection")
                                .add(car.toJson())
                                .then((DocumentReference doc) {
                              print('My document id is ${doc.id}');
                            });

                            print('AM ADAUGAT IN BAZA NOASTRA DE DATE');
                          }

                          /// We then clear our Textfields
                          FormControllers().resetController(
                              _myController.carNameController,
                              _myController.carModelController,
                              _myController.carYearController,
                              _myController.carColorController,
                              _myController.carPriceController,
                              _myController.carPhotoController);
                        }),
                  ],
                ),

                /// Another GestureDetector to view our cars and details
                /// That we added before
                Column(children: [
                  const Text(
                    'View cars list',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    child: Container(
                      color: Colors.brown[400],
                      height: 50,
                      width: 75,
                      child: const Icon(
                        IconData(0xe1b8, fontFamily: 'MaterialIcons'),
                        size: 40,
                        color: Colors.white70,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        load = true;
                      });

                      // We send the cars from DATABASE to be shown in the CarListView
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CarListView(carsFromFirebase: cars,)),
                      );
                    },
                  ),
                ])
              ],
            ),

            // For the next page, where we view our added cars
          ],
        ),
      ),
    );
  }
}
