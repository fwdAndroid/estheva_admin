import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:estheva_admin/mobile_section/main/pages/appointment_page.dart';
import 'package:estheva_admin/mobile_section/main/pages/doctor_page.dart';
import 'package:estheva_admin/mobile_section/main/pages/history_page.dart';
import 'package:estheva_admin/mobile_section/main/pages/home_page.dart';
import 'package:estheva_admin/utils/colors.dart';

class MainDashboard extends StatefulWidget {
  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    MainHomeMobile(),
    DoctorPage(),
    AppointmentPage(),
    HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final shouldPop = await _showExitDialog(context);
          return shouldPop ?? false;
        },
        child: Scaffold(
          body: _screens[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedLabelStyle: TextStyle(color: mainBtnColor),
            unselectedLabelStyle: TextStyle(color: textColor),
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: _currentIndex == 0
                    ? Image.asset(
                        "assets/home_blue.png",
                        height: 18,
                        width: 20,
                      )
                    : Image.asset(
                        "assets/home_grey.png",
                        height: 18,
                        width: 20,
                      ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _currentIndex == 1
                    ? Image.asset(
                        "assets/doctor_blue.png",
                        height: 18,
                        width: 20,
                      )
                    : Image.asset(
                        "assets/doctor_grey.png",
                        height: 18,
                        width: 20,
                      ),
                label: 'Doctor',
                backgroundColor: colorwhite,
              ),
              BottomNavigationBarItem(
                icon: _currentIndex == 2
                    ? Image.asset(
                        "assets/calender_blue.png",
                        height: 18,
                        width: 20,
                      )
                    : Image.asset(
                        "assets/calender_grey.png",
                        height: 18,
                        width: 20,
                      ),
                label: 'Appointment',
                backgroundColor: colorwhite,
              ),
              BottomNavigationBarItem(
                icon: _currentIndex == 3
                    ? Image.asset(
                        "assets/history_blue.png",
                        height: 18,
                        width: 20,
                      )
                    : Image.asset(
                        "assets/history_medic.png",
                        height: 18,
                        width: 20,
                      ),
                label: 'History',
                backgroundColor: colorwhite,
              ),
            ],
          ),
        ));
  }

  _showExitDialog(BuildContext context) {
    Future<bool?> _showExitDialog(BuildContext context) {
      return showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Exit App'),
          content: Text('Do you want to exit the app?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Yes'),
            ),
          ],
        ),
      );
    }
  }
}
