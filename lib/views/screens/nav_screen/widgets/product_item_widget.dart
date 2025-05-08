import 'package:appforhelp/views/screens/inner_screen/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductItemWidget extends StatelessWidget {
  final dynamic productData;

  const ProductItemWidget({super.key, required this.productData});

  // ignore: prefer_typing_uninitialized_variables
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(productData: productData),
          ),
        );
      },
      child: Container(
        height: 245,
        width: 150,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 150,
                height: 245,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.r),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0f040828),
                      spreadRadius: 0.r,
                      offset: Offset(0, 18),
                      blurRadius: 30.r,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 7,
              top: 130,
              child: Text(
                productData['productName'],
                style: GoogleFonts.lato(
                  color: Color(0xFF1E3354),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: .3,
                ),
              ),
            ),
            Positioned(
              left: 7,
              top: 177,
              child: Text(
                productData['category'],
                style: GoogleFonts.lato(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  letterSpacing: .2,
                ),
              ),
            ),
            Positioned(
              left: 7,
              top: 207,
              child: Text(
                '\$${productData['productPrice']}',
                style: GoogleFonts.roboto(
                  color: Colors.blueAccent,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: .4,
                ),
              ),
            ),
            Positioned(
              left: 80,
              top: 210,
              child: Text(
                '\$${productData['discount']}',
                style: GoogleFonts.roboto(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  letterSpacing: .3,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ),
            Positioned(
              left: 9,
              top: 9,
              child: Container(
                width: 128.w,
                height: 108.h,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.r),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: -1,
                      top: -1,
                      child: Container(
                        width: 130,
                        height: 110,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF5C3),
                          border: Border.all(width: 0.8, color: Colors.yellow),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 14,
              top: 4,
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  width: 100,
                  height: 100,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Colors.yellow),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 5,
              child: Image.asset(
                'assets/images/pencil.jpg',
                width: 130,
                height: 100,
              ),
            ),
            Positioned(
              left: 56,
              top: 155,
              child: Text(
                '500> sold',
                style: GoogleFonts.lato(color: Colors.blueGrey.withOpacity(.9),fontWeight: FontWeight.w700, fontSize: 12.sp),
              ),
            ),
            Positioned(
              left: 23,
              top: 155,
              child: Text(
                // ignore: unrelated_type_equality_checks
                productData['rating'] == 0
                    ? ""
                    : productData['rating'].toString(),
                style: GoogleFonts.lato(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 12.sp),
              ),
            ),
            productData['rating'] == 0
                ? SizedBox()
                : const Positioned(
                  left: 5,
                  top: 157,
                  child: Icon(Icons.star, color: Colors.amber, size: 16),
                ),
            Positioned(
              left: 104,
              top: 14,
              child: Container(
                width: 27,
                height: 27,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red.shade800, Colors.red.shade600],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent.withOpacity(0.1),
                      spreadRadius: 1,
                      offset: Offset(0, 3),
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 8.5,
              top: 4,
              // ignore: dead_code
              child: IconButton(
                onPressed: () {
                  // setState(() {
                  //   isClickd = !isClickd;
                  // });
                },
                // ignore: dead_code
                icon: Icon(Icons.favorite, color: Colors.white, size: 21),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
