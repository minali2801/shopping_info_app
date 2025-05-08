import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CategoryImageAndNamePick extends StatefulWidget {
  const CategoryImageAndNamePick({super.key});

  @override
  State<CategoryImageAndNamePick> createState() => _CategoryImageAndNamePickState();
}

class _CategoryImageAndNamePickState extends State<CategoryImageAndNamePick> {
  final TextEditingController _categoryNameContoller = TextEditingController();
  File? _selectedImage;
  String? base64Image;
  final ImagePicker _picker = ImagePicker();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  Future <void> _pickImage ()  async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        base64Image = base64Encode(_selectedImage!.readAsBytesSync());
      });
    }
  }
  Future<void> _saveToFirestore () async {
    if(_categoryNameContoller.text.isNotEmpty && base64Image !=null) {
      await _firestore.collection("category").add(
        { 
          "categoryName":_categoryNameContoller.text,
          "categoryImage":base64Image,
        }
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Category added done ')));
     } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('not add')));
     }
  }
     
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('For CategoryUse'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 20,left: 12,right: 12),
            child: TextField(
                controller: _categoryNameContoller,
                decoration: InputDecoration(
                labelText: "Category Name",
                border: OutlineInputBorder()
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _pickImage, 
            child:Text('Pick image for Category'),
            ),      
            if (_selectedImage != null)
              Column(
                children: [
                  Image.file(_selectedImage!, height: 150),
                  Text("Image Selected", style: TextStyle(color: Colors.blue)),
                ],
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: _saveToFirestore, 
                child: Text('save Category'),),  
        ],
      ),
    );
  }
}