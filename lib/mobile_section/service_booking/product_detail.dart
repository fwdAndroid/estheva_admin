import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:estheva_admin/mobile_section/add_edit_services/edit_services.dart';
import 'package:estheva_admin/utils/buttons.dart';
import 'package:estheva_admin/utils/colors.dart';
import 'package:estheva_admin/widgets/delete_widgets.dart';

class ProductDetail extends StatefulWidget {
  final discount;
  final photoURL;
  final price;
  final serviceCategory;
  final serviceSubCategory;
  final serviceName;
  final description;
  final uuid;
  const ProductDetail({
    super.key,
    required this.description,
    required this.discount,
    required this.photoURL,
    required this.uuid,
    required this.price,
    required this.serviceCategory,
    required this.serviceName,
    required this.serviceSubCategory,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int selectedOption = 0; // For tracking selected radio button option
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            mainBtnColor, // Change to the yellow color in the design
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Image.asset(
          'assets/logos.png', // Replace with your logo asset path
          height: 30,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Handle search button action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                            builder: (builder) => EditServices(
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
      ),
    );
  }
}
