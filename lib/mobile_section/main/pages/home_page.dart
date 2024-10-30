import 'package:flutter/material.dart';
import 'package:estheva_admin/mobile_section/services_tab/clinic_tab.dart';
import 'package:estheva_admin/mobile_section/services_tab/home_care_tab.dart';
import 'package:estheva_admin/utils/colors.dart';

class MainHomeMobile extends StatefulWidget {
  const MainHomeMobile({super.key});

  @override
  State<MainHomeMobile> createState() => _MainHomeMobileState();
}

class _MainHomeMobileState extends State<MainHomeMobile> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: mainBtnColor,
          automaticallyImplyLeading: false,
          title: Text(
            'Home Page',
            style: TextStyle(color: colorwhite),
          ),
          bottom: TabBar(
            unselectedLabelColor: black,
            labelColor: colorwhite,
            tabs: [
              Tab(icon: Icon(Icons.home_max), text: "Home Services"),
              Tab(
                  icon: Icon(Icons.cloud_circle_rounded),
                  text: "Clincic Services")
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomeCareTab(),
            ClinicTab(),
          ],
        ),
      ),
    );
  }
}
