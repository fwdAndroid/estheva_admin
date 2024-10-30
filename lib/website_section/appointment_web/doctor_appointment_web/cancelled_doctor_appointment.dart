import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_admin/utils/colors.dart';
import 'package:estheva_admin/website_section/appointment_web/doctor_appointment_web/doctor_web_appointment_details/cancel_doctor_web_appointment_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CancelDoctorAppointmentWeb extends StatefulWidget {
  const CancelDoctorAppointmentWeb({super.key});

  @override
  State<CancelDoctorAppointmentWeb> createState() =>
      _CancelDoctorAppointmentWebState();
}

class _CancelDoctorAppointmentWebState
    extends State<CancelDoctorAppointmentWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<Object>(
          stream: FirebaseFirestore.instance
              .collection("doctor_appointment")
              .where("status", isEqualTo: "cancel")
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('No Doctor Appointment Available Yet'));
            }
            var snap = snapshot.data;
            return ListView.builder(
                itemCount: snap.docs.length,
                itemBuilder: (context, index) {
                  var serviceData = snap.docs[index].data();
                  return Card(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      trailing: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) =>
                                        CancelDoctorWebAppointmentDetail(
                                          status: serviceData['status'],
                                          appointmentDate:
                                              serviceData['appointmentDate'],
                                          paitientDate:
                                              serviceData['paitientDate'],
                                          appointmentEndTime:
                                              serviceData['appointmentEndTime'],
                                          appointmentId:
                                              serviceData['appointmentId'],
                                          appointmentStartTime: serviceData[
                                              'appointmentStartTime'],
                                          doctorId: serviceData['doctorId'],
                                          doctorName: serviceData['doctorName'],
                                          file: serviceData['file'],
                                          gender: serviceData['gender'],
                                          paitientName:
                                              serviceData['paitientName'],
                                          paitientProblem:
                                              serviceData['paitientProblem'],
                                          paitientUid:
                                              serviceData['paitientUid'],
                                          price:
                                              serviceData['price'].toString(),
                                        )));
                          },
                          child: Text("View")),
                      title: Row(
                        children: [
                          Text(
                            "Doctor Name:",
                            style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: appColor,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            serviceData['doctorName'],
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: appColor,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Date:",
                                style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: appColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                serviceData['appointmentDate'],
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: appColor,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Time:",
                                style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: appColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                serviceData['appointmentStartTime'],
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: appColor,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ));
                });
          }),
    );
  }
}
