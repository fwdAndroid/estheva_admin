import 'dart:typed_data';

import 'package:estheva_admin/database/database.dart';
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

class AddDoctorWeb extends StatefulWidget {
  const AddDoctorWeb({super.key});

  @override
  State<AddDoctorWeb> createState() => _AddDoctorWebState();
}

class _AddDoctorWebState extends State<AddDoctorWeb> {
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
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController doctorEmailController = TextEditingController();
  TextEditingController doctorPasswordController = TextEditingController();

  Uint8List? _image;
  bool isAdded = false;
  String dropdownvalue = 'Body Contouring Packages';

  // List of items in our dropdown menu
  var items = [
    'Body Contouring Packages',
    'IV Drips Therapy',
    'IV Drips Therapy Packages',
    'Health Checkup',
    'Physiotherapy',
  ];

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
            const Text(
              "Add Doctor",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25.63),
            ),
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
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: TextFormInputField(
                controller: serviceNameController,
                hintText: "Doctor Name",
                textInputType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: TextFormInputField(
                controller: doctorEmailController,
                hintText: "Doctor Email",
                textInputType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: TextFormInputField(
                controller: doctorPasswordController,
                hintText: "Doctor Password",
                textInputType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton(
                isExpanded: true,
                // Initial Value
                value: dropdownvalue,

                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),

                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
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
                  hintText: "Description",
                  hintStyle: GoogleFonts.nunitoSans(fontSize: 16),
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: TextFormInputField(
                controller: experienceController,
                hintText: "Doctor Experience",
                textInputType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
              child: TextFormInputField(
                controller: priceController,
                hintText: "Price",
                textInputType: TextInputType.number,
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
                        await Database().addDoctor(
                          doctorEmail: doctorEmailController.text.trim(),
                          doctorPassword: doctorPasswordController.text.trim(),
                          serviceName: serviceNameController.text.trim(),
                          serviceCategory: dropdownvalue,
                          experience: experienceController.text,
                          serviceDescription: descriptionController.text.trim(),
                          file: _image!,
                          price: int.parse(priceController.text.trim()) ?? 0,
                        );
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
