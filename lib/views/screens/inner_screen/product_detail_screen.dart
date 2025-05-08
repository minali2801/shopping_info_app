import 'dart:math';

import 'package:appforhelp/provider/cart_provider.dart';
import 'package:appforhelp/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final dynamic productData;

  const ProductDetailScreen({super.key, required this.productData});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final data = widget.productData.data(); // Extract the map from the snapshot
    // ignore: no_leading_underscores_for_local_identifiers
    final cartProviderData = ref.read(cartProvider.notifier);
    final favoriteProviderData = ref.read(favoriteProvider.notifier);
    ref.watch(favoriteProvider);

    return Scaffold(
      backgroundColor: Color(0xFFEFFBF0),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Product Detail',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF126881),
              ),
            ),
            Container(
              width: 36,
              height: 35,
              decoration: BoxDecoration(
                color: Color(0xFF126881),
                borderRadius: BorderRadius.circular(18.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.1),
                    spreadRadius: 1,
                    offset: Offset(0, 3),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  favoriteProviderData.addProductToFavorite(
                    productName: widget.productData['productName'],
                    productId: widget.productData['productId'],
                    image: "",
                    productPrice: widget.productData['productPrice'],
                    discount: widget.productData['discount'],
                    category: widget.productData['category'],
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.grey.withOpacity(.9),
                      duration: Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        "${widget.productData['productName']} added favorite",
                        style: GoogleFonts.lato(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
                icon:
                    favoriteProviderData.getFavoriteItem.containsKey(
                          widget.productData["productId"],
                        )
                        ? Icon(
                          Icons.favorite,
                          color: Colors.white, // filled heart color
                          size: 20,
                        )
                        : Icon(
                          Icons.favorite_border,
                          color: Colors.white, // empty heart color
                          size: 20,
                        ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 262.w,
                    height: 274.h,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 2,
                          top: 3,
                          child: Container(
                            width: 260.w,
                            height: 260.h,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: Color(0xFFD8DDFF),
                              borderRadius: BorderRadius.circular(130.r),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 22,
                          top: 3,
                          child: Container(
                            width: 216.w,
                            height: 274.h,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: Color(0xFF9CA8FF),
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: SizedBox(
                              height: 300.h,
                              child: PageView.builder(
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return Image.asset(
                                    'assets/images/pencil.jpg',
                                    width: 150.w,
                                    height: 200.h,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.productData['productName'],
                        style: GoogleFonts.roboto(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3C55EF),
                          letterSpacing: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0.h),
                        child: Text(
                          '\$${widget.productData['productPrice'].toStringAsFixed(2)}',
                          style: GoogleFonts.roboto(
                            fontSize: 18.sp,
                            color: Color(0xFF3C55EF),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                    left: 8,
                    right: 8,
                    bottom: 8,
                  ),
                  child: Text(
                    'Category: ${data["category"]}',
                    style: GoogleFonts.lato(
                      color: Colors.grey,
                      fontSize: 16.sp,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                widget.productData['rating'] == 0
                    ? SizedBox()
                    : Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 24),
                          Text(
                            widget.productData['rating'].toString(),
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                          Text(
                            "(${widget.productData['totalReview']})",
                            style: GoogleFonts.lato(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),

                Padding(
                  padding: EdgeInsets.all(8.0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Size:',
                        style: GoogleFonts.lato(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(
                        height: 44.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: widget.productData['productSize'].length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                top: 5,
                                left: 5,
                                bottom: 5,
                                right: 6,
                              ),
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 44.h,
                                  width: 30.w,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF126881),
                                    borderRadius: BorderRadius.circular(6.r),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: sqrt1_2.w,
                                    ),
                                  ),
                                  child: Text(
                                    widget.productData['productSize'][index],
                                    style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About:',
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                      Text(
                        widget.productData['description'],
                        style: GoogleFonts.roboto(
                          // fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                          color: Colors.grey[900],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(8.h),
        child: InkWell(
          onTap: () {
            cartProviderData.addProductToCart(
              productName: widget.productData['productName'],
              productPrice: widget.productData['productPrice'],
              categoryName: widget.productData['category'],
              image: "",
              quantity: 1,
              instock:
                  (widget.productData['quantity'] is num)
                      ? (widget.productData['quantity'] as num).toInt()
                      : 0,
              productId: widget.productData['productId'],
              productSize: "",
              discount: widget.productData['discount'],
              description: widget.productData['description'],
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.grey.withOpacity(.9),
                duration: Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
                content: Text(
                  "${widget.productData['productName']} added cart",
                  style: GoogleFonts.lato(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
          child: Container(
            width: 386.w,
            height: 48.h,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Color(0xFF126881),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Center(
              child: Text(
                'ADD TO CART',
                style: GoogleFonts.lato(
                  fontSize: 14.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
