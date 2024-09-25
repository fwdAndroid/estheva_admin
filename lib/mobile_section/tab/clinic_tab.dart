import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_admin/mobile_section/details/offer_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:estheva_admin/mobile_section/details/product_detail.dart';
import 'package:estheva_admin/mobile_section/services/clinic_add_service.dart';
import 'package:estheva_admin/utils/colors.dart';

class ClinicTab extends StatefulWidget {
  const ClinicTab({super.key});

  @override
  State<ClinicTab> createState() => _ClinicTabState();
}

class _ClinicTabState extends State<ClinicTab> {
  List<Map<String, String>> imgList = []; // To hold image URLs and titles

  @override
  void initState() {
    super.initState();
    fetchImagesFromFirestore();
  }

  // Fetch data from Firestore
  void fetchImagesFromFirestore() async {
    // Replace 'your_collection' with the name of your Firestore collection
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('offers').get();

    List<Map<String, String>> fetchedImages = [];
    snapshot.docs.forEach((doc) {
      // Assuming the Firestore documents have 'imageUrl' and 'title' fields
      fetchedImages.add({
        'offerDetail': doc['offerDetail'],
        'photos': doc['photos'], // Title field
      });
    });

    setState(() {
      imgList = fetchedImages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: colorwhite,
            ),
            backgroundColor: mainBtnColor,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => ClinicAddService()));
            }),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: imgList.isNotEmpty
                      ? CarouselSlider(
                          options: CarouselOptions(
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                            autoPlay: true,
                          ),
                          items: imgList.map((item) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => OfferDetail(
                                              offerDetail: item['offerDetail'],
                                              uuid: item['uuid'],
                                              photos: item['photos'],
                                            )));
                              },
                              child: Container(
                                margin: EdgeInsets.all(5.0),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  child: Stack(
                                    children: <Widget>[
                                      // Display the image
                                      Image.network(item['photos']!,
                                          fit: BoxFit.cover, width: 1000.0),
                                      // Display the gradient overlay
                                      Positioned(
                                        bottom: 0.0,
                                        left: 0.0,
                                        right: 0.0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color.fromARGB(200, 0, 0, 0),
                                                Color.fromARGB(0, 0, 0, 0)
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 20.0),
                                          // Display the title from Firestore
                                          child: Text(
                                            item[
                                                'offerDetail']!, // Title of the item
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        )
                      : Center(
                          child:
                              CircularProgressIndicator()), // Loading indicator while fetching data
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Body Contouring Packages',
                  style: GoogleFonts.poppins(
                      color: appColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: SizedBox(
                  height: 165,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder<Object>(
                      stream: FirebaseFirestore.instance
                          .collection("services")
                          .where("serviceCategory",
                              isEqualTo: "Body Contouring Packages")
                          .where("type", isEqualTo: "clinic")
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data == null) {
                          return Center(child: Text('No Service available'));
                        }
                        var snap = snapshot.data;
                        return ListView.builder(
                            itemCount: snap.docs.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var serviceData = snap.docs[index].data();
                              return SizedBox(
                                width: 200,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => ProductDetail(
                                                  description: serviceData[
                                                      'serviceDescription'],
                                                  discount:
                                                      serviceData['discount']
                                                          .toString(),
                                                  photoURL:
                                                      serviceData['photoURL'],
                                                  uuid: serviceData['uuid'],
                                                  price: serviceData['price']
                                                      .toString(),
                                                  serviceCategory: serviceData[
                                                      'serviceCategory'],
                                                  serviceName: serviceData[
                                                      'serviceName'],
                                                  serviceSubCategory:
                                                      serviceData[
                                                          'serviceSubCategory'],
                                                )));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          child: Image.network(
                                            height: 80,
                                            width: 90,
                                            fit: BoxFit.cover,
                                            serviceData['photoURL'],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 8, right: 8),
                                        child: Text(
                                          serviceData['serviceSubcategory'],
                                          style: TextStyle(
                                              color: appColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffD3D3D3),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              serviceData['price'].toString() +
                                                  "AED",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: mainBtnColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'IV Drips Therapy',
                  style: GoogleFonts.poppins(
                      color: appColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: SizedBox(
                  height: 165,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder<Object>(
                      stream: FirebaseFirestore.instance
                          .collection("services")
                          .where("serviceCategory",
                              isEqualTo: "IV Drips Therapy")
                          .where("type", isEqualTo: "clinic")
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data == null) {
                          return Center(child: Text('No Service available'));
                        }
                        var snap = snapshot.data;
                        return ListView.builder(
                            itemCount: snap.docs.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var serviceData = snap.docs[index].data();
                              return SizedBox(
                                width: 200,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => ProductDetail(
                                                  description: serviceData[
                                                      'serviceDescription'],
                                                  discount:
                                                      serviceData['discount']
                                                          .toString(),
                                                  photoURL:
                                                      serviceData['photoURL'],
                                                  uuid: serviceData['uuid'],
                                                  price: serviceData['price']
                                                      .toString(),
                                                  serviceCategory: serviceData[
                                                      'serviceCategory'],
                                                  serviceName: serviceData[
                                                      'serviceName'],
                                                  serviceSubCategory:
                                                      serviceData[
                                                          'serviceSubCategory'],
                                                )));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          child: Image.network(
                                            height: 80,
                                            width: 90,
                                            fit: BoxFit.cover,
                                            serviceData['photoURL'],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 8, right: 8),
                                        child: Text(
                                          serviceData['serviceSubcategory'],
                                          style: TextStyle(
                                              color: appColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffD3D3D3),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              serviceData['price'].toString() +
                                                  "AED",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: mainBtnColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'IV Drips Therapy Packages',
                  style: GoogleFonts.poppins(
                      color: appColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: SizedBox(
                  height: 165,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder<Object>(
                      stream: FirebaseFirestore.instance
                          .collection("services")
                          .where("serviceCategory",
                              isEqualTo: "IV Drips Therapy Packages")
                          .where("type", isEqualTo: "clinic")
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data == null) {
                          return Center(child: Text('No Service available'));
                        }
                        var snap = snapshot.data;
                        return ListView.builder(
                            itemCount: snap.docs.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var serviceData = snap.docs[index].data();
                              return SizedBox(
                                width: 200,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => ProductDetail(
                                                  description: serviceData[
                                                      'serviceDescription'],
                                                  discount:
                                                      serviceData['discount']
                                                          .toString(),
                                                  photoURL:
                                                      serviceData['photoURL'],
                                                  uuid: serviceData['uuid'],
                                                  price: serviceData['price']
                                                      .toString(),
                                                  serviceCategory: serviceData[
                                                      'serviceCategory'],
                                                  serviceName: serviceData[
                                                      'serviceName'],
                                                  serviceSubCategory:
                                                      serviceData[
                                                          'serviceSubCategory'],
                                                )));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          child: Image.network(
                                            height: 80,
                                            width: 90,
                                            fit: BoxFit.cover,
                                            serviceData['photoURL'],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 8, right: 8),
                                        child: Text(
                                          serviceData['serviceSubcategory'],
                                          style: TextStyle(
                                              color: appColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffD3D3D3),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              serviceData['price'].toString() +
                                                  "AED",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: mainBtnColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Health Checkup',
                  style: GoogleFonts.poppins(
                      color: appColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: SizedBox(
                  height: 165,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder<Object>(
                      stream: FirebaseFirestore.instance
                          .collection("services")
                          .where("serviceCategory", isEqualTo: "Health Checkup")
                          .where("type", isEqualTo: "clinic")
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data == null) {
                          return Center(child: Text('No Service available'));
                        }
                        var snap = snapshot.data;
                        return ListView.builder(
                            itemCount: snap.docs.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var serviceData = snap.docs[index].data();
                              return SizedBox(
                                width: 200,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => ProductDetail(
                                                  description: serviceData[
                                                      'serviceDescription'],
                                                  discount:
                                                      serviceData['discount']
                                                          .toString(),
                                                  photoURL:
                                                      serviceData['photoURL'],
                                                  uuid: serviceData['uuid'],
                                                  price: serviceData['price']
                                                      .toString(),
                                                  serviceCategory: serviceData[
                                                      'serviceCategory'],
                                                  serviceName: serviceData[
                                                      'serviceName'],
                                                  serviceSubCategory:
                                                      serviceData[
                                                          'serviceSubCategory'],
                                                )));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          child: Image.network(
                                            height: 80,
                                            width: 90,
                                            fit: BoxFit.cover,
                                            serviceData['photoURL'],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 8, right: 8),
                                        child: Text(
                                          serviceData['serviceSubcategory'],
                                          style: TextStyle(
                                              color: appColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffD3D3D3),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              serviceData['price'].toString() +
                                                  "AED",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: mainBtnColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Physiotherapy',
                  style: GoogleFonts.poppins(
                      color: appColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: SizedBox(
                  height: 165,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder<Object>(
                      stream: FirebaseFirestore.instance
                          .collection("services")
                          .where("serviceCategory", isEqualTo: "Physiotherapy")
                          .where("type", isEqualTo: "clinic")
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data == null) {
                          return Center(child: Text('No Service available'));
                        }
                        var snap = snapshot.data;
                        return ListView.builder(
                            itemCount: snap.docs.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var serviceData = snap.docs[index].data();
                              return SizedBox(
                                width: 200,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => ProductDetail(
                                                  description: serviceData[
                                                      'serviceDescription'],
                                                  discount:
                                                      serviceData['discount']
                                                          .toString(),
                                                  photoURL:
                                                      serviceData['photoURL'],
                                                  uuid: serviceData['uuid'],
                                                  price: serviceData['price']
                                                      .toString(),
                                                  serviceCategory: serviceData[
                                                      'serviceCategory'],
                                                  serviceName: serviceData[
                                                      'serviceName'],
                                                  serviceSubCategory:
                                                      serviceData[
                                                          'serviceSubCategory'],
                                                )));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          child: Image.network(
                                            height: 80,
                                            width: 90,
                                            fit: BoxFit.cover,
                                            serviceData['photoURL'],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 8, right: 8),
                                        child: Text(
                                          serviceData['serviceSubcategory'],
                                          style: TextStyle(
                                              color: appColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffD3D3D3),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              serviceData['price'].toString() +
                                                  "AED",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: mainBtnColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Aesthetic',
                  style: GoogleFonts.poppins(
                      color: appColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: SizedBox(
                  height: 165,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder<Object>(
                      stream: FirebaseFirestore.instance
                          .collection("services")
                          .where("serviceCategory", isEqualTo: "Aesthetic")
                          .where("type", isEqualTo: "clinic")
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data == null) {
                          return Center(child: Text('No Service available'));
                        }
                        var snap = snapshot.data;
                        return ListView.builder(
                            itemCount: snap.docs.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var serviceData = snap.docs[index].data();
                              return SizedBox(
                                width: 200,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => ProductDetail(
                                                  description: serviceData[
                                                      'serviceDescription'],
                                                  discount:
                                                      serviceData['discount']
                                                          .toString(),
                                                  photoURL:
                                                      serviceData['photoURL'],
                                                  uuid: serviceData['uuid'],
                                                  price: serviceData['price']
                                                      .toString(),
                                                  serviceCategory: serviceData[
                                                      'serviceCategory'],
                                                  serviceName: serviceData[
                                                      'serviceName'],
                                                  serviceSubCategory:
                                                      serviceData[
                                                          'serviceSubCategory'],
                                                )));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          child: Image.network(
                                            height: 80,
                                            width: 90,
                                            fit: BoxFit.cover,
                                            serviceData['photoURL'],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 8, right: 8),
                                        child: Text(
                                          serviceData['serviceSubcategory'],
                                          style: TextStyle(
                                              color: appColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffD3D3D3),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              serviceData['price'].toString() +
                                                  "AED",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: mainBtnColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Hair Transplant',
                  style: GoogleFonts.poppins(
                      color: appColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 8),
                child: SizedBox(
                  height: 165,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder<Object>(
                      stream: FirebaseFirestore.instance
                          .collection("services")
                          .where("serviceCategory",
                              isEqualTo: "Hair Transplant")
                          .where("type", isEqualTo: "clinic")
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data == null) {
                          return Center(child: Text('No Service available'));
                        }
                        var snap = snapshot.data;
                        return ListView.builder(
                            itemCount: snap.docs.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var serviceData = snap.docs[index].data();
                              return SizedBox(
                                width: 200,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => ProductDetail(
                                                  description: serviceData[
                                                      'serviceDescription'],
                                                  discount:
                                                      serviceData['discount']
                                                          .toString(),
                                                  photoURL:
                                                      serviceData['photoURL'],
                                                  uuid: serviceData['uuid'],
                                                  price: serviceData['price']
                                                      .toString(),
                                                  serviceCategory: serviceData[
                                                      'serviceCategory'],
                                                  serviceName: serviceData[
                                                      'serviceName'],
                                                  serviceSubCategory:
                                                      serviceData[
                                                          'serviceSubCategory'],
                                                )));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          child: Image.network(
                                            height: 80,
                                            width: 90,
                                            fit: BoxFit.cover,
                                            serviceData['photoURL'],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 8, right: 8),
                                        child: Text(
                                          serviceData['serviceSubcategory'],
                                          style: TextStyle(
                                              color: appColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffD3D3D3),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              serviceData['price'].toString() +
                                                  "AED",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: mainBtnColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }),
                ),
              ),
            ],
          ),
        ));
  }
}
