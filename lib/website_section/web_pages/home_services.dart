import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_admin/utils/colors.dart';
import 'package:estheva_admin/website_section/web_add_services/add_home_services.dart';
import 'package:estheva_admin/website_section/web_detail/web_product_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';

class HomeServices extends StatefulWidget {
  const HomeServices({super.key});

  @override
  State<HomeServices> createState() => _HomeServicesState();
}

class _HomeServicesState extends State<HomeServices> {
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
                  MaterialPageRoute(builder: (builder) => AddHomeServices()));
            }),
        backgroundColor: colorwhite,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          .where("type", isEqualTo: "home")
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
                        return ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(
                            dragDevices: {
                              PointerDeviceKind.touch,
                              PointerDeviceKind.mouse,
                            },
                          ),
                          child: ListView.builder(
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
                                              builder: (builder) =>
                                                  WebProductDetail(
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
                                                    serviceCategory:
                                                        serviceData[
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
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Padding(
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
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 8, right: 8),
                                          child: Text(
                                            serviceData['serviceSubcategory'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: appColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xffD3D3D3),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  serviceData['price']
                                                          .toString() +
                                                      " AED",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: mainBtnColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        );
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
                          .where("type", isEqualTo: "home")
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
                        return ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(
                            dragDevices: {
                              PointerDeviceKind.touch,
                              PointerDeviceKind.mouse,
                            },
                          ),
                          child: ListView.builder(
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
                                              builder: (builder) =>
                                                  WebProductDetail(
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
                                                    serviceCategory:
                                                        serviceData[
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
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Padding(
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
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 8, right: 8),
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            serviceData['serviceSubcategory'],
                                            style: TextStyle(
                                                color: appColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xffD3D3D3),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  serviceData['price']
                                                          .toString() +
                                                      " AED",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: mainBtnColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        );
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
                          .where("type", isEqualTo: "home")
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
                        return ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(
                            dragDevices: {
                              PointerDeviceKind.touch,
                              PointerDeviceKind.mouse,
                            },
                          ),
                          child: ListView.builder(
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
                                              builder: (builder) =>
                                                  WebProductDetail(
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
                                                    serviceCategory:
                                                        serviceData[
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
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Padding(
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
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 8, right: 8),
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            serviceData['serviceSubcategory'],
                                            style: TextStyle(
                                                color: appColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xffD3D3D3),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  serviceData['price']
                                                          .toString() +
                                                      " AED",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: mainBtnColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        );
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
                          .where("type", isEqualTo: "home")
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
                        return ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(
                            dragDevices: {
                              PointerDeviceKind.touch,
                              PointerDeviceKind.mouse,
                            },
                          ),
                          child: ListView.builder(
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
                                              builder: (builder) =>
                                                  WebProductDetail(
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
                                                    serviceCategory:
                                                        serviceData[
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
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Padding(
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
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 8, right: 8),
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            serviceData['serviceSubcategory'],
                                            style: TextStyle(
                                                color: appColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xffD3D3D3),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  serviceData['price']
                                                          .toString() +
                                                      " AED",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: mainBtnColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        );
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
                          .where("type", isEqualTo: "home")
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
                        return ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(
                            dragDevices: {
                              PointerDeviceKind.touch,
                              PointerDeviceKind.mouse,
                            },
                          ),
                          child: ListView.builder(
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
                                              builder: (builder) =>
                                                  WebProductDetail(
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
                                                    serviceCategory:
                                                        serviceData[
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
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Padding(
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
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 8, right: 8),
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            serviceData['serviceSubcategory'],
                                            style: TextStyle(
                                                color: appColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xffD3D3D3),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  serviceData['price']
                                                          .toString() +
                                                      " AED",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: mainBtnColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        );
                      }),
                ),
              ),
            ],
          ),
        ));
  }
}
