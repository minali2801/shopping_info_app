import 'package:appforhelp/provider/favorite_provider.dart';
import 'package:appforhelp/views/screens/main_screen.dart';
import 'package:badges/badges.dart' as badges;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteData = ref.read(favoriteProvider.notifier);
    final wishListData = ref.watch(favoriteProvider);

    // Future<void> getUserProductId(String productId)async {
    //    await FirebaseFirestore.instance.collection('productReview').where('productId',isEqualTo: productId).snapshots();
      
    // }
     
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.20.h,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width.w,
          height: 118.h,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.cyan],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 8.0,
                spreadRadius: 5.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                left: 352,
                top: 60,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/icons/cart1.png',
                      width: 40.w,
                      height: 40.h,
                      // color: Colors.white,
                    ),
                    Positioned(
                      top: -2,
                      right: 0,
                      child: badges.Badge(
                        badgeStyle: badges.BadgeStyle(
                          badgeColor: Colors.redAccent,
                          elevation: 5.0,
                          padding: EdgeInsets.all(7.0),
                        ),
                        badgeContent: Text(
                          wishListData.length.toString(),
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 58,
                left: 50,
                child: Text(
                  'Favorites',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body:
          wishListData.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                      ), // Add margin for spacing
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(
                          0.8,
                        ), // Light background for contrast
                        borderRadius: BorderRadius.circular(
                          15.r,
                        ), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 5.0.r,
                            spreadRadius: 2.0.r,
                            offset: Offset(2, 2), // Shadow for depth
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Your shopping cart is empty \n You can add products to your cart from the below button.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: 18.sp,
                              letterSpacing: 1,
                              color: Colors.black.withOpacity(
                                0.8,
                              ), // Slightly transparent black color
                              fontWeight: FontWeight.w500,
                              shadows: [
                                Shadow(
                                  offset: Offset(0.5, 0.5),
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 2.0.r,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 24,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              backgroundColor:
                                  Colors.blue.shade300, // Background color
                              elevation: 5, // Shadow for the button
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Shop Now',
                              style: GoogleFonts.lato(
                                fontSize: 20.sp,
                                letterSpacing: 1,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              : GridView.builder(
                itemCount: wishListData.length,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 2.0,
                  childAspectRatio: 0.6,
                ),
                itemBuilder: (context, index) {
              
                  final wishData = wishListData.values.toList()[index];
                  final productId = wishData.productId;
                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(1.0),
                    child: Card(
                      elevation: 6,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 140.h,
                            width:200.w,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(.3),
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    child: Image.asset(
                                      "assets/images/pen.png",
                                      width: 200.w,
                                      height: 140.h,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 136,
                                  top: 110,
                                  child: InkWell(
                                    onTap: () {
                                      favoriteData.removeToItem(
                                        wishData.productId,
                                      );
                                    },
                                    child: Container(
                                      width: 33.w,
                                      height: 33.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Icon(
                                        Icons.favorite,
                                        size: 25,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 8,
                              left: 15,
                              right: 15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  wishData.productName,
                                  style: GoogleFonts.lato(
                                    fontSize: 18.sp,
                                    color: Colors.grey.withOpacity(.8),
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.grey.withOpacity(.9),
                                        offset: Offset(0.5, 0.5),
                                        blurRadius: 1.0,
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Rs.${wishData.productPrice.toString()}",
                                      style: GoogleFonts.lato(
                                        fontSize: 18.sp,
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      wishData.discount.toString(),
                                      style: GoogleFonts.lato(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Category:${wishData.category}",
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(.7),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  children:[ 
                                    Icon(Icons.star,color: Colors.amber,size: 18),
                                    SizedBox(width:2),
                                    StreamBuilder<DocumentSnapshot>(
                                    stream:FirebaseFirestore.instance.collection('products').doc(productId).snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text('Error: ${snapshot.error}'),
                                        );
                                      }
                                  
                                      // Safely access the document data
                                      if (!snapshot.hasData ||
                                          snapshot.data == null ||
                                          !snapshot.data!.exists) {
                                        return const Center(
                                          child: Text('No data available'),
                                        );
                                      }
                                  
                                      final rating =
                                          snapshot.data!.data()
                                              as Map<String, dynamic>;
                                      final finalRating = rating['rating'] ?? '0.0';
                                         return Text(
                                           finalRating.toString(),
                                        style: GoogleFonts.lato(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      );
                                    },
                                  ),
                                  ]
                                ),
                                
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
