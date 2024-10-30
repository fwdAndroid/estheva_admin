import 'package:estheva_admin/mobile_section/doctor/edit_doctor.dart';
import 'package:estheva_admin/widgets/delete_doctor_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:estheva_admin/utils/colors.dart';

class DoctorDetail extends StatefulWidget {
  final experience;
  final name;
  final photo;
  final description;
  final uuid;
  final price;
  DoctorDetail(
      {super.key,
      required this.description,
      required this.experience,
      required this.name,
      required this.photo,
      required this.price,
      required this.uuid});

  @override
  State<DoctorDetail> createState() => _DoctorDetailState();
}

class _DoctorDetailState extends State<DoctorDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBtnColor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorwhite,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    size: 20,
                    Icons.arrow_back_ios_new,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        iconTheme: IconThemeData(color: colorwhite),
        backgroundColor: mainBtnColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(widget.photo),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                color: colorwhite,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.41,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, right: 8, top: 17),
                      child: Text(
                        widget.name,
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: appColor),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: circle,
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    size: 20,
                                    Icons.badge,
                                    color: textColor,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              widget.experience,
                              style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: appColor),
                            ),
                            Text(
                              "Experience",
                              style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: textColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "About Doctor",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: appColor),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, right: 8, top: 5),
                      child: Text(
                        widget.description,
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: dateColor),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 80,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Consultation fee",
                                  style: GoogleFonts.poppins(
                                    color: dateColor,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "AED",
                                      style: GoogleFonts.poppins(
                                          color: appColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      widget.price,
                                      style: GoogleFonts.poppins(
                                          color: appColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "/Consultation fee",
                                      style: GoogleFonts.poppins(
                                        color: dateColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DeleteDoctorWidget(uuid: widget.uuid);
                            },
                          );
                        },
                        child: Text(
                          "Delete",
                          style: TextStyle(color: colorwhite),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: cancelColor,
                            fixedSize: Size(150, 60)),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => EditDoctor(
                                        uuid: widget.uuid,
                                      )));
                        },
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(color: colorwhite),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: g, fixedSize: Size(150, 60)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
