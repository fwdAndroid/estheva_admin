import 'package:flutter/material.dart';
import 'package:estheva_admin/utils/colors.dart';

class ProductBooking extends StatefulWidget {
  const ProductBooking({super.key});

  @override
  State<ProductBooking> createState() => _ProductBookingState();
}

class _ProductBookingState extends State<ProductBooking> {
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
      body: Column(
        children: [],
      ),
    );
  }
}
