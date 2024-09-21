import 'package:estheva_admin/utils/colors.dart';
import 'package:estheva_admin/website_section/web_add_services/edit_doctor_web.dart';
import 'package:estheva_admin/website_section/web_add_services/edit_service_web.dart';
import 'package:estheva_admin/website_section/web_widgets/doctor_web_delete_widget.dart';
import 'package:estheva_admin/widgets/delete_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WebDoctorDetail extends StatefulWidget {
  final photo;
  final price;
  final experience;
  final name;
  final description;
  final uuid;
  const WebDoctorDetail(
      {super.key,
      required this.description,
      required this.photo,
      required this.price,
      required this.experience,
      required this.name,
      required this.uuid});

  @override
  State<WebDoctorDetail> createState() => _WebDoctorDetailState();
}

class _WebDoctorDetailState extends State<WebDoctorDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                FormSection(
                  name: widget.name,
                  experience: widget.experience,
                  uuid: widget.uuid,
                  photo: widget.photo,
                  price: widget.price.toString(),
                  description: widget.description,
                ),
                _ImageSection(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FormSection extends StatefulWidget {
  final photo;
  final price;
  final experience;
  final name;
  final description;
  final uuid;

  const FormSection(
      {Key? key,
      required this.description,
      required this.photo,
      required this.price,
      required this.experience,
      required this.name,
      required this.uuid})
      : super(key: key);

  @override
  State<FormSection> createState() => FormSectionState();
}

class FormSectionState extends State<FormSection> {
  //Program
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            widget.photo,
            height: 200,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.name,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.description,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              color: Colors.yellow.shade100,
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.discount, color: Colors.orange),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.price.toString() + "%",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DoctorDeleteWebWidget(uuid: widget.uuid);
                    },
                  );
                },
                child: Text(
                  "Delete",
                  style: TextStyle(color: colorwhite),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: cancelColor, fixedSize: Size(150, 60)),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => EditDoctorWeb(
                                uuid: widget.uuid,
                              )));
                },
                child: Text(
                  "Edit Doctor",
                  style: TextStyle(color: colorwhite),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: g, fixedSize: Size(150, 60)),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _ImageSection extends StatelessWidget {
  const _ImageSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            "assets/logo.png",
            height: 300,
          ))
        ],
      ),
    );
  }
}
