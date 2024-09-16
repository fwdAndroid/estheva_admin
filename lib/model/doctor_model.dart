import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  String uuid;
  String doctorName;
  String photoURL;
  int price;
  String email;
  String pass;
  String experience;
  String doctorCategory;
  String doctorDescription;

  DoctorModel({
    required this.uuid,
    required this.doctorName,
    required this.doctorCategory,
    required this.experience,
    required this.email,
    required this.pass,
    required this.price,
    required this.doctorDescription,
    required this.photoURL,
  });

  ///Converting Object into Json Object
  Map<String, dynamic> toJson() => {
        'photoURL': photoURL,
        'email': email,
        "pass": pass,
        'uuid': uuid,
        'experience': experience,
        'doctorDescription': doctorDescription,
        'doctorCategory': doctorCategory,
        'doctorName': doctorName,
        'price': price,
      };

  ///
  static DoctorModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return DoctorModel(
      pass: snapshot['pass'],
      email: snapshot['email'],
      photoURL: snapshot['photoURL'],
      experience: snapshot['experience'],
      uuid: snapshot['uuid'],
      doctorDescription: snapshot['doctorDescription'],
      doctorCategory: snapshot['doctorCategory'],
      doctorName: snapshot['doctorName'],
      price: snapshot['price'],
    );
  }
}
