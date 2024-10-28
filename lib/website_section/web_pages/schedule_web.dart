import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_admin/mobile_section/doctor_appointment/change_appointment_schedule.dart';
import 'package:estheva_admin/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleWeb extends StatefulWidget {
  const ScheduleWeb({super.key});

  @override
  State<ScheduleWeb> createState() => _ScheduleWebState();
}

class _ScheduleWebState extends State<ScheduleWeb> {
  String? selectedDoctorUUID;
  String? selectedDoctorStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: colorwhite),
          backgroundColor: mainBtnColor,
          centerTitle: true,
          title: Text(
            "Doctors Schedules",
            style: TextStyle(color: colorwhite),
          )),
      body: Column(
        children: [
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("doctors")
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data == null) {
                    return Center(child: Text('No data available'));
                  }
                  var snap = snapshot.data;
                  return ListView.builder(
                    scrollDirection:
                        Axis.horizontal, // Keep the scroll direction vertical

                    itemCount: snap
                        .docs.length, // Replace with your dynamic list length
                    itemBuilder: (context, index) {
                      var doctorData = snap.docs[index].data();
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDoctorUUID = doctorData['doctorName'];
                            selectedDoctorStatus = doctorData['status'];
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content vertically
                          crossAxisAlignment: CrossAxisAlignment
                              .center, // Center the content horizontally
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  NetworkImage(doctorData['photoURL']),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 4.0, top: 8, right: 4),
                              child: Text(
                                doctorData['doctorName'],
                                style: GoogleFonts.poppins(
                                    fontSize: 12, color: appColor),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
          ),
          const Divider(),
          if (selectedDoctorUUID != null)
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('appointment')
                    .where('doctorName', isEqualTo: selectedDoctorUUID)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
                    return Center(child: Text('No appointments available'));
                  }

                  var appointments = snapshot.data.docs;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 150,
                      columns: const [
                        DataColumn(label: Text('Date')),
                        DataColumn(label: Text('Service')),
                        DataColumn(label: Text('Time')),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('Actions')),
                      ],
                      rows: appointments.map<DataRow>((doc) {
                        return DataRow(cells: [
                          DataCell(
                            Text(
                              DateFormat('d MMM yyyy').format(
                                DateTime.parse(doc['appointmentDate']),
                              ),
                            ),
                          ),
                          DataCell(Text(doc['serviceCategory'])),
                          DataCell(Text(doc['appointmentStartTime'])),
                          DataCell(Text(selectedDoctorStatus ?? 'Unknown')),
                          DataCell(
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) =>
                                            ChangeAppointmentSchedule(
                                              serviceName:
                                                  doc['serviceCategory'],
                                              appointmentTime:
                                                  doc['appointmentStartTime'],
                                              appointmentDate:
                                                  doc['appointmentDate'],
                                              doctorName: selectedDoctorUUID!,
                                              appointmentId:
                                                  doc['appointmentId'],
                                              status: selectedDoctorStatus ??
                                                  'Unknown',
                                            )));
                              },
                              child: Text("Change"),
                            ),
                          ),
                        ]);
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
