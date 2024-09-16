import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_admin/mobile_section/doctor/add_doctor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:estheva_admin/mobile_section/main/main_dashboard.dart';
import 'package:estheva_admin/utils/buttons.dart';
import 'package:estheva_admin/utils/colors.dart';
import 'package:estheva_admin/utils/image_utils.dart';
import 'package:estheva_admin/widgets/text_form_field.dart';

class EditServices extends StatefulWidget {
  final String uuid;
  const EditServices({super.key, required this.uuid});

  @override
  State<EditServices> createState() => _EditServicesState();
}

class _EditServicesState extends State<EditServices> {
  TextEditingController serviceDescription = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController discount = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    // Fetch data from Firestore
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('services')
        .doc(widget.uuid)
        .get();

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Update the controllers with the fetched data
    setState(() {
      serviceDescription.text = data['serviceDescription'] ?? '';
      price.text = (data['price'] ?? 0).toString(); // Convert int to string
      discount.text =
          (data['discount'] ?? 0).toString(); // Convert int to string
      imageUrl = data['photoURL'];
    });
  }

  Future<void> selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
  }

  Future<String> uploadImageToStorage(Uint8List image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('services')
        .child('${FirebaseAuth.instance.currentUser!.uid}.jpg');
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: colorwhite,
              )),
          title: Text(
            "Edit Service",
            style: GoogleFonts.workSans(
                color: colorwhite, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: mainBtnColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => selectImage(),
                  child: _image != null
                      ? CircleAvatar(
                          radius: 59, backgroundImage: MemoryImage(_image!))
                      : imageUrl != null
                          ? CircleAvatar(
                              radius: 59,
                              backgroundImage: NetworkImage(imageUrl!))
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/Choose Image.png"),
                            ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormInputField(
                    controller: serviceDescription,
                    hintText: "Description",
                    IconSuffix: Icons.text_decrease,
                    textInputType: TextInputType.text),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: TextFormInputField(
                    controller: price,
                    hintText: "Price",
                    IconSuffix: Icons.price_change,
                    textInputType: TextInputType.number),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: TextFormInputField(
                    controller: discount,
                    hintText: "Discount",
                    IconSuffix: Icons.discount,
                    textInputType: TextInputType.number),
              ),
              Center(
                child: _isLoading
                    ? CircularProgressIndicator(
                        color: mainBtnColor,
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SaveButton(
                            color: mainBtnColor,
                            title: "Confirm",
                            onTap: () async {
                              setState(() {
                                _isLoading = true;
                              });

                              String? downloadUrl;
                              if (_image != null) {
                                downloadUrl =
                                    await uploadImageToStorage(_image!);
                              } else {
                                downloadUrl = imageUrl;
                              }

                              try {
                                await FirebaseFirestore.instance
                                    .collection("services")
                                    .doc(widget.uuid) // Use widget.uuid here
                                    .update({
                                  "serviceDescription": serviceDescription.text,
                                  "price": int.parse(
                                      price.text), // Convert string to int
                                  "discount": int.parse(
                                      discount.text), // Convert string to int
                                  "photoURL": downloadUrl
                                });
                                showMessageBar(
                                    "Medical Services Updated Successfully ",
                                    context);
                              } catch (e) {
                                // Handle errors here
                                print("Error updating service: $e");
                                showMessageBar(
                                    "Failed to update service", context);
                              } finally {
                                setState(() {
                                  _isLoading = false;
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => MainDashboard()));
                              }
                            }),
                      ),
              ),
            ],
          ),
        ));
  }
}
