

import 'package:appforhelp/views/screens/inner_screen/checkout_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingAddreshScreen extends StatefulWidget {
  const ShippingAddreshScreen({super.key});

  @override
  State<ShippingAddreshScreen> createState() => _ShippingAddreshScreenState();
}

class _ShippingAddreshScreenState extends State<ShippingAddreshScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String state;
  late String city;
  late String locality;
  late String pincode;
  late String address;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 5,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 12.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CheckoutScreen(),
                  ),
                );
              },
            ),
          ),
          centerTitle: true,
          title: Container(
            margin: const EdgeInsets.only(top: 12),
            padding:  EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              'Delivery',
              style: GoogleFonts.lato(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Where should we deliver your order?',
                textAlign: TextAlign.left,
                style: GoogleFonts.lato(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),

              _buildTextField(
                label: 'State',
                onchanged: (value) => {state = value},
              ),
              _buildTextField(
                label: 'City',
                onchanged: (value) => {city = value},
              ),
              _buildTextField(
                label: 'Locality',
                onchanged: (value) => {locality = value},
              ),
              _buildTextField(
                label: 'Pincode',
                onchanged: (value) => {pincode = value},
              ),
              _buildTextField(
                label: 'Address',
                onchanged: (value) => {address = value},
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity.w,
                height: 52.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Handle submission
                      _showDialog(context);
                      await _firestore
                          .collection('buyers')
                          .doc(_auth.currentUser!.uid)
                          .update({
                            'state': state,
                            'city': city,
                            'locality': locality,
                            'pincode': pincode,
                            'address': address,
                          })
                          .whenComplete(() {
                            Navigator.of(context).pop();
                          });
                    } else {}
                  },
                  child: Text(
                    'Add Address',
                    style: GoogleFonts.lato(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    required Function(String) onchanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        onChanged: onchanged,
        keyboardType: keyboardType,
        maxLines: maxLines,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: label,
          hintText: 'Enter your $label',
          labelStyle: GoogleFonts.lato(fontSize: 15.sp, color: Colors.grey[700]),
          filled: true,
          fillColor: Colors.grey.withOpacity(.3),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return  AlertDialog(
        title: Text('Updating address'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
           const SizedBox(height: 10),
            Text('Please wait a moment..'),
          ],
        ),
      );
    },
  );
  Future.delayed(Duration(seconds:3), () {
    Navigator.of(context).pop();
  });
}
