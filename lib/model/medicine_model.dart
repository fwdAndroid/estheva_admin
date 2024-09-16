import 'package:cloud_firestore/cloud_firestore.dart';

class MedicModel {
  String uuid;
  String medicineName;
  String photoURL;
  int price;
  String category;

  MedicModel({
    required this.uuid,
    required this.medicineName,
    required this.category,
    required this.price,
    required this.photoURL,
  });

  ///Converting Object into Json Object
  Map<String, dynamic> toJson() => {
        'photoURL': photoURL,
        'uuid': uuid,
        'category': category,
        'medicineName': medicineName,
        'price': price,
      };

  ///
  static MedicModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return MedicModel(
      photoURL: snapshot['photoURL'],
      uuid: snapshot['uuid'],
      category: snapshot['category'],
      medicineName: snapshot['medicineName'],
      price: snapshot['price'],
    );
  }
}
