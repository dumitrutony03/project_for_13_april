import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/car.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference carCollection =
      FirebaseFirestore.instance.collection('CarsCollection');

  Future<void> updateCarData(String carName, String carModel, String carColor,
      int carPrice, String carPhoto) async {
    return await carCollection.doc(uid).set({
      'carName': carName,
      'carModel': carModel,
      'carColor': carColor,
      'carPrice': carPrice,
      'carPhoto': carPhoto,
    });
  }

  // access our last added Entity from Firebase
  List<Car> _carListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return Car(
        carName: doc.get('carName') ?? 'No Name Specified',
        carModel: doc.get('carModel') ?? 'No Model Specified',
        carYear: doc.get('carYear') ?? 'No Year Specified',
        carColor: doc.get('carColor') ?? 'No Color Specified',
        carPrice: doc.get('carPrice') ?? 0,
        carPhoto: doc.get('carPhoto') ?? 'No Photo Specified',
      );
    }).toList();
  }

  // get cars stream
  Stream<List<Car>> get cars {
    return carCollection.snapshots().map(_carListFromSnapshot);
  }
}
