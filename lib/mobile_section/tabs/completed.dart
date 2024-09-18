import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:estheva_admin/utils/colors.dart';

class Completed extends StatefulWidget {
  const Completed({
    super.key,
  });

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("doctor_appointment")
              .where("status", isEqualTo: "complete")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  "No Appointment Available",
                  style: TextStyle(color: black),
                ),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  final Map<String, dynamic> data =
                      documents[index].data() as Map<String, dynamic>;

                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (builder) =>
                          //             UpcomingAppointmentDetail(
                          //                 appointmentEndTime:
                          //                     data['appointmentEndTime'],
                          //                 appointmentDate:
                          //                     data['appointmentDate'],
                          //                 appointmentId: data['appointmentId'],
                          //                 price: data['price'].toString(),
                          //                 appointmentStartTime:
                          //                     data['appointmentStartTime'],
                          //                 doctorName: data['doctorName'],
                          //                 doctorid: data['doctorid'],
                          //                 paitientName: data['paitientName'],
                          //                 paitientDate: data['paitientDate'],
                          //                 file: data['file'],
                          //                 gender: data['gender'],
                          //                 paitientUid: data['paitientUid'],
                          //                 paitientProblem:
                          //                     data['paitientProblem'],
                          //                 status: data["status"])));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            trailing: Container(
                              width: 80,
                              height: 24,
                              decoration: BoxDecoration(
                                  border: Border.all(color: completeColor),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                child: Text(
                                  "Completed",
                                  style: GoogleFonts.poppins(
                                      fontSize: 12, color: completeColor),
                                ),
                              ),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  data['appointmentDate'],
                                  style: GoogleFonts.poppins(
                                      color: dateColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "|",
                                  style: GoogleFonts.poppins(
                                      color: dateColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  data['appointmentStartTime'],
                                  style: GoogleFonts.poppins(
                                      color: dateColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                )
                              ],
                            ),
                            title: Text(
                              data['paitientName'],
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: appColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          // Column(
                          //   children: [
                          //     Row(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Column(
                          //           crossAxisAlignment:
                          //               CrossAxisAlignment.start,
                          //           children: [
                          //             Row(
                          //               children: [

                          //                 const SizedBox(
                          //                   width: 3,
                          //                 ),

                          //             Text(
                          //               "+82312412414424",
                          //               style: GoogleFonts.poppins(
                          //                   fontSize: 14,
                          //                   color: appColor,
                          //                   fontWeight: FontWeight.w400),
                          //             ),
                          //             const SizedBox(
                          //               height: 30,
                          //             ),

                          //       ],
                          //     )
                          //   ],
                          // ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(
                          color: dividerColor,
                        ),
                      )
                    ],
                  );
                });
          }),
    );
  }
}
