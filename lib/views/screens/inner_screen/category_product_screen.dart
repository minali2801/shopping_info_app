import 'package:appforhelp/models/category_models.dart';
//import 'package:appforhelp/views/screens/inner_screen/product_detail_screen.dart';
import 'package:appforhelp/views/screens/nav_screen/widgets/popularItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryProductScreen extends StatelessWidget {
 final CategoryModel categoryModel;

  const CategoryProductScreen({super.key, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance.collection('products').where('category',isEqualTo: categoryModel.categoryName).snapshots();
    print(_productStream);
    
    return  Scaffold(
       appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.12.h,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.r),
              bottomRight: Radius.circular(30.r),
            ),
            image: DecorationImage(
              image: AssetImage('assets/images/s2.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.blueGrey.withOpacity(0.3),
                BlendMode.darken,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Text(
                    categoryModel.categoryName,
                    style: GoogleFonts.poppins(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.5,
                      shadows: [
                        Shadow(
                          color: Colors.black87,
                          blurRadius: 10,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 50,
                right: 20,
                child: Image.asset(
                  'assets/icons/cart2.png',
                  width: 32.w,
                  height: 32.h,
                ),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder(
        stream: _productStream, 
        builder: (context , AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return Text('Something went wrong');
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }
          if(snapshot.data!.docs.isEmpty){
            return Center(child: Text('No product under this category \n check back later',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
            ),);
          }
          return GridView.count(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount:3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 320/520,
            children: List.generate(snapshot.data!.size,(index){
              final productData = snapshot.data!.docs[index];
              return PopulartItem(productData: productData);
            }),
            );
        }),
    );
  }
}

