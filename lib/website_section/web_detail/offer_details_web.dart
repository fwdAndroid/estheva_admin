import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_admin/utils/colors.dart';
import 'package:estheva_admin/website_section/web_add_services/add_doctor_web.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OfferDetailsWeb extends StatefulWidget {
  final photo;
  final name;
  final uuid;
  const OfferDetailsWeb(
      {super.key, required this.photo, required this.name, required this.uuid});

  @override
  State<OfferDetailsWeb> createState() => _OfferDetailsWebState();
}

class _OfferDetailsWebState extends State<OfferDetailsWeb> {
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
                  uuid: widget.uuid,
                  photo: widget.photo,
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

  final name;
  final uuid;

  const FormSection(
      {Key? key, required this.photo, required this.name, required this.uuid})
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection("offers")
                      .doc(widget.uuid)
                      .delete();
                  Navigator.pop(context);
                  showMessageBar("Deleted Offer", context);
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
