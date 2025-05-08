import 'package:appforhelp/provider/cart_provider.dart';
import 'package:appforhelp/views/screens/inner_screen/shipping_addresh_screen.dart';
import 'package:appforhelp/views/screens/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  String _selectPaymentMethod = 'stripe';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoding = false;
  // get current user information
  String state = '';
  String city = '';
  String locality = '';
  String pincode = '';
  String address = '';
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  // get current user details
  void getUserData() {
    Stream<DocumentSnapshot> userDataStream =
        _firestore.collection('buyers').doc(_auth.currentUser!.uid).snapshots();

    // list to the stream aand update the data
    userDataStream.listen((DocumentSnapshot userData) {
      if (userData.exists) {
        setState(() {
          state = userData.get('state');
          city = userData.get('city');
          locality = userData.get('locality');
          address = userData.get('address');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProviderData = ref.read(cartProvider);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.18.h,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width.w,
          height: 115.h,
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
                top: 50,
                left: 16,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(.5),
                        offset: Offset(2, 2),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pop(context); // This pops the current screen
                  },
                ),
              ),
              Positioned(
                left: 145,
                top: 55,
                child: Text(
                  'Checkout',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w800,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(.5),
                        offset: Offset(2, 2),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
           padding: const EdgeInsets.all(2.0),
            child: Text(
              'Your items',
              style: GoogleFonts.lato(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(.2),
                    offset: Offset(2, 2),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8,left: 10,right: 10,bottom: 8),
            child: Flexible(
              child: ListView.builder(
                itemCount: cartProviderData.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final cartData = cartProviderData.values.toList()[index];
                  return Container(
                 clipBehavior: Clip.hardEdge,
                  height: 95,
                  width: double.infinity.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xFFEFF0F2)),
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.8),
                        blurRadius: 3.0,
                        spreadRadius: 3.0,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Row(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left:10,),
                        width: 80,
                        height: 80,
                        decoration:BoxDecoration(
                          color: Colors.grey.withOpacity(.3),
                          borderRadius: BorderRadius.circular(10.r)
                        ) ,
                        child: Image.asset('assets/images/pen.png',
                        width: 30.w,
                        height: 30.h,
                        fit: BoxFit.cover,
                        ),
                      ),
                     // const SizedBox(width:1),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cartData.productName,
                          style: GoogleFonts.lato(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                            height: 1.5.h,
                          ),
                          ),
                          Text(cartData.categoryName,
                          style: GoogleFonts.lato(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.blueGrey.withOpacity(.7)
                          ),
                          ),
                          Text('\$${cartData.productPrice.toStringAsFixed(2)}',
                          style: GoogleFonts.lato(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                          ),
                        ],
                      ),
                     const SizedBox(width: 30),
                      Text('Discount:${cartData.discount.toString()}',
                      style: GoogleFonts.lato(
                        color: Colors.redAccent,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      )
                    ],
                  ),
                  
                   );
                  // return InkWell(
                  //   onTap: () {},
                  //   child: Container(
                  //     width: 300,
                  //     height: 91,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       border: Border.all(color: Color(0xFFEFF0F2)),
                  //       borderRadius: BorderRadius.circular(10),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.grey.withOpacity(.8),
                  //           blurRadius: 3.0,
                  //           spreadRadius: 3.0,
                  //           offset: Offset(2, 2),
                  //         ),
                  //       ],
                  //     ),
                  //     child: Stack(
                  //       clipBehavior: Clip.none,
                  //       children: [
                  //         Positioned(
                  //           left: 8,
                  //           top: 6,
                  //           child: SizedBox(
                  //             width: 311,
                  //             child: Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Container(
                  //                   width: 78,
                  //                   height: 78,
                  //                   clipBehavior: Clip.hardEdge,
                  //                   decoration: BoxDecoration(
                  //                     color: Color(0xFFBCC9FF),
                  //                   ),
                  //                   child: Image.asset(
                  //                     "assets/images/pen.png",
                  //                     fit: BoxFit.cover,
                  //                   ),
                  //                 ),
                  //                 SizedBox(width: 11),
                  //                 Expanded(
                  //                   child: Container(
                  //                     height: 78,
                  //                     alignment: Alignment(0, -0.51),
                  //                     child: SizedBox(
                  //                       width: double.infinity,
                  //                       child: Column(
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.spaceBetween,
                  //                         mainAxisSize: MainAxisSize.min,
                  //                         children: [
                  //                           SizedBox(
                  //                             width: double.infinity,
                  //                             child: Text(
                  //                               cartData.productName,
                  //                               style: GoogleFonts.lato(
                  //                                 fontSize: 16,
                  //                                 fontWeight: FontWeight.w800,
                  //                                 color: Colors.black,
                  //                                 height: 1.3,
                  //                               ),
                  //                             ),
                  //                           ),
                  //                           const SizedBox(height: 3),
                  //                           Align(
                  //                             alignment: Alignment.centerLeft,
                  //                             child: Text(
                  //                               cartData.categoryName,
                  //                               style: GoogleFonts.lato(
                  //                                 fontSize: 16,
                  //                                 fontWeight: FontWeight.w400,
                  //                                 color: Colors.blueGrey,
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 SizedBox(width: 20),
                  //                 Padding(
                  //                   padding: const EdgeInsets.only(top: 9),
                  //                   child: Text(
                  //                     "Discount: ${cartData.discount.toStringAsFixed(2)}",
                  //                     style: GoogleFonts.getFont(
                  //                       "Lato",
                  //                       fontSize: 14,
                  //                       color: Colors.pink,
                  //                       height: 1.3,
                  //                       fontWeight: FontWeight.bold,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //         Positioned(
                  //           left: 95,
                  //           top: 65,
                  //           child: Text(
                  //             "Rs.${cartData.productPrice}",
                  //             style: GoogleFonts.lato(
                  //               fontSize: 14,
                  //               color: Colors.blue,
                  //               fontWeight: FontWeight.w800,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8,bottom: 8,left: 10,right: 10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShippingAddreshScreen(),
                  ),
                );
              },
              child: Container(
                clipBehavior: Clip.hardEdge,
                height: 90,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFEFF0F2)),
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.8),
                      blurRadius: 3.0,
                      spreadRadius:2.0,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        left: 38,
                        right: 10,
                      ),
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.r),
                          color: Colors.grey.withOpacity(.1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(.1),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset(
                            'assets/icons/m1.png',
                            width: 10.w,
                            height: 10.h,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add Address',
                            style: GoogleFonts.lato(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w800,
                              height: 1.3.h,
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            'Enter city',
                            style: GoogleFonts.lato(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w800,
                              height: 1.3.h,
                              color: Color(0xFF7F808C),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 80),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xFFEFF0F2)),
                        borderRadius: BorderRadius.circular(70.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.8),
                            blurRadius: 3.0,
                            spreadRadius: 3.0,
                            offset: Offset(0.5, 0.5),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/icons/a2.png',
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
           Container(
            margin: EdgeInsets.only(top: 8,bottom: 8,left: 10,right: 10),
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(16.r),
               boxShadow: [
                 BoxShadow(
                   color: Colors.grey.withOpacity(0.8),
                   blurRadius: 10,
                   spreadRadius: 3,
                   offset: Offset(2, 2),
                 ),
               ],
             ),
             padding: const EdgeInsets.all(16),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   'Choose Payment Method',
                   style: GoogleFonts.lato(
                     fontSize: 18.sp,
                     fontWeight: FontWeight.bold,
                     color: Colors.black87,
                   ),
                 ),
                  const SizedBox(height: 16),
                 Row(
                   children: [
                     Expanded(
                       child: GestureDetector(
                         onTap: () {
                           setState(() {
                             _selectPaymentMethod = 'stripe';
                           });
                         },
                         child: Container(
                           padding: EdgeInsets.all(12),
                           decoration: BoxDecoration(
                             color:
                                 _selectPaymentMethod == 'stripe'
                                     ? Colors.blue.shade50
                                     : Colors.white,
                             border: Border.all(
                               color:
                                   _selectPaymentMethod == 'stripe'
                                       ? Colors.blue
                                       : Colors.grey.shade300,
                               width: 2.w,
                             ),
                             borderRadius: BorderRadius.circular(12.r),
                           ),
                           child: Column(
                             children: [
                               Icon(
                                 Icons.credit_card,
                                 size: 30,
                                 color: Colors.blue,
                               ),
                               const SizedBox(height: 8),
                               Text(
                                 "Stripe",
                                 style: GoogleFonts.lato(
                                   fontSize: 15.sp,
                                   fontWeight: FontWeight.bold,
                                   color: Colors.black,
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ),
                     ),
                    const SizedBox(width: 16),
                     Expanded(
                       child: GestureDetector(
                         onTap: () {
                           setState(() {
                             _selectPaymentMethod = 'cashOnDelivery';
                           });
                         },
                         child: Container(
                           padding: EdgeInsets.all(12),
                           decoration: BoxDecoration(
                             color:
                                 _selectPaymentMethod == 'cashOnDelivery'
                                     ? Colors.green.shade50
                                     : Colors.white,
                             border: Border.all(
                               color:
                                   _selectPaymentMethod == 'cashOnDelivery'
                                       ? Colors.green
                                       : Colors.grey.shade300,
                               width: 2.w,
                             ),
                             borderRadius: BorderRadius.circular(12.r),
                           ),
                           child: Column(
                             children: [
                               Icon(
                                 Icons.money,
                                 size: 30,
                                 color: Colors.green,
                               ),
                              const SizedBox(height: 8),
                               Text(
                                 "Cash on Delivery",
                                 style: GoogleFonts.lato(
                                   fontSize: 15.sp,
                                   fontWeight: FontWeight.bold,
                                   color: Colors.black,
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
                const SizedBox(height: 12),
               ],
             ),
           ),
        ],
      ),
      bottomSheet:
          state == ""
              ? Padding(
                padding: const EdgeInsets.only(bottom: 22),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFF1532E7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 132,
                      vertical: 10,
                    ),
                  ),
                  clipBehavior: Clip.hardEdge,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShippingAddreshScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Add Address',
                    style: GoogleFonts.lato(
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () async {
                    if (_selectPaymentMethod == 'stripe') {
                      // pay with stripe
                    } else {
                      setState(() {
                        _isLoding = true;
                      });
                      for (var item
                          in ref
                              .read(cartProvider.notifier)
                              .getCartItem
                              .values) {
                        DocumentSnapshot userDoc =
                            await _firestore
                                .collection('buyers')
                                .doc(_auth.currentUser!.uid)
                                .get();

                        CollectionReference orderRefer = _firestore.collection(
                          'orders',
                        );
                        final orderId = Uuid().v4();
                        await orderRefer
                            .doc(orderId)
                            .set({
                              'orderId': orderId,
                              'productName': item.productName,
                              'productId': item.productId,
                              'size': item.productSize,
                              'quantity': item.quantity,
                              'price': item.productPrice * item.quantity,
                              'category': item.categoryName,
                              'productImage': item.image,
                              'state':
                                  (userDoc.data()
                                      as Map<String, dynamic>)['state'],
                              'email':
                                  (userDoc.data()
                                      as Map<String, dynamic>)['email'],
                              'locality':
                                  (userDoc.data()
                                      as Map<String, dynamic>)['locality'],
                              'fullName':
                                  (userDoc.data()
                                      as Map<String, dynamic>)['fullName'],
                              'buyerId':
                                  _auth
                                      .currentUser!
                                      .uid, // it access current login buyer
                              'deliveredCount': 0,
                              'delivered': false,
                              'processing': true,
                              
                            })
                            .whenComplete(() {
                              cartProviderData.clear();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainScreen(),
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  margin: EdgeInsets.all(15),
                                  backgroundColor: Colors.grey,
                                  behavior: SnackBarBehavior.floating,
                                  duration: Duration(seconds: 2),
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  content: Text('Placed order'),
                                ),
                              );
                              setState(() {
                                _isLoding = false;
                              });
                            });
                      }
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(12),
                    height: 50,
                    width: MediaQuery.of(context).size.width - 50.w,
                    decoration: BoxDecoration(
                      color: Color(0xFF1532E7),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child:
                          _isLoding
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                'Place Order',
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.sp,
                                  height: 1.4.h,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(.6),
                                      offset: Offset(0.5, 0.5),
                                      blurRadius: 1.0,
                                    ),
                                  ],
                                ),
                              ),
                    ),
                  ),
                ),
              ),
    );
  }
}
