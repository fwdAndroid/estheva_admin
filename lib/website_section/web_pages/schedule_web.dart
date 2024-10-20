import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleWeb extends StatefulWidget {
  const ScheduleWeb({super.key});

  @override
  State<ScheduleWeb> createState() => _ScheduleWebState();
}

class _ScheduleWebState extends State<ScheduleWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Available Doctors')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('doctors').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var doctors = snapshot.data!.docs;

          return ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              var doctor = doctors[index];
              return ListTile(
                title: Text(doctor['doctorName']),
                subtitle: Text('Status: ${doctor['status']}'),
                onTap: () {
                  // Navigate to Doctor's Appointment Calendar Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorCalendarScreen(
                        doctorId: doctor['uuid'],
                        doctorName: doctor['doctorName'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class DoctorCalendarScreen extends StatefulWidget {
  final String doctorId;
  final String doctorName;

  DoctorCalendarScreen({required this.doctorId, required this.doctorName});

  @override
  _DoctorCalendarScreenState createState() => _DoctorCalendarScreenState();
}

class _DoctorCalendarScreenState extends State<DoctorCalendarScreen> {
  Map<DateTime, List<Map<String, dynamic>>> appointments = {};
  DateTime _selectedDay = DateTime.now();
  String doctorStatus = 'Free';
  List<QueryDocumentSnapshot> allDoctors = [];

  @override
  void initState() {
    super.initState();
    fetchAppointments();
    fetchDoctorStatus();
    fetchAllDoctors();
  }

  // Fetch appointments from Firestore
  void fetchAppointments() async {
    FirebaseFirestore.instance
        .collection('appointment')
        .where('doctorName', isEqualTo: widget.doctorName)
        .get()
        .then((QuerySnapshot querySnapshot) {
      Map<DateTime, List<Map<String, dynamic>>> fetchedAppointments = {};
      for (var doc in querySnapshot.docs) {
        // Parse the appointment date properly
        DateTime appointmentDate =
            (doc['appointmentDate'] as Timestamp).toDate();
        String appointmentStartTime = doc['appointmentStartTime'];

        Map<String, dynamic> appointmentData = {
          'appointmentId': doc.id,
          'patientName': doc['patientName'],
          'appointmentStartTime': appointmentStartTime,
        };

        // Round the date to ignore the time portion for comparison
        DateTime roundedDate = DateTime(
            appointmentDate.year, appointmentDate.month, appointmentDate.day);

        if (fetchedAppointments.containsKey(roundedDate)) {
          fetchedAppointments[roundedDate]!.add(appointmentData);
        } else {
          fetchedAppointments[roundedDate] = [appointmentData];
        }
      }
      setState(() {
        appointments = fetchedAppointments;
      });
    });
  }

  // Fetch the doctor's current status from Firestore
  void fetchDoctorStatus() async {
    FirebaseFirestore.instance
        .collection('doctors')
        .doc(widget.doctorId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          doctorStatus =
              documentSnapshot['status']; // Fetch status (booked or active)
        });
      }
    });
  }

  // Fetch all doctors for appointment shifting
  void fetchAllDoctors() async {
    FirebaseFirestore.instance
        .collection('doctors')
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        allDoctors = querySnapshot.docs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor's Appointments"),
        actions: [
          // Dropdown to change doctor status
          DropdownButton<String>(
            value: doctorStatus,
            items: ['Free', 'Booked'].map<DropdownMenuItem<String>>((status) {
              return DropdownMenuItem<String>(
                value: status,
                child: Text(status.toUpperCase()),
              );
            }).toList(),
            onChanged: (String? newStatus) {
              if (newStatus != null) {
                setState(() {
                  doctorStatus = newStatus;
                });
                // Update the doctor's status in Firestore
                FirebaseFirestore.instance
                    .collection('doctors')
                    .doc(widget.doctorId)
                    .update({'status': newStatus});
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Display calendar with appointments
          TableCalendar(
            focusedDay: _selectedDay,
            firstDay: DateTime(2022),
            lastDay: DateTime(2030),
            calendarFormat: CalendarFormat.month,
            eventLoader: (date) {
              DateTime roundedDate = DateTime(date.year, date.month, date.day);
              return appointments[roundedDate] ?? [];
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: _buildAppointmentsList(),
          ),
        ],
      ),
    );
  }

  // Display appointments for the selected day
  Widget _buildAppointmentsList() {
    DateTime roundedSelectedDay =
        DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    List<Map<String, dynamic>> selectedDayAppointments =
        appointments[roundedSelectedDay] ?? [];

    if (selectedDayAppointments.isEmpty) {
      return Center(child: Text('No appointments for this day.'));
    }

    return ListView.builder(
      itemCount: selectedDayAppointments.length,
      itemBuilder: (context, index) {
        var appointment = selectedDayAppointments[index];

        return ListTile(
          title: Text(appointment['patientName']),
          subtitle: Text(
              "Time: ${appointment['appointmentStartTime']}"), // Show the appointment start time
          trailing: IconButton(
            icon: Icon(Icons.swap_horiz),
            onPressed: () {
              _showShiftAppointmentDialog(appointment['appointmentId']);
            },
          ),
        );
      },
    );
  }

  // Dialog to shift an appointment to another doctor
  void _showShiftAppointmentDialog(String appointmentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Shift Appointment'),
          content: DropdownButton<String>(
            items: allDoctors.map((doctor) {
              return DropdownMenuItem<String>(
                value: doctor.id,
                child: Text(doctor['doctorName']),
              );
            }).toList(),
            onChanged: (newDoctorId) {
              if (newDoctorId != null) {
                FirebaseFirestore.instance
                    .collection('appointments')
                    .doc(appointmentId)
                    .update({'doctorId': newDoctorId});

                Navigator.pop(context);
              }
            },
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
