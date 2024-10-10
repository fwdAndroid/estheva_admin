import 'package:estheva_admin/website_section/web_pages/appointment_web/doctor_appointment_web/cancelled_doctor_appointment.dart';
import 'package:estheva_admin/website_section/web_pages/appointment_web/doctor_appointment_web/upcomming_doctor_appointment.dart';
import 'package:flutter/material.dart';

class DoctorAppointmentWeb extends StatefulWidget {
  const DoctorAppointmentWeb({super.key});

  @override
  State<DoctorAppointmentWeb> createState() => _DoctorAppointmentWebState();
}

class _DoctorAppointmentWebState extends State<DoctorAppointmentWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            "assets/logo.png",
            height: 200,
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                                  UpcommingDoctorAppointment()));
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
                            child: Text("Upcoming Appointment"),
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
                              builder: (builder) =>
                                  CancelDoctorAppointmentWeb()));
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
                            child: Text("Cancel Appointment"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
