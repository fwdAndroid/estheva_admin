import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:estheva_admin/mobile_section/appointments/appointment_request_done.dart';
import 'package:estheva_admin/utils/buttons.dart';
import 'package:estheva_admin/utils/colors.dart';
import 'package:estheva_admin/widgets/text_form_field.dart';

class AppoinmentRequest extends StatefulWidget {
  AppoinmentRequest({
    super.key,
  });

  @override
  State<AppoinmentRequest> createState() => _AppoinmentRequestState();
}

class _AppoinmentRequestState extends State<AppoinmentRequest> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Confirm Appointment",
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
      body: Column(
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
                      "assets/logos.png",
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Patient Name: ",
                                style: GoogleFonts.poppins(
                                    color: appColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Fawad Kaleem",
                                style: GoogleFonts.poppins(
                                    color: appColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Date of Birth: ",
                                style: GoogleFonts.poppins(
                                    color: appColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "23/23/23",
                                style: GoogleFonts.poppins(
                                    color: appColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Text(
                            "Cough",
                            style: GoogleFonts.poppins(
                              color: dateColor,
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
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Appointment Date",
                  style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: appColor),
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
                  hintText: "Appointment Date",
                  textInputType: TextInputType.name,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Appointment Time",
                  style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: appColor),
                ),
                TextFormInputField(
                  onTap: () async {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      builder: (BuildContext context, Widget? child) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: false),
                          child: child!,
                        );
                      },
                    );

                    if (pickedTime != null) {
                      final now = DateTime.now();
                      final selectedTime = DateTime(
                        now.year,
                        now.month,
                        now.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );

                      setState(() {
                        _timeController.text =
                            DateFormat('hh:mm a').format(selectedTime);
                      });
                    }
                  },
                  preFixICon: Icons.time_to_leave,
                  controller: _timeController,
                  hintText: "Appointment Time",
                  textInputType: TextInputType.name,
                ),
              ],
            ),
          ),
          const Spacer(),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: mainBtnColor,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SaveButton(
                    color: mainBtnColor,
                    title: "Confirm Appointment",
                    onTap: () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => AppointmentRequestDone()));
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
