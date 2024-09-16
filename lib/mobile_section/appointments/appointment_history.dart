import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:estheva_admin/mobile_section/appointments/appoint_record.dart';
import 'package:estheva_admin/utils/colors.dart';

class AppointmentHistory extends StatefulWidget {
  const AppointmentHistory({super.key});

  @override
  State<AppointmentHistory> createState() => _AppointmentHistoryState();
}

class _AppointmentHistoryState extends State<AppointmentHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorwhite,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "Records",
            style: GoogleFonts.poppins(fontSize: 18, color: appColor),
          ),
        ),
        body: ListView.builder(itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => RecordsHistory()));
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 140,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/doctor.png",
                                height: 90,
                                width: 90,
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Doctor Name",
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        color: appColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "+82312412414424",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: appColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "25/3/2333",
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
                                        "2:pm",
                                        style: GoogleFonts.poppins(
                                            color: dateColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
