import 'package:estheva_admin/mobile_section/auth/signup_screen.dart';
import 'package:estheva_admin/mobile_section/doctor/doctor_appointment/doctor_appointment_list.dart';
import 'package:estheva_admin/mobile_section/setting/change_password.dart';
import 'package:estheva_admin/mobile_section/setting/notification_screen.dart';
import 'package:estheva_admin/mobile_section/setting/support.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:estheva_admin/utils/buttons.dart';
import 'package:estheva_admin/utils/colors.dart';
import 'package:estheva_admin/widgets/logout_widget.dart';

import '../../offers/create_offers.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool get isGoogleSignIn =>
      _auth.currentUser?.providerData[0].providerId == 'google.com';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Hi Admin",
                      style: GoogleFonts.workSans(
                          fontWeight: FontWeight.w600, fontSize: 22),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                    color: colorwhite,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12))),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => MobileSignupScreen()));
                      },
                      leading: Icon(
                        Icons.post_add,
                        color: appColor,
                      ),
                      title: Text(
                        "Admin Accounts",
                        style: GoogleFonts.workSans(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: appColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(
                        color: borderColor,
                      ),
                    ),
                    if (!isGoogleSignIn)
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => ChangePassword()));
                        },
                        leading: Icon(
                          Icons.language_outlined,
                          color: appColor,
                        ),
                        title: Text(
                          "Change Password",
                          style: GoogleFonts.workSans(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: appColor,
                        ),
                      ),
                    if (!isGoogleSignIn)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Divider(
                          color: borderColor,
                        ),
                      ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => NotificationScreen()));
                      },
                      leading: Icon(
                        Icons.notifications,
                        color: appColor,
                      ),
                      title: Text(
                        "Notifications",
                        style: GoogleFonts.workSans(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: appColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(
                        color: borderColor,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => DoctorAppointmentList()));
                      },
                      leading: Icon(
                        Icons.app_blocking,
                        color: appColor,
                      ),
                      title: Text(
                        "Doctor Appointments",
                        style: GoogleFonts.workSans(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: appColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(
                        color: borderColor,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: mainBtnColor,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "About App",
                          style: GoogleFonts.workSans(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff5496FB)),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) => Support()));
                      },
                      leading: Icon(
                        Icons.help,
                        color: appColor,
                      ),
                      title: Text(
                        "Help & Support",
                        style: GoogleFonts.workSans(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: appColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(
                        color: borderColor,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => CreateOffers()));
                      },
                      leading: Icon(
                        Icons.offline_bolt,
                        color: appColor,
                      ),
                      title: Text(
                        "Create Offers",
                        style: GoogleFonts.workSans(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: appColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Divider(
                        color: borderColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SaveButton(
                    color: mainBtnColor,
                    title: "Logout",
                    onTap: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return LogoutWidget();
                        },
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
