import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_for_13_april/screens/pages/car_view_fullscreen.dart';

import '../../models/car.dart';

class FavoriteCars extends StatefulWidget {
  final List<Car> favoriteCars;

  const FavoriteCars({Key? key, required this.favoriteCars}) : super(key: key);

  @override
  State<FavoriteCars> createState() => _FavoriteCarsState();
}

class _FavoriteCarsState extends State<FavoriteCars> {
  @override
  Widget build(BuildContext context) {

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    if (widget.favoriteCars != null)
      widget.favoriteCars.forEach((car) {
        print(car.carName);
        print(car.carModel);
        print(car.carYear);
        print(car.carPrice);
        print(car.carPhoto);
      });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // back button disabled/enabled
        automaticallyImplyLeading: true,

        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('Back to cars'),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
        ],

        title: Text('Our fav cars'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
      ),
      body: ListView.builder(
        // CarCollection List
        itemCount: widget.favoriteCars.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              children: [
                /// ADD BUTTON TO GET USER BACK TO THE input_cars_from_user

                /// !!!!!!!!!!!!!!!!!!!!! WE HAVE TO STORE IN FIREBASE FAVORITE CARS FOR EVERY USER TO ACCESS THEM ANYTIME
                /// And probably, the problem won't persist, but the FAVOURITE BUTTON will remain
                /// Set to FALSE everytime we exit CARLISTVIEW Page.

                /// Cars added to favorites, but the favorites button toggles all the favorites button
                /// Probabil needs to be implemented in a separated statefull widget
                GestureDetector(
                  // To show the car the user has tapped on
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CarViewFullScreen(
                            carFromFirebase: widget.favoriteCars[index], index: index,
                          )),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      height: screenHeight * .30,
                      width: screenWidth * .80,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          filterQuality: FilterQuality.high,
                          alignment: Alignment.topCenter,
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              '${widget.favoriteCars[index].carPhoto}'),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding:
                  EdgeInsets.only(top: 32, right: 16, left: 16, bottom: 16),
                  child: Column(
                    children: [
                      Text(
                          "${(widget.favoriteCars[index].carName)}   "
                              "${(widget.favoriteCars[index].carModel)}   "
                              "${(widget.favoriteCars[index].carYear)}   "
                              "\$${(widget.favoriteCars[index].carPrice)}   "
                              "${(widget.favoriteCars[index].carColor)}",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.manrope(
                            letterSpacing: 3,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                            fontSize: 14,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
