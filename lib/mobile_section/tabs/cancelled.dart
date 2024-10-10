import 'package:estheva_admin/mobile_section/tabs/appointments/cancel_doctor_appointment.dart';
import 'package:estheva_admin/mobile_section/tabs/appointments/cancel_service_appointment.dart';
import 'package:flutter/material.dart';

class Cancelled extends StatefulWidget {
  const Cancelled({
    super.key,
  });

  @override
  State<Cancelled> createState() => _CancelledState();
}

class _CancelledState extends State<Cancelled> {
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
                        builder: (builder) => CancelDoctorAppointment()));
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
                        builder: (builder) => CancelServiceAppointment()));
              },
              child: Card(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/newlogo.png",
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
