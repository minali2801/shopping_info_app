import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetailScreen extends StatefulWidget {
  final dynamic order;
  const OrderDetailScreen({super.key, required this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final TextEditingController _reviewController = TextEditingController();
  double rating = 0.0;
  Future<bool> hasUserReviewedProduct(String productId) async {
    final user = FirebaseAuth.instance.currentUser;
    final querySnapshot =
        await FirebaseFirestore.instance
            .collection('productReview')
            .where('productId', isEqualTo: productId)
            .where('buyerId', isEqualTo: user!.uid)
            .get();
    return querySnapshot.docs.isNotEmpty;
  }

  // update review and rating within the product collection
  Future<void> updateProductRating(String productId) async {
    final querySnapshot =
        await FirebaseFirestore.instance
            .collection('productReview')
            .where('productId', isEqualTo: productId)
            .get();

    double totalRating = 0;
    int totalReview = querySnapshot.docs.length; 
    for (final doc in querySnapshot.docs) {
      totalRating += (doc['rating']);
    }
    final double avgRating = totalReview > 0 ? totalRating / totalReview : 0;
    final docRef = FirebaseFirestore.instance.collection('products').doc(productId);
    final docSnapshot = await docRef.get();
    if (docSnapshot.exists){
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .update({'rating': avgRating, 'totalReview': totalReview});
      print("Product updated successfully.");
    } else {
      print('no prodcut found with id : $productId');
    }
  }

  @override
  Widget build(BuildContext context) {
    final status =
        widget.order['delivered'] == true
            ? 'Delivered'
            : widget.order['processing'] == true
            ? 'Processing'
            : 'Cancelled';

    final statusColor =
        widget.order['delivered'] == true
            ? const Color(0xFF3C55EF)
            : widget.order['processing'] == true
            ? Colors
                .transparent // For gradient styling
            : Colors.red;
    return Scaffold(
      backgroundColor: Color(0xFFF5F9FF),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 4,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6DC8F3), Color(0xFF73A1F9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  offset: Offset(0, 3),
                  blurRadius: 8,
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.order['productName'] ?? 'Order Details',
                        style: GoogleFonts.poppins(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.more_vert, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            // Product Card
            Container(
              padding:  EdgeInsets.all(16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Product Image and Status Badge
                  Column(
                    children: [
                      Container(
                        width: 72.w,
                        height: 72.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFBCC5FF),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/images/pen.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          gradient:
                              status == 'Processing'
                                  ? const LinearGradient(
                                    colors: [
                                      Colors.purpleAccent,
                                      Colors.deepPurple,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                  : null,
                          color: status != 'Processing' ? statusColor : null,
                          borderRadius: BorderRadius.circular(6.r),
                          boxShadow: [
                            if (status == 'Processing')
                              BoxShadow(
                                color: Colors.purple.withOpacity(0.3),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                          ],
                        ),
                        child: Text(
                          status,
                          style: GoogleFonts.poppins(
                            fontSize: 13.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  // Product Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.order['productName'],
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.order['category'],
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      const SizedBox(height: 8),
                        Text(
                          '\$${widget.order['price']}',
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Delivery Address Card
            Container(
              width: double.infinity.w,
              // height: 195,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: const Color(0xFFEFF0F2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Delivery Address',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${widget.order['locality']} ${widget.order['state']}',
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                 const SizedBox(height: 0.4),
                  Text(
                    '${widget.order['state']}',
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                 const SizedBox(height: 0.4),
                  Text(
                    'To ${widget.order['fullName']}',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (widget.order['delivered'] == true) ...[
                   const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () async {
                        final productId = widget.order['productId'];
                        final hasReviewed = await hasUserReviewedProduct(
                          productId,
                        );
                        if (hasReviewed) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Update a Review',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey.withOpacity(.9),
                                  ),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      controller: _reviewController,
                                      decoration: InputDecoration(
                                        labelText: 'Update Your review',
                                        labelStyle: TextStyle(
                                          color: Colors.blueGrey.withOpacity(
                                            .8,
                                          ),
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RatingBar.builder(
                                        initialRating: rating,
                                        direction: Axis.horizontal,
                                        maxRating: 5,
                                        minRating: 1,
                                        allowHalfRating: true,
                                        itemSize: 30,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        unratedColor: Colors.blueGrey
                                            .withOpacity(.5),
                                        itemBuilder: (context, _) {
                                          return Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          );
                                        },
                                        onRatingUpdate: (value) {
                                          rating = value;
                                          print(rating);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                    ),
                                    onPressed: () async {
                                      final review = _reviewController.text;
                                      await FirebaseFirestore.instance
                                          .collection('productReview')
                                          .doc(widget.order['orderId'])
                                          .update({
                                            'reviewId': widget.order['orderId'],
                                            'productId':
                                                widget.order['productId'],
                                            'fullName':
                                                widget.order['fullName'],
                                            'email': widget.order['email'],
                                            'buyerId': widget.order['buyerId'],
                                            'rating': rating,
                                            'review': review,
                                            'timestamp': Timestamp.now(),
                                          })
                                          .whenComplete(() {
                                            updateProductRating(productId);
                                            Navigator.of(context).pop();
                                            _reviewController.clear();
                                            rating = 0;
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                backgroundColor: Colors.grey
                                                    .withOpacity(.8),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                duration: Duration(seconds: 1),
                                                content: Text(
                                                  'Review Update',
                                                  style: GoogleFonts.lato(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: Text(
                                      'Submit',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Leave a Review',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey.withOpacity(.9),
                                  ),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      controller: _reviewController,
                                      decoration: InputDecoration(
                                        labelText: 'Your review',
                                        labelStyle: TextStyle(
                                          color: Colors.blueGrey.withOpacity(
                                            .8,
                                          ),
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RatingBar.builder(
                                        initialRating: rating,
                                        direction: Axis.horizontal,
                                        maxRating: 5,
                                        minRating: 1,
                                        allowHalfRating: true,
                                        itemSize: 30,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        unratedColor: Colors.blueGrey
                                            .withOpacity(.5),
                                        itemBuilder: (context, _) {
                                          return Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          );
                                        },
                                        onRatingUpdate: (value) {
                                          rating = value;
                                          print(rating);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                    ),
                                    onPressed: () async {
                                      final review = _reviewController.text;
                                      await FirebaseFirestore.instance
                                          .collection('productReview')
                                          .doc(widget.order['orderId'])
                                          .set({
                                            'reviewId': widget.order['orderId'],
                                            'productId':
                                                widget.order['productId'],
                                            'fullName':
                                                widget.order['fullName'],
                                            'email': widget.order['email'],
                                            'buyerId': widget.order['buyerId'],
                                            'rating': rating,
                                            'review': review,
                                            'timestamp': Timestamp.now(),
                                          })
                                          .whenComplete(() {
                                            updateProductRating(productId);
                                            Navigator.of(context).pop();
                                            _reviewController.clear();
                                            rating = 0;
                                             ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                backgroundColor: Colors.grey
                                                    .withOpacity(.8),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                duration: Duration(seconds: 1),
                                                content: Text(
                                                  'Review Added',
                                                  style: GoogleFonts.lato(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: Text(
                                      'Submit',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3C55EF),
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.w,
                          vertical: 10.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        'Review',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
