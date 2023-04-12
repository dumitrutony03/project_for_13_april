import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_for_13_april/screens/pages/favorite_cars.dart';
import 'package:project_for_13_april/shared/constants.dart';
import '../../models/car.dart';
import 'car_view_fullscreen.dart';

class CarListView extends StatefulWidget {
  final List<Car> carsFromFirebase;

  const CarListView({Key? key, required this.carsFromFirebase})
      : super(key: key);

  @override
  _CarListViewState createState() => _CarListViewState();
}

class _CarListViewState extends State<CarListView> {
  // bool _isFavourite = false;

  // void _toggleFavouriteButton() {
  //   setState(() {
  //     _isFavourite = !_isFavourite;
  //   });
  // }

  List<Car> favoriteCars = [];
  List<Car> foundCars = [];

  @override
  void initState() {
    /// Saving the cars we have in our database for filtering task.

    foundCars = widget.carsFromFirebase;
    super.initState();
  }

  void runFilter(String enteredKeyword) {
    /// Applying search by KEYWORDS,

    List<Car> results = [];

    if (enteredKeyword.isEmpty)
      results = widget.carsFromFirebase;
    else {
      results = widget.carsFromFirebase
          .where((car) =>
              car.carName!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundCars = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// We have to take care only to show the cars that were only newly added

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    /// Best create it with ListView widget
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        centerTitle: false,
        // back button disabled/enabled
        automaticallyImplyLeading: true,

        actions: <Widget>[
          TextButton.icon(
            icon: Icon(
              IconData(
                0xe1d7,
                fontFamily: 'MaterialIcons',
              ),
              color: Colors.black87,
            ),
            label: Text(
              'See fav cars',
              style: GoogleFonts.manrope(
                letterSpacing: 0.5,
                fontWeight: FontWeight.w700,
                color: Colors.black54,
                fontSize: 17,
              ),
            ),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FavoriteCars(favoriteCars: favoriteCars)),
              );
            },
          ),
        ],

        title: Text(
          'Our added cars',
          style: GoogleFonts.manrope(
            letterSpacing: 1,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
            fontSize: 17,
          ),
        ),
        elevation: 5.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            TextField(
              onChanged: (value) => runFilter(value),
              decoration: textInputDecoration.copyWith(
                  labelText: 'Search by name',
                  suffixIcon: Icon(Icons.search),
                  hintText: 'Ex: Toyota'),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              /// Advantages instead of using ListView.builder is that, if you have a lot of cars that need to be shown
              /// ListView will create them as we access them from the database, instead,
              /// GridView will create them as we are scrolling down
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: screenWidth,
                  childAspectRatio: 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),

                // CarCollection List
                itemCount: foundCars.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children: [
                        /// ADD BUTTON TO GET USER BACK TO THE input_cars_from_user

                        /// Cars added to favorites, but the favorites button toggles all the favorites button
                        /// Probabil needs to be implemented in a separated statefull widget
                        // Row(
                        //   mainAxisSize: MainAxisSize.min,
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     GestureDetector(
                        //       child: Container(
                        //           child: IconButton(
                        //             padding: EdgeInsets.all(0),
                        //             alignment: Alignment.centerRight,
                        //             icon: (_isFavourite
                        //                 ? (Icon(
                        //               Icons.favorite,
                        //               size: 32,
                        //             ) )
                        //                 : Icon(
                        //               Icons.favorite_outline,
                        //               size: 32,
                        //             )),
                        //             color: Colors.blue,
                        //             onPressed: () {
                        //               _toggleFavouriteButton();
                        //               _isFavourite ? favouriteCars.add(widget.carsFromFirebase[index])
                        //                   : favouriteCars.remove(widget.carsFromFirebase[index]);
                        //             },
                        //           )),
                        //     ),
                        //   ],
                        // ),

                        GestureDetector(
                          // To show the car the user has tapped on
                          onTap: () {
                            Navigator.of(context).push(_createRoute(index));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              height: screenHeight * .30,
                              width: screenWidth * .80,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  filterQuality: FilterQuality.high,
                                  alignment: Alignment.topCenter,
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      '${foundCars[index].carPhoto}'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          ///                       IMPORTANT!!!!
                          /// IF THE USER LOGGS OUT / CLOSES THE APPLICATION,
                          /// HE LOSES ALL HIS FAVORITES CARS, NEED TO SOLVE THIS BUG !!
                          children: [
                            FavoriteButton(
                                // isFavorite: false,
                                valueChanged: (isFavourite) {
                              isFavourite
                                  ? favoriteCars.add(foundCars[index])
                                  : favoriteCars.remove(foundCars[index]);
                            }),
                          ],
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                              top: 32, right: 16, left: 16, bottom: 16),
                          child: Column(
                            children: [
                              Text(
                                  "${(foundCars[index].carName)}  "
                                  "${(foundCars[index].carModel)}  "
                                  "${(foundCars[index].carYear)}  "
                                  "\$${(foundCars[index].carPrice)}  "
                                  "${(foundCars[index].carColor)}",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.manrope(
                                    letterSpacing: 3,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
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
            ),
          ],
        ),
      ),
    );
  }

  /// Transition effect between pages
  Route _createRoute(int index) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          CarViewFullScreen(carFromFirebase: foundCars[index], index: index),
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
