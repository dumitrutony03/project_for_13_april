import 'package:flutter/material.dart';
import 'package:project_for_13_april/shared/loading.dart';

import '../../models/car.dart';

class CarListView extends StatelessWidget {
  final List<Car> carsFromFirebase;

  const CarListView({Key? key, required this.carsFromFirebase})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    /// We have to take care only to show the cars that were only newly added
    if (carsFromFirebase != null)
      carsFromFirebase.forEach((car) {
        print(car.carName);
        print(car.carModel);
        print(car.carYear);
        print(car.carPrice);
        print(car.carPhoto);
      });
    carsFromFirebase.clear();

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    /// Best create it with ListView widget
    return Scaffold(
            // Because SingleChildScrollView inherites our main page
            body: SingleChildScrollView(
              // CarCollection List
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    child: GestureDetector(
                      // Change this and make a GestureDetector for it
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: screenHeight * .32,
                        width: screenWidth * .85,
                        margin: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white70),
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            fit: BoxFit.fill,

                            // Car Image
                            image: NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCX3F9BJX2QEAr12a0IrnaSkh8j-8deisljg&usqp=CAU'),
                          ),
                        ),

                        // Icon for Favourite CARS
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, right: 16),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Icon(
                                  Icons.favorite_border,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    /*Container(
                      color: Colors.brown[400],
                      child: TextButton(
                        child: Container(
                          color: Colors.red[400],
                          // Color from our class defined in constants directory
                          height: 50,
                          // nu foarte mare
                          width: 75,
                        ),
                        onPressed: () async {
                          // The page we came from
                          // Going back to InputCarsFromUser
                          Navigator.pop(context);

                          setState(() {
                            load = true;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Container(
                      // Car details
                      // child: Text('${}, ${}, ${}, ${}, ${}'),
                      height: screenHeight * .12,
                      width: screenWidth * .85,
                      decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(75),
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),*/
                  ),
                ],
              ),
            ),
          );
  }
}



/*
class CarListView extends StatefulWidget {
  final List<Car> carsFromFirebase;
  const CarListView({Key? key, required this.carsFromFirebase}) : super(key: key);

  @override
  _CarListViewState createState() =>_CarListViewState();
}

class _CarListViewState extends State<CarListView> {
  final _formKey = GlobalKey<FormState>();

  bool load = false;

  @override
  Widget build(BuildContext context) {
    // CarListView carListView = CarListView();

    if (carListView != null)
      carListView.forEach((car) {
        print(car.carName);
        print(car.carModel);
        print(car.carYear);
        print(car.carPrice);
        print(car.carPhoto);
      });

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return load
        ? Loading()
        : Scaffold(
            // Because SingleChildScrollView inherites our main page
            body: SingleChildScrollView(
              // CarCollection List
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    child: GestureDetector(

                      // Change this and make a GestureDetector for it
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: screenHeight * .32,
                        width: screenWidth * .85,
                        margin: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white70),
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            fit: BoxFit.fill,

                            // Car Image
                            image: NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCX3F9BJX2QEAr12a0IrnaSkh8j-8deisljg&usqp=CAU'),
                          ),
                        ),

                        // Icon for Favourite CARS
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, right: 16),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Icon(
                                  Icons.favorite_border,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    */
/*Container(
                      color: Colors.brown[400],
                      child: TextButton(
                        child: Container(
                          color: Colors.red[400],
                          // Color from our class defined in constants directory
                          height: 50,
                          // nu foarte mare
                          width: 75,
                        ),
                        onPressed: () async {
                          // The page we came from
                          // Going back to InputCarsFromUser
                          Navigator.pop(context);

                          setState(() {
                            load = true;
                          });
                        },
                      ),
                    ),*/ /*

                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Container(
                      // Car details
                      // child: Text('${}, ${}, ${}, ${}, ${}'),
                      height: screenHeight * .12,
                      width: screenWidth * .85,
                      decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(75),
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
*/
