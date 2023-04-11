import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_for_13_april/screens/home/car_list.dart';
import 'package:project_for_13_april/screens/pages/car_list_view.dart';

import '../../models/car.dart';

class CarViewFullScreen extends StatelessWidget {
  final Car carFromFirebase;
  final int index;

  const CarViewFullScreen(
      {Key? key, required this.carFromFirebase, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.brown[400],
          title: Text(
            '${carFromFirebase.carName} ${carFromFirebase.carModel}',
          ),

          actions: <Widget>[
            TextButton.icon(
                icon: Icon(
                  Icons.keyboard_backspace_outlined,
                  color: Colors.black87,
                ),
                label: const Text(''),
                onPressed: () {
                  // Going back to the last page we have visited
                  Navigator.pop(context);

                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CarListView(carsFromFirebase: carFromFirebase)),
                  );*/
                }),
          ],

        ),
        body: Column(
          children: [
            Center(
              child: Container(
                // Car photo

                child: SizedBox(
                  height: 270,
                  width: screenWidth,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        filterQuality: FilterQuality.high,
                        image: NetworkImage(
                            '${carFromFirebase.carPhoto.toString()}'),
                        alignment: Alignment.topCenter,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 16,
            ),

            // Specification of the car
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 32, top: 16),
                  child: Text(
                    "Name:  ${(carFromFirebase.carName)}   \n\n"
                    "Model:  ${(carFromFirebase.carModel)}   \n\n"
                    "Year:  ${(carFromFirebase.carYear)}   \n\n"
                    "Price:  \$${(carFromFirebase.carPrice)}   \n\n"
                    "Color:  ${(carFromFirebase.carColor)}",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.manrope(
                      letterSpacing: 2,
                      fontWeight: FontWeight.w800,
                      color: Colors.black54,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
