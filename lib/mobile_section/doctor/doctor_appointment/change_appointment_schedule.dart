import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_admin/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChangeAppointmentSchedule extends StatefulWidget {
  final String doctorName;
  final String appointmentTime;
  final String appointmentDate;
  final String serviceName;
  final String status;
  final String appointmentId;

  ChangeAppointmentSchedule({
    super.key,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.doctorName,
    required this.appointmentId,
    required this.status,
    required this.serviceName,
  });

  @override
  State<ChangeAppointmentSchedule> createState() =>
      _ChangeAppointmentScheduleState();
}

class _ChangeAppointmentScheduleState extends State<ChangeAppointmentSchedule> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  String? selectedDoctor;
  String? selectedStatus;
  List<String> doctorNames = [];
  List<String> statusOptions = ['Pending', 'Confirmed', 'Cancelled'];

  @override
  void initState() {
    super.initState();
    dateController.text = widget.appointmentDate;
    timeController.text = widget.appointmentTime;
    selectedDoctor = widget.doctorName;
    selectedStatus = widget.status; // Initialize with current status
    fetchDoctorNames();
  }

  Future<void> fetchDoctorNames() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('doctors').get();
    setState(() {
      doctorNames =
          querySnapshot.docs.map((doc) => doc['doctorName'] as String).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorwhite),
        backgroundColor: mainBtnColor,
        centerTitle: true,
        title: Text(
          "Change Schedules",
          style: TextStyle(color: colorwhite),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: selectedDoctor,
              decoration: InputDecoration(labelText: 'Select Doctor'),
              items: doctorNames.map((name) {
                return DropdownMenuItem(
                  value: name,
                  child: Text(name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDoctor = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: dateController,
              readOnly: true,
              decoration: InputDecoration(labelText: 'Select Date'),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.parse(widget.appointmentDate),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  setState(() {
                    dateController.text =
                        DateFormat('dd MMM yyyy').format(pickedDate);
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: timeController,
              readOnly: true,
              decoration: InputDecoration(labelText: 'Select Time'),
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay(
                    hour: int.parse(widget.appointmentTime.split(':')[0]),
                    minute: int.parse(widget.appointmentTime.split(':')[1]),
                  ),
                );
                if (pickedTime != null) {
                  setState(() {
                    timeController.text = pickedTime.format(context);
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _updateAppointment(),
              child: Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateAppointment() async {
    // Update the appointment document with the new date, time, doctor, and status information
    await FirebaseFirestore.instance
        .collection('appointment')
        .doc(widget.appointmentId)
        .update({
      'appointmentDate': dateController.text,
      'appointmentStartTime': timeController.text,
      'doctorName': selectedDoctor,
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Appointment updated successfully")),
    );
    Navigator.pop(context);
  }
}
