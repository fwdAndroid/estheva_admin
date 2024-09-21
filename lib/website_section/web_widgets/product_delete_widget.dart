import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_admin/website_section/web_home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:estheva_admin/utils/colors.dart';

class ProductDeleteWidget extends StatefulWidget {
  final uuid;
  const ProductDeleteWidget({super.key, required this.uuid});

  @override
  State<ProductDeleteWidget> createState() => _ProductDeleteWidgetState();
}

class _ProductDeleteWidgetState extends State<ProductDeleteWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.delete,
                color: cancelColor,
              )),
          SingleChildScrollView(
            child: ListBody(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Delete Service",
                      style: GoogleFonts.workSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Are you sure you want to delete this service",
                      style: GoogleFonts.workSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        const SizedBox(
          height: 10,
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel")),
        ElevatedButton(
          onPressed: () async {
            await FirebaseFirestore.instance
                .collection("services")
                .doc(widget.uuid)
                .delete();
            Navigator.push(
                context, MaterialPageRoute(builder: (builder) => WebHome()));
          },
          child: Text(
            "Submit",
            style: TextStyle(color: colorwhite),
          ),
          style: ElevatedButton.styleFrom(
              fixedSize: Size(137, 50),
              backgroundColor: mainBtnColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )),
        ),
      ],
    );
  }
}
