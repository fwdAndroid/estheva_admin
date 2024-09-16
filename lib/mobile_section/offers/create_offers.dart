import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:estheva_admin/mobile_section/main/main_dashboard.dart';
import 'package:estheva_admin/utils/buttons.dart';
import 'package:estheva_admin/utils/colors.dart';
import 'package:estheva_admin/utils/image_utils.dart';

class CreateOffers extends StatefulWidget {
  const CreateOffers({super.key});

  @override
  State<CreateOffers> createState() => _CreateOffersState();
}

class _CreateOffersState extends State<CreateOffers> {
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController experienceController = TextEditingController();

  Uint8List? _image;
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: colorwhite),
          backgroundColor: mainBtnColor,
          title: Text(
            "Offers",
            style: TextStyle(color: colorwhite),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => selectImage(),
                child: _image != null
                    ? CircleAvatar(
                        radius: 59, backgroundImage: MemoryImage(_image!))
                    : GestureDetector(
                        onTap: () => selectImage(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/Choose Image.png"),
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: descriptionController,
                  maxLines: 12,
                  decoration: InputDecoration(
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                        borderSide: BorderSide(
                          color: colorwhite,
                        )),
                    contentPadding: EdgeInsets.all(8),
                    fillColor: Color(0xffF6F7F9),
                    hintText: "Offer Detail",
                    hintStyle: GoogleFonts.nunitoSans(fontSize: 16),
                    border: InputBorder.none,
                  ),
                ),
              ),
              isAdded
                  ? Center(child: CircularProgressIndicator())
                  : SaveButton(
                      color: mainBtnColor,
                      title: "Publish",
                      onTap: () async {
                        print("click");
                        if (descriptionController.text.isEmpty) {
                          showMessageBar("Description is Required", context);
                        } else if (_image == null) {
                          showMessageBar("Image is Required", context);
                        } else {
                          setState(() {
                            isAdded = true;
                          });
                          print("asdsa");
                          await FirebaseFirestore.instance
                              .collection("offers")
                              .doc("uid")
                              .set({
                            "offerDetail": descriptionController.text,
                          });
                          setState(() {
                            isAdded = false;
                          });
                          // Handle the result accordingly
                          showMessageBar("Offer Added Successfully", context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => MainDashboard(),
                            ),
                          );
                        }
                      }),
            ],
          ),
        ));
  }

  selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
  }
}

// Functions
/// Select Image From Gallery

void showMessageBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ),
  );
}
