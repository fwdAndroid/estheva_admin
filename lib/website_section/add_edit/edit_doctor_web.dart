import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_admin/utils/buttons.dart';
import 'package:estheva_admin/utils/colors.dart';
import 'package:estheva_admin/utils/image_utils.dart';
import 'package:estheva_admin/website_section/add_edit/add_home_services.dart';
import 'package:estheva_admin/website_section/web_home.dart';
import 'package:estheva_admin/widgets/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditDoctorWeb extends StatefulWidget {
  String uuid;
  EditDoctorWeb({super.key, required this.uuid});

  @override
  State<EditDoctorWeb> createState() => _EditDoctorWebState();
}

class _EditDoctorWebState extends State<EditDoctorWeb> {
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
  final uuid;

  const FormSection({Key? key, required this.uuid}) : super(key: key);

  @override
  State<FormSection> createState() => FormSectionState();
}

class FormSectionState extends State<FormSection> {
  TextEditingController serviceDescription = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController doctorName = TextEditingController();
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
        .collection('doctors')
        .doc(widget.uuid)
        .get();

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Update the controllers with the fetched data
    setState(() {
      serviceDescription.text = data['doctorDescription'] ?? '';
      price.text = (data['price'] ?? 0).toString(); // Convert int to string
      pass.text = data['pass'] ?? ''; // Convert int to string
      imageUrl = data['photoURL'];
      doctorName.text = data['doctorName'] ?? '';
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
        .child('doctors')
        .child('${FirebaseAuth.instance.currentUser!.uid}.jpg');
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  //Program
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                          radius: 59, backgroundImage: NetworkImage(imageUrl!))
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/Choose Image.png"),
                        ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormInputField(
                controller: doctorName,
                hintText: "Doctor Name",
                IconSuffix: Icons.text_decrease,
                textInputType: TextInputType.text),
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
                controller: pass,
                hintText: "Password",
                IconSuffix: Icons.lock,
                textInputType: TextInputType.text),
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
                            downloadUrl = await uploadImageToStorage(_image!);
                          } else {
                            downloadUrl = imageUrl;
                          }

                          try {
                            await FirebaseFirestore.instance
                                .collection("doctors")
                                .doc(widget.uuid) // Use widget.uuid here
                                .update({
                              "doctorDescription": serviceDescription.text,
                              "price": int.parse(
                                  price.text), // Convert string to int
                              "pass": pass.text, // Convert string to int
                              "photoURL": downloadUrl,
                              "doctorName": doctorName.text,
                            });
                            showMessageBar(
                                "Medical Services Updated Successfully ",
                                context);
                          } catch (e) {
                            // Handle errors here
                            print("Error updating service: $e");
                            showMessageBar("Failed to update service", context);
                          } finally {
                            setState(() {
                              _isLoading = false;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => WebHome()));
                          }
                        }),
                  ),
          ),
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
