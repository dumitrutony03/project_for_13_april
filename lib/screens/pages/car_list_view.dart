import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/car.dart';
import 'car_view_fullscreen.dart';
import 'input_cars_from_user.dart';

class CarListView extends StatefulWidget {
  final List<Car> carsFromFirebase;

  const CarListView({Key? key, required this.carsFromFirebase})
      : super(key: key);

  @override
  _CarListViewState createState() => _CarListViewState();
}

class _CarListViewState extends State<CarListView> {
  @override
  Widget build(BuildContext context) {
    // widget.carsFromFirebase.clear();
    /// We have to take care only to show the cars that were only newly added
    if (widget.carsFromFirebase != null)
      widget.carsFromFirebase.forEach((car) {
        print(car.carName);
        print(car.carModel);
        print(car.carYear);
        print(car.carPrice);
        print(car.carPhoto);
      });

    print('CATE MASINI AVEM: ${widget.carsFromFirebase.length}');

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    /// Best create it with ListView widget
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        // back button disabled
        title: Text('Our added cars'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,

        /*actions: <Widget>[
          TextButton.icon(
              icon: Icon(
                Icons.keyboard_backspace_outlined,
                color: Colors.black87,
              ),
              label: const Text(''),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InputCarsFromUser()),
                );
                //widget.toggleView(),
              }),
        ],*/

      ),
      body: ListView.builder(
        // CarCollection List
        itemCount: widget.carsFromFirebase.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              children: [
                /// ADD BUTTON TO GET USER BACK TO THE input_cars_from_user
                // GestureDetector(
                //
                // ),

                GestureDetector(
                  // To show the car the user has tapped on
                  onTap: () {
                    Navigator.of(context).push(_createRoute(index));
                  },
                  /*onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CarViewFullScreen(carFromFirebase: widget.carsFromFirebase[index], index: index)),
                    );
                  },*/

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
                              '${widget.carsFromFirebase[index].carPhoto}'),
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
                          "${(widget.carsFromFirebase[index].carName)}   "
                          "${(widget.carsFromFirebase[index].carModel)}   "
                          "${(widget.carsFromFirebase[index].carYear)}   "
                          "\$${(widget.carsFromFirebase[index].carPrice)}   "
                          "${(widget.carsFromFirebase[index].carColor)}",
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

  /// Transition effect between pages
  Route _createRoute(int index) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          CarViewFullScreen(
              carFromFirebase: widget.carsFromFirebase[index], index: index),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

/// STATELESSWIDGET
/*
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
    // carsFromFirebase.clear();

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    /// Best create it with ListView widget
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        // back button disabled
        title: Text('Our added cars'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,

         actions: <Widget>[
          TextButton.icon(
              icon: Icon(
                Icons.keyboard_backspace_outlined,
                color: Colors.black87,
              ),
              label: const Text(''),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          InputCarsFromUser()),
                );
                //widget.toggleView(),
              }),
        ],
      ),
      body: ListView.builder(
        // CarCollection List
        itemCount: carsFromFirebase.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              children: [
                /// ADD BUTTON TO GET USER BACK TO THE input_cars_from_user

                GestureDetector(
                  // To show the car the user has tapped on
                   onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CarViewFullScreen(
                            carFromFirebase: carsFromFirebase[index], index: index)),
                  ),

                  // onTap: {Navigator.of(context).push(_createRoute())},

                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      height: screenHeight * .30,
                      width: screenWidth * .80,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          alignment: Alignment.topCenter,
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              '${carsFromFirebase[index].carPhoto}'),
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
                          "${(carsFromFirebase[index].carName)}   "
                          "${(carsFromFirebase[index].carModel)}   "
                          "${(carsFromFirebase[index].carYear)}   "
                          "\$${(carsFromFirebase[index].carPrice)}   "
                          "${(carsFromFirebase[index].carColor)}",
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
}*/
