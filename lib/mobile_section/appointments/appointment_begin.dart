import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:estheva_admin/mobile_section/appointments/appoinment_request.dart';
import 'package:estheva_admin/utils/buttons.dart';
import 'package:estheva_admin/utils/colors.dart';
import 'package:estheva_admin/utils/image_utils.dart';
import 'package:estheva_admin/widgets/text_form_field.dart';

class AppointmentBegin extends StatefulWidget {
  AppointmentBegin({
    super.key,
  });

  @override
  State<AppointmentBegin> createState() => _AppointmentBeginState();
}

class _AppointmentBeginState extends State<AppointmentBegin> {
  String currentTime = '';
  String currentDate = '';

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  void _updateTime() {
    final now = DateTime.now();
    final timeFormat = DateFormat('hh:mm a');
    final dateFormat = DateFormat('EEEE, d MMM, yyyy');

    setState(() {
      currentTime = timeFormat.format(now); // Format for time
      currentDate = dateFormat.format(now); // Format for date
    });
  }

  String _selectedGender = 'Male'; // Variable to track the selected gender
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    TextEditingController _paitnetNameController = TextEditingController();
    TextEditingController _dateController = TextEditingController();
    TextEditingController _aboutController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Make Appointment",
          style: GoogleFonts.poppins(fontSize: 17, color: appColor),
        ),
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      Image.asset(
                        "assets/doctor.png",
                        height: 90,
                        width: 90,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Dr Farhan Ali",
                              style: GoogleFonts.poppins(
                                  color: appColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "7 Years",
                              style: GoogleFonts.poppins(
                                color: dateColor,
                                fontSize: 12,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  currentDate, // Display the formatted date
                                  style: GoogleFonts.poppins(
                                    color: textColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  currentTime,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  Icons.star,
                                  color: index < 5
                                      ? Colors.yellow[600]
                                      : Colors.grey[400], // Colored stars
                                );
                              }),
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
              padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Patient Name",
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  TextFormInputField(
                    controller: _paitnetNameController,
                    hintText: "Patient Name",
                    textInputType: TextInputType.name,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Date of Birth",
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  TextFormInputField(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        lastDate: DateTime(3000),
                        firstDate: DateTime(2015),
                        initialDate: DateTime.now(),
                      );
                      if (pickedDate == null) return;
                      _dateController.text =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                    },
                    preFixICon: Icons.date_range,
                    controller: _dateController,
                    hintText: "Date of Birth",
                    textInputType: TextInputType.name,
                  ),
                ],
              ),
            ),
            // Radio Buttons in a Row
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Gender",
                style: GoogleFonts.poppins(
                    color: appColor, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: 'Male',
                  groupValue: _selectedGender,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                ),
                Text(
                  'Male',
                  style: GoogleFonts.poppins(fontSize: 14, color: textColor),
                ),
                Radio<String>(
                  value: 'Female',
                  groupValue: _selectedGender,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                ),
                Text(
                  'Female',
                  style: GoogleFonts.poppins(fontSize: 14, color: textColor),
                ),
                Radio<String>(
                  value: 'Other',
                  groupValue: _selectedGender,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                ),
                Text(
                  'Other',
                  style: GoogleFonts.poppins(fontSize: 14, color: textColor),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Write Your Problem",
                style: GoogleFonts.poppins(
                    color: appColor, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: _aboutController,
                keyboardType: TextInputType.text,
                style: GoogleFonts.plusJakartaSans(color: black),
                maxLines: 3,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor)),
                    hintText: "About Me ",
                    hintStyle: GoogleFonts.plusJakartaSans(
                        color: black, fontSize: 12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Upload Document",
                style: GoogleFonts.poppins(
                    color: appColor, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => selectImage(),
                child: Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 59, backgroundImage: MemoryImage(_image!))
                        : GestureDetector(
                            onTap: () => selectImage(),
                            child: Image.asset('assets/image.png')),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SaveButton(
                  color: mainBtnColor,
                  title: "Next",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => AppoinmentRequest()));
                  }),
            )
          ],
        ),
      ),
    );
  }

  selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
  }
}
