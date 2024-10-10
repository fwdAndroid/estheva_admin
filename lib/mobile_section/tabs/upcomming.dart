import 'package:estheva_admin/mobile_section/tabs/appointments/service_appointment_upcoming.dart';
import 'package:estheva_admin/mobile_section/tabs/appointments/upcomming_doctor_appointment.dart';
import 'package:estheva_admin/website_section/web_pages/appointment_web/doctor_appointment_web/upcomming_doctor_appointment.dart';
import 'package:flutter/material.dart';

class Upcoming extends StatefulWidget {
  Upcoming({
    super.key,
  });

  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: 250,
            height: 250,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) =>
                            UpcommingDoctorAppointmentMobile()));
              },
              child: Card(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/doctor.png",
                      height: 170,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Doctor Appointment"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: 250,
            height: 250,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => ServiceAppointmentUpcoming()));
              },
              child: Card(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/logo.png",
                      height: 170,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Service Appointment"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
