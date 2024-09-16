import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  String uuid;
  String serviceName;
  String photoURL;
  int price;
  int discount;
  String serviceSubcategory;
  String serviceCategory;
  String serviceDescription;
  String type;

  ServiceModel({
    required this.uuid,
    required this.serviceName,
    required this.serviceCategory,
    required this.serviceSubcategory,
    required this.price,
    required this.type,
    required this.serviceDescription,
    required this.discount,
    required this.photoURL,
  });

  ///Converting Object into Json Object
  Map<String, dynamic> toJson() => {
        'photoURL': photoURL,
        'type': type,
        'uuid': uuid,
        'serviceSubcategory': serviceSubcategory,
        'discount': discount,
        'serviceDescription': serviceDescription,
        'serviceCategory': serviceCategory,
        'serviceName': serviceName,
        'price': price,
      };

  ///
  static ServiceModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return ServiceModel(
      photoURL: snapshot['photoURL'],
      type: snapshot['type'],
      serviceSubcategory: snapshot['serviceSubcategory'],
      discount: snapshot['discount'],
      uuid: snapshot['uuid'],
      serviceDescription: snapshot['serviceDescription'],
      serviceCategory: snapshot['serviceCategory'],
      serviceName: snapshot['serviceName'],
      price: snapshot['price'],
    );
  }
}
