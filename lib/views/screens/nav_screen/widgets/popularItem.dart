import 'package:appforhelp/views/screens/inner_screen/product_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PopulartItem extends StatelessWidget {
  const PopulartItem({
    super.key,
    required this.productData,
  });

  final QueryDocumentSnapshot<Object?> productData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailScreen(productData: productData)));
          },
          child: SizedBox(
            width: 110,
            
            child: Column(
              
              mainAxisSize:MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    width: 87,
                    height: 81,
                    decoration: BoxDecoration(
                      color: Color(0xFFB0CCFF),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Image.asset('assets/images/pen.png',width: 71,height: 71,fit: BoxFit.cover,),
                  ),
                ),
                SizedBox(height: 8,),
                Column(
                  mainAxisSize: MainAxisSize.min,
                   crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('\$${productData['productPrice']}',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 17,
                      letterSpacing: 0.4,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
                  ],
                ),
                Text(productData['productName'],style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),),
                Text('Discount:\$${productData['discount']}',
                style: TextStyle(
                  color: Colors.red.withOpacity(.8)
                ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}