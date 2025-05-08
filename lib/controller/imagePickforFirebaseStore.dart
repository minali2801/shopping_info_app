import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoreImageToFirestoState extends StatefulWidget {
  const StoreImageToFirestoState({super.key});

  @override
  State<StoreImageToFirestoState> createState() =>
      __StoreImageToFirestoStateState();
}

class __StoreImageToFirestoStateState extends State<StoreImageToFirestoState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();
  

  // Function to pick image, convert to Base64, and store in Firestore
  Future<void> pickImageAndStore() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        // Convert image to bytes
        final bytes = await image.readAsBytes();
        // Convert image bytes to Base64 string
        final base64String = base64Encode(bytes);
        // Store the Base64 string in Firestore
        await _firestore.collection("banners").add({
          "imageBase64": base64String,
          "uploadedAt": DateTime.now(), 
          "uploader": "Minali",
        });
      }
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text('image aceses is done'))); 
    } catch (e) {
      print("Error picking/storing image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Store Image in firestore')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            pickImageAndStore();
          },
          child: Text('Pick Image and store in firestore'),
        ),
      ),
    );
  }
} 
