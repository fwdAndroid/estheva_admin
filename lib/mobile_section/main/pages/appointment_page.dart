import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:estheva_admin/mobile_section/tabs/cancelled.dart';
import 'package:estheva_admin/mobile_section/tabs/completed.dart';
import 'package:estheva_admin/mobile_section/tabs/upcomming.dart';
import 'package:estheva_admin/utils/colors.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            "Appointments",
            style: GoogleFonts.poppins(color: appColor),
          ),
          bottom: TabBar(
            indicatorColor: mainBtnColor,
            labelColor: mainBtnColor,
            labelStyle: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
            unselectedLabelColor: textColor,
            unselectedLabelStyle: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
            tabs: <Widget>[
              Tab(
                text: "Upcoming",
              ),
              Tab(
                text: "Cancelled",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[Upcoming(), Cancelled()],
        ),
      ),
    );
  }
}
