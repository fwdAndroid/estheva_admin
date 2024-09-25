import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_admin/database/database.dart';
import 'package:estheva_admin/database/storage_methods.dart';
import 'package:estheva_admin/utils/app_colors.dart';
import 'package:estheva_admin/utils/buttons.dart';
import 'package:estheva_admin/utils/colors.dart';
import 'package:estheva_admin/utils/image_utils.dart';
import 'package:estheva_admin/website_section/web_home.dart';
import 'package:estheva_admin/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddWebOffers extends StatefulWidget {
  const AddWebOffers({super.key});

  @override
  State<AddWebOffers> createState() => _AddWebOffersState();
}

class _AddWebOffersState extends State<AddWebOffers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: const [
                _FormSection(),
                _ImageSection(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _FormSection extends StatefulWidget {
  const _FormSection({Key? key}) : super(key: key);

  @override
  State<_FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<_FormSection> {
  var uuid = Uuid().v4();

  TextEditingController descriptionController = TextEditingController();

  Uint8List? _image;
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.neutral,
      width: 500,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                        showMessageBar("Offer Detail is Required", context);
                      } else if (_image == null) {
                        showMessageBar("Image is Required", context);
                      } else {
                        setState(() {
                          isAdded = true;
                        });
                        String photoURL =
                            await StorageMethods().uploadImageToStorage(
                          'offers',
                          _image!,
                        );
                        await FirebaseFirestore.instance
                            .collection("offers")
                            .doc(uuid)
                            .set({
                          "uuid": uuid,
                          "offerDetail": descriptionController.text,
                          "photos": photoURL
                        });
                        setState(() {
                          isAdded = false;
                        });
                        // Handle the result accordingly
                        showMessageBar("Doctor Added Successfully", context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => WebHome(),
                          ),
                        );
                      }
                    }),
          ],
        ),
      ),
    );
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
