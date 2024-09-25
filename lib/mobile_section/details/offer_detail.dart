import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_admin/mobile_section/doctor/add_doctor.dart';
import 'package:estheva_admin/utils/buttons.dart';
import 'package:estheva_admin/utils/colors.dart';
import 'package:flutter/material.dart';

class OfferDetail extends StatefulWidget {
  final uuid;
  final offerDetail;
  final photos;
  const OfferDetail(
      {super.key,
      required this.offerDetail,
      required this.photos,
      required this.uuid});

  @override
  State<OfferDetail> createState() => _OfferDetailState();
}

class _OfferDetailState extends State<OfferDetail> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorwhite),
        backgroundColor: mainBtnColor,
        centerTitle: true,
        title: Text(
          "Offers Detail",
          style: TextStyle(color: colorwhite),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(widget.photos),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 400,
              height: 100,
              child: Text(
                widget.offerDetail,
                style: TextStyle(color: black),
              ),
            ),
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SaveButton(
                  title: "Delete Offer",
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await FirebaseFirestore.instance
                        .collection("offers")
                        .doc(widget.uuid)
                        .delete();
                    setState(() {
                      isLoading = false;
                    });
                    showMessageBar("Offer is Deleted", context);
                    Navigator.pop(context);
                  },
                  color: mainBtnColor)
        ],
      ),
    );
  }
}
