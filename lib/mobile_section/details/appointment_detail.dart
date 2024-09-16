import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:estheva_admin/utils/colors.dart';

class AppointmentDetail extends StatefulWidget {
  const AppointmentDetail({
    super.key,
  });

  @override
  State<AppointmentDetail> createState() => _AppointmentDetailState();
}

class _AppointmentDetailState extends State<AppointmentDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Appointment History",
          style: GoogleFonts.poppins(fontSize: 18, color: appColor),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              width: 360,
              decoration: BoxDecoration(
                color: circle,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: dividerColor,
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/doctor.png",
                        height: 90,
                        width: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Fawad Kaleem",
                            style: GoogleFonts.poppins(
                                color: appColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          Row(
                            children: [
                              Text(
                                "24/12/2023", // Display the formatted date
                                style: GoogleFonts.poppins(
                                  color: textColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "5:pm",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text("")
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
                color: colorwhite,
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
                            "24/12/2023", // Display the formatted date
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
                            "5:pm",
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
                color: colorwhite,
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
                            "Fawad Kaleem",
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
                            "Male",
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
                            "Patient Problem:     ", // Display the formatted date
                            style: GoogleFonts.poppins(
                              color: appColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "Cough",
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
            child: Image.asset("assets/gen.png"),
          )
        ],
      ),
    );
  }
}
