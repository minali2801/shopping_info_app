import 'dart:convert';
import 'dart:typed_data';
import 'package:appforhelp/models/category_models.dart';
import 'package:appforhelp/views/screens/inner_screen/category_product_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatefulWidget {
  const CategoryItem({super.key});

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child:Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.withOpacity(0.1),
            width: 1.6.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 15.r,
              spreadRadius: 2.r,
              offset: Offset(1, 5),
            ),
          ]
        ),
        child: StreamBuilder(
          stream: _firestore.collection("category").snapshots(), 
          builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasError) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text('No data found'),
          );
          }
          // ignore: no_leading_underscores_for_local_identifiers
          var _categoryDocsCount = snapshot.data!.docs;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
           children: [
           GridView.builder(
                itemCount:_categoryDocsCount.length ,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing:1.0,
                crossAxisSpacing:1.0,
                childAspectRatio: 300/380,
                crossAxisCount:3), 
                itemBuilder: (context , index) {
                  Map<String, dynamic> categoryMap = _categoryDocsCount[index].data() as Map<String, dynamic>;
                  CategoryModel category = CategoryModel.fromMap(categoryMap);
                  Uint8List imageBytes = base64Decode(category.categoryImage);
                  // ignore: unnecessary_cast
                  // var category = _categoryDocsCount[index].data() as Map<String,dynamic>;
                  // String categoryName = category['categoryName'] ?? "minali";
                  // String categoryImage= category['categoryImage'] ?? Icon(Icons.error);
                  // Uint8List imageBytes = base64Decode(categoryImage);
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryProductScreen(categoryModel:category)));
                    },
                    child: Column(
                    children: [
                     Card(
                      elevation:10,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                       child: Image.memory(
                        imageBytes,
                        fit: BoxFit.cover,
                        height: 90,
                        width: 90,
                        ),
                     ),
                    const SizedBox(height:8),
                     Text(
                      category.categoryName,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        )
                      ),
                      textAlign: TextAlign.center,
                                     ),
                    ],
                                    ),
                  );
            }),
           ]
          );
          }),
      ),
    );
  }
}