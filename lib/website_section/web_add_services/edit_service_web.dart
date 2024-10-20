import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estheva_admin/utils/buttons.dart';
import 'package:estheva_admin/utils/colors.dart';
import 'package:estheva_admin/utils/image_utils.dart';
import 'package:estheva_admin/website_section/web_add_services/add_home_services.dart';
import 'package:estheva_admin/website_section/web_home.dart';
import 'package:estheva_admin/widgets/text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditServiceWeb extends StatefulWidget {
  final uuid;
  const EditServiceWeb({super.key, required this.uuid});

  @override
  State<EditServiceWeb> createState() => _EditServiceWebState();
}

class _EditServiceWebState extends State<EditServiceWeb> {
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
  TextEditingController discount = TextEditingController();
  TextEditingController time = TextEditingController();
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
      time.text = data['time'] ?? "0.0";
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
                controller: serviceDescription,
                hintText: "Description",
                IconSuffix: Icons.text_decrease,
                textInputType: TextInputType.text),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: TextFormInputField(
              hintText: "Select Time",
              onTap: () async {
                int? pickedMinutes = await showDialog<int>(
                  context: context,
                  builder: (BuildContext context) {
                    int selectedMinutes = 0; // Default value

                    return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          title: Text('Select Minutes'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Slider(
                                value: selectedMinutes.toDouble(),
                                min: 0,
                                max: 120,
                                divisions: 120,
                                label: "$selectedMinutes mins",
                                onChanged: (double value) {
                                  setState(() {
                                    selectedMinutes = value.toInt();
                                  });
                                },
                              ),
                              Text("Selected: $selectedMinutes mins"),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop(selectedMinutes);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );

                if (pickedMinutes != null) {
                  // Calculate hours and minutes
                  int hours = pickedMinutes ~/ 60;
                  int minutes = pickedMinutes % 60;
                  String formattedTime;

                  if (hours > 0 && minutes > 0) {
                    formattedTime =
                        '$hours hr${hours > 1 ? 's' : ''} and $minutes min${minutes > 1 ? 's' : ''}';
                  } else if (hours > 0) {
                    formattedTime = '$hours hr${hours > 1 ? 's' : ''}';
                  } else {
                    formattedTime = '$minutes min${minutes > 1 ? 's' : ''}';
                  }

                  // Display the formatted time in the TextFormField
                  time.text = formattedTime;
                }
              },
              controller: time,
              textInputType: TextInputType.number,
            ),
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
                            downloadUrl = await uploadImageToStorage(_image!);
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
                              "photoURL": downloadUrl,
                              "time": time.text
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
