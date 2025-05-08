import 'package:appforhelp/provider/cart_provider.dart';
import 'package:appforhelp/views/screens/inner_screen/checkout_screen.dart';
import 'package:appforhelp/views/screens/main_screen.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    final cartData = ref.watch(cartProvider);
    // ignore: no_leading_underscores_for_local_identifiers
    final _cartProvider = ref.read(cartProvider.notifier);
    final totalAmount = ref.read(cartProvider.notifier).calculateTotalAmount();

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
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey,
                blurRadius: 5.0,
                spreadRadius: 2.0,
                offset: Offset(1, 1),
              ),
            ],
            image: DecorationImage(
              image: AssetImage('assets/images/s2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 352,
                top: 60,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/icons/cart2.png',
                      width: 36.w,
                      height: 36.h,
                    ),
                    Positioned(
                      top: -3,
                      right: 0,
                      child: badges.Badge(
                        badgeStyle: badges.BadgeStyle(
                          badgeColor: Colors.blue,
                          elevation: 1.5,
                        ),
                        badgeContent: Text(
                          cartData.length.toString(),
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
                  'My Cart',
                  style: GoogleFonts.lato(
                    color: Color(0xFF126881),
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.white.withOpacity(0.6),
                        offset: Offset(2.0, 2.0),
                        blurRadius: 4.0,
                      )
                    ]
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body:
          cartData.isEmpty
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
                                  blurRadius: 2.0,
                                ),
                              ],
                            ),
                          ),
                         const SizedBox(height: 20),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: 12.h,
                                horizontal: 24.w,
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
              : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width.w,
                      height:50.h,
                      margin: EdgeInsets.symmetric(vertical:10,horizontal: 10),
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        gradient: LinearGradient(
                        colors: [  Color(0xFFB4C5FF),Color(0xFFB4C5FF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey.withOpacity(.3),
                            offset: Offset(2,2),
                            blurRadius: 5.0.r,
                            spreadRadius: 2.0.r,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width.w,
                              height: 55.h,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(  // color: Color(0xFFD7DDFF),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 28,
                            top: 22,
                            child: Container(
                              width: 10.w,
                              height: 10.h,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 54,
                            top: 14,
                            child: Text(
                              'You have ${cartData.length} items',
                              style: GoogleFonts.roboto(
                                fontSize: 18.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0.5, 0.5),
                                    blurRadius: 2.0,
                                    color: Colors.black26,
                                  )
                                ]
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:1,bottom:10,left:10,right:10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          // border: Border.all(
                          //   color: Colors.blueGrey,
                          // ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(.2),
                              offset: Offset(1, 1),
                              blurRadius: 1.r,
                              spreadRadius: 1.r,
                            ),
                          ],
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cartData.length,
                          itemBuilder: (context, index) {
                            final cartItem = cartData.values.toList()[index];
                            return Padding(
                              padding: EdgeInsets.all(8),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                shadowColor: Colors.blueGrey.shade300,
                                child: SizedBox(
                                  height: 200.h,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 150.h,
                                        width: 100.w,
                                        child: Image.asset(
                                          'assets/images/pencil11.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cartItem.productName,
                                              style: GoogleFonts.lato(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              'Category: ${cartItem.categoryName}',
                                              style: GoogleFonts.lato(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.blueGrey,
                                              ),
                                            ),
                                            Text(
                                              cartItem.productPrice
                                                  .toStringAsFixed(2),
                                              style: GoogleFonts.lato(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey.shade800,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 40.h,
                                                  width: 120.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          5.r,
                                                        ),
                                                    color: Colors.blue.shade500,
                                                    border: Border.all(
                                                      width: 0.5.w,
                                                      color: Colors.black,
                                                    ),
                                                  ),

                                                  child: Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          _cartProvider
                                                              .decrement(
                                                                cartItem
                                                                    .productId,
                                                              );
                                                        },
                                                        icon: Icon(
                                                          CupertinoIcons.minus,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Text(
                                                        cartItem.quantity
                                                            .toString(),
                                                        style: GoogleFonts.lato(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                     const SizedBox(width: 6),
                                                      IconButton(
                                                        onPressed: () {
                                                          _cartProvider
                                                              .incrementItem(
                                                                cartItem
                                                                    .productId,
                                                              );
                                                        },
                                                        icon: Icon(
                                                          CupertinoIcons.plus,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    _cartProvider.removeToItem(
                                                      cartItem.productId,
                                                    );
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      SnackBar(
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        margin:
                                                            const EdgeInsets.all(
                                                              15,
                                                            ),
                                                        backgroundColor:
                                                            Colors.blueGrey,
                                                        duration: Duration(
                                                          seconds: 1,
                                                        ),
                                                        content: Text(
                                                          '${cartItem.productName} remove from cart',
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  icon: Icon(
                                                    CupertinoIcons.delete,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 418.w,
          height: 85.h,
          decoration: BoxDecoration(),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 416.w,
                  height: 89.h,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1, 1),
                        blurRadius: 1.5.r,
                        spreadRadius: 1.5.r,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(-0.85, -0.12),
                child: Text(
                  'Subtotal',
                  style: GoogleFonts.roboto(
                    color: Color(0xFFA1A1A1),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: Alignment(-0.25, -0.18),
                child: Text(
                  totalAmount.toStringAsFixed(2),
                  style: GoogleFonts.roboto(
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w500,
                    fontSize: 24.sp,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8, left: 110),
                child: Align(
                  alignment: Alignment(0.83, -1),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => CheckoutScreen()));
                    },
                    child: Container(
                      width: 155.w,
                      height: 65.h,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color:
                            totalAmount == 0.0
                                ? Colors.grey.shade500
                                : Colors.blue.shade500,
                        borderRadius: BorderRadius.circular(18.r),
                        border: Border.all(width: 0.5.w, color: Colors.black),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Checkout',
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white.withOpacity(.9),
                              ),
                            ),
                          ],
                        ),
                      ),
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
}
