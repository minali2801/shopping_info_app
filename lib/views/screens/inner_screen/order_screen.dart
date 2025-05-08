import 'package:appforhelp/views/screens/inner_screen/order_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

    
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final Stream<QuerySnapshot> orderStream =
        FirebaseFirestore.instance
            .collection('orders')
            .where('buyerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.15.h,
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
                Colors.black.withOpacity(0.3),
                BlendMode.darken,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
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
                    'My Order',
                    style: GoogleFonts.poppins(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.5,
                      shadows: [
                        Shadow(
                          color: Colors.black45,
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
      body:StreamBuilder<QuerySnapshot>(
  stream: orderStream,
  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasError) {
      return Center(child: Text('Something went wrong'));
    }
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }
    if(snapshot.data!.docs.isEmpty){
      return Center(child: Text('You have no order yet !',style: GoogleFonts.lato(
        fontSize: 18.sp,
        fontWeight: FontWeight.w800,
        color: Colors.black,
      ),));
    }
    final orders = snapshot.data!.docs;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        final status = order['delivered'] == true
            ? 'Delivered'
            : order['processing'] == true
                ? 'Processing'
                : 'Cancelled';
    
        final statusColor = order['delivered'] == true
            ? const Color(0xFF3C55EF)
            : order['processing'] == true
                ? Colors.transparent // For gradient styling
                : Colors.red;
    
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderDetailScreen(order: order)));
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        child: Image.asset('assets/images/pen.png', fit: BoxFit.contain),
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Processing badge below image
                    if (status == 'Processing')
                      Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                            width: 18.w,
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.purpleAccent, Colors.deepPurple],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple.withOpacity(0.3),
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Text(
                              'Processing',
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order['productName'],
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    const SizedBox(height: 4),
                      Text(
                        order['category'],
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${order['price']}',
                        style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Other statuses below product info
                      if (status != 'Processing')
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            status,
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () async{
                    await firestore.collection('orders').doc(order['orderId']).delete();
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('order${order['productName']} delete')));
                  },
                  child: Image.asset(
                    'assets/images/dd1.png',
                    width: 20.w,
                    height: 20.h,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  },
),

    );
  }
}
