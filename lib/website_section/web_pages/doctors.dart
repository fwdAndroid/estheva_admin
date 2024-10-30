import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_admin/utils/colors.dart';
import 'package:estheva_admin/website_section/add_edit/add_doctor_web.dart';
import 'package:estheva_admin/website_section/web_detail/web_doctor_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Doctors extends StatefulWidget {
  const Doctors({super.key});

  @override
  State<Doctors> createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
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
                MaterialPageRoute(builder: (builder) => AddDoctorWeb()));
          }),
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
                    return LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return GridView.builder(
                        scrollDirection:
                            Axis.vertical, // Keep the scroll direction vertical
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: _getCrossAxisCount(
                              context), // Adjust the number of columns based on screen size
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio:
                              1.0, // Adjust child aspect ratio as needed
                        ),
                        itemCount: snap.docs
                            .length, // Replace with your dynamic list length
                        itemBuilder: (context, index) {
                          var doctorData = snap.docs[index].data();
                          return Card(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => WebDoctorDetail(
                                              price: doctorData['price']
                                                  .toString(),
                                              experience:
                                                  doctorData['experience'],
                                              description: doctorData[
                                                  'doctorDescription'],
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
                                  Center(
                                    child: Container(
                                      height: 100,
                                      child: Image.network(
                                        doctorData['photoURL'],
                                        width: 100,
                                        height: 100,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4.0, top: 8, right: 4),
                                      child: Text(
                                        doctorData['doctorName'],
                                        style: GoogleFonts.poppins(
                                            fontSize: 12, color: appColor),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4.0, top: 8, right: 4),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        doctorData['doctorCategory'],
                                        style: GoogleFonts.poppins(
                                            fontSize: 12, color: appColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }

  // Adjust the crossAxisCount based on the screen width
  int _getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 1200) {
      return 6; // 6 columns for large screens
    } else if (screenWidth > 800) {
      return 4; // 4 columns for medium screens
    } else {
      return 2; // 2 columns for small screens
    }
  }
}
