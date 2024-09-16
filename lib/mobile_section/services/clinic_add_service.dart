import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:estheva_admin/database/database.dart';
import 'package:estheva_admin/mobile_section/main/main_dashboard.dart';
import 'package:estheva_admin/utils/buttons.dart';
import 'package:estheva_admin/utils/colors.dart';
import 'package:estheva_admin/utils/image_utils.dart';
import 'package:estheva_admin/widgets/text_form_field.dart';

class ClinicAddService extends StatefulWidget {
  const ClinicAddService({super.key});

  @override
  State<ClinicAddService> createState() => _ClinicAddServiceState();
}

class _ClinicAddServiceState extends State<ClinicAddService> {
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final Map<String, List<String>> _serviceCategories = {
    //Done
    'Body Contouring Packages': [
      '1D Ultrasound Cavitation Slimming Treatment',
      '2D Ultrasound Cavitation + RF + Vacu Slimming Treatment',
      '3D Ultrasound Cavitation + RF + Vacu Slimming Treatment',
      'Endermology',
      'Emerald Lipo Laser',
      'Fat reduction Injections for Body',
      'Fat Freezing - 60 min. 2 Areas',
      'The Sculpt RF',
      'HIFU Body 1 Area',
      'Multipolar Radiofrequency Skin Lifting for Body and Face',
    ],

    //Done
    'IV Drips Therapy': [
      'NAD+ IV Drips Therapy',
      'Detox IV Drips',
      'Anti-Aging IV Drips Therapy',
      'Detox IV Drips',
      'Hydration IV Drips',
      'Iron Drip Therapy',
      "NAD+ IV Drips Therapy",
    ],

    //Done
    'IV Drips Therapy Packages': [
      'Anti-Aging IV Drips Packages',
      'Detox IV Packages',
      'Hydration IV Packages',
      'Iron Drip Packages',
      "NAD+ IV Drips Packages",
    ],

    //Done
    'Health Checkup': [
      'Bio Advanced Blood Test',
      'Bio Executive Blood Test',
      'Bio Full Body Health Checkup Women',
      'Cancer Screen Male',
      'Cancer Screen Female',
      'Cardiac Risk Blood Test',
      'Female Hormone Profile',
      'Full Male Health Checkup',
      'Bio Full Body Health Checkup Women',
      'Obesity Risk Profile',
      'STD Profile by PRC',
      'STD Risk Assessment'
    ],

    //Done
    'Physiotherapy': [
      'Cupping Therapy',
      'Electro Muscle Stimulation (EMS)',
      'Manual Lymphatic Drainage Massage 50 min.',
      'Madero Therapy -  Lymphatic Drainage Massage 50 min',
      'Physiotherapy',
      'Pressotherapy - Lymphatic Drainage 30 min.',
      'Sports Massage 50 min',
    ],

    //
    'Aesthetic': [
      'Botox for Men - 1 Area, Allergan',
      'Botox for Women - 1 Area, Allergan',
      'Dermal Filler - 1 ml Croma',
      'Dermal Filler - 1ml. Juvederm',
      'Dermal Filler - Neauvia 1ml',
      'Dermal Fillers for Men - 1 ml Neauvia',
      'Dermal Fillers for Women - 1 ml',
      'Free Aesthetic Consultation',
      'Hair Growth Treatment for Men:  Polipeptides Mesotherapy',
      'HIFU - Double Chin Reduction',
      'HIFU Body 1 Area',
      'HIFU Face Lift',
      'Hydra Deluxe Skin Booster',
      'Hydrafacial',
      'Intense Lips Filler - 1 ml Neauvia',
      'Lip Filler -  1 ml Croma',
      'Lips Filler - 1 ml. Juvederm',
      'Mesotherapy with Dermapen: The Ultimate Anti-Aging Solution',
      'Mesotherapy: Needle-Free Electroporation',
      'Fat Reduction Injections For Double Chain'
    ],
    'Hair Transplant': ['Hair Transplant']
  };

  String? _selectedCategory;
  String? _selectedSubCategory;
  List<String> _subCategories = [];
  Uint8List? _image;
  bool isAdded = false;
  // Error message for discount
  String? discountErrorMessage;

  @override
  void initState() {
    super.initState();
    discountController.addListener(_validateDiscount);
  }

  @override
  void dispose() {
    discountController.removeListener(_validateDiscount);
    super.dispose();
  }

  void _validateDiscount() {
    final input = discountController.text;
    if (input.isNotEmpty) {
      final value = int.tryParse(input);
      setState(() {
        discountErrorMessage = (value != null && value > 100)
            ? 'Discount cannot be more than 100%'
            : null;
      });
    } else {
      setState(() {
        discountErrorMessage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: colorwhite),
          backgroundColor: mainBtnColor,
          title: Text(
            "Add Services",
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
                padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  isExpanded: true,
                  hint: Text('Select Category'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                      _subCategories = _serviceCategories[_selectedCategory]!;
                      _selectedSubCategory = null; // Reset subcategory
                    });
                  },
                  items: _serviceCategories.keys
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 10),

              // Subcategory Dropdown
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8,
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _selectedSubCategory,
                  hint: Text('Select Subcategory'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedSubCategory = newValue;
                    });
                  },
                  items: _subCategories
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
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

              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                      child: TextFormInputField(
                        controller: priceController,
                        hintText: "Price",
                        textInputType: TextInputType.number,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                      child: Column(
                        children: [
                          TextFormInputField(
                            controller: discountController,
                            hintText: "Discount",
                            textInputType: TextInputType.number,
                          ),
                          if (discountErrorMessage != null)
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 4.0),
                              child: Text(
                                discountErrorMessage!,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
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
                        } else if (priceController.text.isEmpty) {
                          showMessageBar("Price is Required", context);
                        } else {
                          print("clsasdd");
                          int discount = 0;
                          if (discountController.text.isNotEmpty) {
                            discount =
                                int.tryParse(discountController.text) ?? 0;
                            if (discount > 100) {
                              showMessageBar(
                                  "Discount cannot be more than 100%", context);
                              return;
                            }
                          }

                          setState(() {
                            isAdded = true;
                          });

                          await Database().addServices(
                              type: "clinic",
                              serviceDescription:
                                  descriptionController.text.trim(),
                              serviceCategory: _selectedCategory!,
                              serviceName: _selectedCategory!,
                              file: _image!,
                              serviceSubcategory: _selectedSubCategory!,
                              price: int.parse(priceController.text),
                              discount: discount);
                          setState(() {
                            isAdded = false;
                          });
                          // Handle the result accordingly
                          showMessageBar(
                              "Service Category Added Successfully", context);
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
