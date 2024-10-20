import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ScheduleWeb extends StatefulWidget {
  const ScheduleWeb({super.key});

  @override
  State<ScheduleWeb> createState() => _ScheduleWebState();
}

class _ScheduleWebState extends State<ScheduleWeb> {
  List<Map<String, dynamic>> doctorAppointments = [];

  @override
  void initState() {
    super.initState();
    fetchDoctorAppointments();
  }

  // Fetch data from Firestore
  Future<void> fetchDoctorAppointments() async {
    // Fetch doctors
    QuerySnapshot doctorSnapshot =
        await FirebaseFirestore.instance.collection('doctors').get();
    List<Map<String, dynamic>> doctors = doctorSnapshot.docs
        .map((doc) => {
              'uuid': doc['uuid'],
              'doctorName': doc['doctorName'],
            })
        .toList();

    // Fetch appointments for each doctor
    for (var doctor in doctors) {
      // Fetch doctor appointments by doctorId
      QuerySnapshot doctorAppointmentsSnapshot = await FirebaseFirestore
          .instance
          .collection('doctor_appointment')
          .where('doctorId', isEqualTo: doctor['doctorId'])
          .get();

      // Fetch service appointments by doctorName
      QuerySnapshot serviceAppointmentsSnapshot = await FirebaseFirestore
          .instance
          .collection('appointment')
          .where('doctorName', isEqualTo: doctor['doctorName'])
          .get();

      // Combine appointments from both collections
      List<Map<String, dynamic>> appointments = doctorAppointmentsSnapshot.docs
          .map((appointment) => {
                'appointmentDate': appointment['appointmentDate'].toDate(),
              })
          .toList();

      appointments.addAll(serviceAppointmentsSnapshot.docs
          .map((appointment) => {
                'appointmentDate': appointment['appointmentDate'].toDate(),
              })
          .toList());

      // Store combined data
      doctorAppointments.add({
        'doctorName': doctor['doctorName'],
      });
    }

    setState(() {}); // Update UI after fetching data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Doctor Appointments')),
      body: doctorAppointments.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Doctor Name')),
                  DataColumn(label: Text('Appointment Dates')),
                ],
                rows: doctorAppointments
                    .map(
                      (doctor) => DataRow(
                        cells: [
                          DataCell(Text(doctor['doctorName'])),
                          DataCell(
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: doctor['appointments']
                                  .map<Widget>(
                                    (appointment) => Text(
                                        appointment['appointmentDate']
                                            .toString()),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }
}
