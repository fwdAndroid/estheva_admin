import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:estheva_admin/mobile_section/details/doctor_detail.dart';
import 'package:estheva_admin/mobile_section/doctor/add_doctor.dart';
import 'package:estheva_admin/utils/colors.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({super.key});

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
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
            Navigator.push(
                context, MaterialPageRoute(builder: (builder) => AddDoctor()));
          }),
      appBar: AppBar(
        backgroundColor: mainBtnColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Medical Consultation",
          style: GoogleFonts.poppins(
              fontSize: 18, color: colorwhite, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("doctors")
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data == null) {
                      return Center(child: Text('No data available'));
                    }
                    var snap = snapshot.data;
                    return GridView.builder(
                      scrollDirection:
                          Axis.vertical, // Keep the scroll direction vertical
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns in the grid
                        crossAxisSpacing: 10, // Spacing between columns
                        mainAxisSpacing: 10, // Spacing between rows
                        childAspectRatio:
                            0.8, // Adjust this ratio to fit the design
                      ),
                      itemCount: snap
                          .docs.length, // Replace with your dynamic list length
                      itemBuilder: (context, index) {
                        var doctorData = snap.docs[index].data();
                        return Card(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => DoctorDetail(
                                            price:
                                                doctorData['price'].toString(),
                                            experience:
                                                doctorData['experience'],
                                            description:
                                                doctorData['doctorDescription'],
                                            name: doctorData['doctorName'],
                                            photo: doctorData['photoURL'],
                                            uuid: doctorData['uuid'],
                                          )));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment
                                  .center, // Center the content vertically
                              crossAxisAlignment: CrossAxisAlignment
                                  .center, // Center the content horizontally
                              children: [
                                Container(
                                  height: 100,
                                  child: Image.network(
                                    doctorData['photoURL'],
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, top: 8, right: 4),
                                  child: Text(
                                    doctorData['doctorName'],
                                    style: GoogleFonts.poppins(
                                        fontSize: 12, color: appColor),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, top: 8, right: 4),
                                  child: Text(
                                    doctorData['doctorCategory'],
                                    style: GoogleFonts.poppins(
                                        fontSize: 12, color: appColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
