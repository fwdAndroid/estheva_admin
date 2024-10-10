import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_admin/utils/buttons.dart';
import 'package:estheva_admin/utils/colors.dart';
import 'package:estheva_admin/website_section/web_home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../doctor/add_doctor.dart';

class ServueAppointmentUpcommingMobile extends StatefulWidget {
  final appointmentDate;
  final appointmentEndTime;
  final appointmentId;
  final appointmentStartTime;
  final doctorName;
  final patientContact;
  final patientName;
  final patientUid;
  final price;
  final serviceCategory;
  final serviceDescription;
  final serviceName;
  final status;
  final gender;

  const ServueAppointmentUpcommingMobile({
    super.key,
    required this.appointmentDate,
    required this.appointmentEndTime,
    required this.appointmentId,
    required this.appointmentStartTime,
    required this.doctorName,
    required this.patientContact,
    required this.patientName,
    required this.patientUid,
    required this.price,
    required this.serviceCategory,
    required this.gender,
    required this.serviceDescription,
    required this.serviceName,
    required this.status,
  });

  @override
  State<ServueAppointmentUpcommingMobile> createState() =>
      _ServueAppointmentUpcommingMobileState();
}

class _ServueAppointmentUpcommingMobileState
    extends State<ServueAppointmentUpcommingMobile> {
  String? selectedDoctor;
  List<String> doctorNames = [];

  @override
  void initState() {
    super.initState();
    fetchDoctorNames();
  }

  Future<void> fetchDoctorNames() async {
    // Fetch the data from Firestore
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('doctors').get();

    // Extract doctor names
    final List<String> names =
        querySnapshot.docs.map((doc) => doc['doctorName'] as String).toList();

    setState(() {
      doctorNames = names;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Appointment Schedule
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                width: 360,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Appointment Schedule",
                          style: GoogleFonts.poppins(
                              color: appColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, left: 8),
                        child: Row(
                          children: [
                            Text(
                              "Date:     ", // Display the formatted date
                              style: GoogleFonts.poppins(
                                color: appColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              widget
                                  .appointmentDate, // Display the formatted date
                              style: GoogleFonts.poppins(
                                color: textColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, left: 8),
                        child: Row(
                          children: [
                            Text(
                              "Time:     ", // Display the formatted date
                              style: GoogleFonts.poppins(
                                color: appColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              widget.appointmentStartTime,
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                width: 360,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Patient Details",
                          style: GoogleFonts.poppins(
                              color: appColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, left: 8),
                        child: Row(
                          children: [
                            Text(
                              "Name:     ", // Display the formatted date
                              style: GoogleFonts.poppins(
                                color: appColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              widget.patientName,
                              style: GoogleFonts.poppins(
                                color: dateColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, left: 8),
                        child: Row(
                          children: [
                            Text(
                              "Gender:     ", // Display the formatted date
                              style: GoogleFonts.poppins(
                                color: appColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              widget.gender,
                              style: GoogleFonts.poppins(
                                color: dateColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 700,
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 8),
                child: Column(
                  children: [
                    Text(
                      "Service Description:     ", // Display the formatted date
                      style: GoogleFonts.poppins(
                          color: appColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      widget.serviceDescription,
                      style: GoogleFonts.poppins(
                        color: dateColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: doctorNames.isEmpty
                    ? CircularProgressIndicator() // Show a loading indicator if data is still being fetched
                    : DropdownButton<String>(
                        isExpanded: true,
                        hint: Text('Select Doctor'),
                        value: selectedDoctor,
                        onChanged: (newValue) {
                          setState(() {
                            selectedDoctor = newValue;
                          });
                        },
                        items: doctorNames.map((doctor) {
                          return DropdownMenuItem(
                            value: doctor,
                            child: Text(doctor),
                          );
                        }).toList(),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SaveButton(
                  title: "Change Doctor",
                  onTap: () async {
                    await FirebaseFirestore.instance
                        .collection("appointment")
                        .doc(widget.appointmentId)
                        .update({"doctorName": selectedDoctor});
                    showMessageBar(
                        "Doctor of Current Appointment is Changed", context);
                    Navigator.pop(context);
                  },
                  color: mainBtnColor),
            )
          ],
        ),
      ),
    );
  }
}
