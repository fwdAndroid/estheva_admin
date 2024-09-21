import 'package:estheva_admin/utils/colors.dart';
import 'package:estheva_admin/website_section/web_add_services/edit_service_web.dart';
import 'package:estheva_admin/widgets/delete_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WebProductDetail extends StatefulWidget {
  final discount;
  final photoURL;
  final price;
  final serviceCategory;
  final serviceSubCategory;
  final serviceName;
  final description;
  final uuid;
  const WebProductDetail(
      {super.key,
      required this.description,
      required this.discount,
      required this.photoURL,
      required this.price,
      required this.serviceCategory,
      required this.serviceName,
      required this.serviceSubCategory,
      required this.uuid});

  @override
  State<WebProductDetail> createState() => _WebProductDetailState();
}

class _WebProductDetailState extends State<WebProductDetail> {
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
                  uuid: widget.uuid,
                  serviceCategory: widget.serviceCategory,
                  description: widget.description,
                  discount: widget.discount.toString(),
                  photoURL: widget.photoURL,
                  price: widget.price.toString(),
                  serviceName: widget.serviceName,
                  serviceSubCategory: widget.serviceSubCategory,
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
  final discount;
  final photoURL;
  final price;
  final serviceCategory;
  final serviceSubCategory;
  final serviceName;
  final description;
  final uuid;

  const FormSection(
      {Key? key,
      required this.description,
      required this.discount,
      required this.photoURL,
      required this.price,
      required this.serviceCategory,
      required this.serviceName,
      required this.serviceSubCategory,
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
            widget.photoURL,
            height: 200,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.serviceName,
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
                        widget.discount.toString() + "%",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        widget.price.toString() + "AED",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black54,
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
                      return DeleteAlertWidget(uuid: widget.uuid);
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
                          builder: (builder) => EditServiceWeb(
                                uuid: widget.uuid,
                              )));
                },
                child: Text(
                  "Edit Profile",
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
