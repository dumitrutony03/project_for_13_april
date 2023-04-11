import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

    return load
        ? Loading()
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Car name',
                        style: GoogleFonts.manrope(
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: _myController.carNameController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: textInputDecoration,
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Car model',
                        style: GoogleFonts.manrope(
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: _myController.carModelController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: textInputDecoration,
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Car year',
                        style: GoogleFonts.manrope(
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: _myController.carYearController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: textInputDecoration,
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Car color',
                        style: GoogleFonts.manrope(
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: _myController.carColorController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: textInputDecoration,
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Car price',
                        style: GoogleFonts.manrope(
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: _myController.carPriceController,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        decoration: textInputDecoration,
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Car link from wikipedia',
                        style: GoogleFonts.manrope(
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: _myController.carPhotoController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: textInputDecoration,
                      ),
                    ],
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
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
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
                                /// validate controllers
                                carName = _myController.carNameController.text;
                                carModel =
                                    _myController.carModelController.text;
                                carYear = _myController.carYearController.text;
                                carColor =
                                    _myController.carColorController.text;
                                carPrice = int.tryParse(
                                    _myController.carPriceController.text);
                                carPhoto =
                                    _myController.carPhotoController.text;

                                /// check if the input provided by the user is VALID
                                bool result = FormControllers()
                                    .checkControllers(carName, carModel,
                                        carYear, carColor, carPrice, carPhoto);
                                /*
                  We can add an object into our database, with an UNIQUE ID
                  using this method:
                  -> We create a "car" object, we then add into our
                  collection "CarsCollection" our car in JSON format with
                  an ID automated generated by Firebase Google Cloud.
                   */
                                if (!result) {
                                  print('date introduse gresit');

                                  showSnackBAR('Date introduse gresit', context, Colors.white, Colors.red);

                                } else {
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
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
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
                              MaterialPageRoute(
                                  builder: (context) => CarListView(
                                        carsFromFirebase: cars,
                                      )),
                            );
                            load = false;
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
  void showSnackBAR(String text, BuildContext context, Color bgColor, Color textColor){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style: TextStyle(
            color: textColor,
            fontSize: 15
        ),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: bgColor,
    ));
  }
}
