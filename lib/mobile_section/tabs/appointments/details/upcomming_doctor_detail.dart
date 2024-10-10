import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_admin/mobile_section/doctor/add_doctor.dart';
import 'package:estheva_admin/utils/buttons.dart';
import 'package:estheva_admin/utils/colors.dart';
import 'package:estheva_admin/website_section/web_home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorAppointmentCompleteDetail extends StatefulWidget {
  final appointmentDate;
  final appointmentEndTime;
  final appointmentId;
  final appointmentStartTime;
  final doctorId;
  final doctorName;
  final file;
  final gender;
  final paitientName;
  final paitientDate;
  final paitientProblem;
  final paitientUid;
  final price;
  final status;
  const DoctorAppointmentCompleteDetail(
      {super.key,
      required this.appointmentDate,
      required this.appointmentEndTime,
      required this.appointmentId,
      required this.appointmentStartTime,
      required this.doctorId,
      required this.doctorName,
      required this.file,
      required this.gender,
      required this.paitientDate,
      required this.paitientName,
      required this.paitientProblem,
      required this.paitientUid,
      required this.price,
      required this.status});

  @override
  State<DoctorAppointmentCompleteDetail> createState() =>
      _DoctorAppointmentCompleteDetailState();
}

class _DoctorAppointmentCompleteDetailState
    extends State<DoctorAppointmentCompleteDetail> {
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
      body: Column(
        children: [
          //Doctor Name
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
                        "Doctor Detail",
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
                            "Doctor Name: ", // Display the formatted date
                            style: GoogleFonts.poppins(
                              color: appColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            widget.doctorName, // Display the formatted date
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
                            "Price:     ", // Display the formatted date
                            style: GoogleFonts.poppins(
                              color: appColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            widget.price.toString(),
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
                            widget.paitientName,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description:     ", // Display the formatted date
                            style: GoogleFonts.poppins(
                              color: appColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            widget.paitientProblem,
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

          SaveButton(
              title: "Change Doctor",
              onTap: () async {
                await FirebaseFirestore.instance
                    .collection("doctor_appointment")
                    .doc(widget.appointmentId)
                    .update({"doctorName": selectedDoctor});
                showMessageBar(
                    "Doctor of Current Appointment is Changed", context);
                Navigator.pop(context);
              },
              color: mainBtnColor)
        ],
      ),
    );
  }
}