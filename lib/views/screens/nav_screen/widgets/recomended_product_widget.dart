import 'package:appforhelp/views/screens/nav_screen/widgets/product_item_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecomendedProductWidget extends StatefulWidget {
  const RecomendedProductWidget({super.key});

  @override
  State<RecomendedProductWidget> createState() => _RecomendedProductWidgetState();
}
class _RecomendedProductWidgetState extends State<RecomendedProductWidget> {
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance.collection('products').snapshots(); 
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: _productStream, 
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.hasError) {
            return  const Text('somthing went wrong');
          } 
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return  SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index) {
                final productData = snapshot.data!.docs[index];
                return ProductItemWidget(productData: productData,);
              }),
          );
         
        }),
    );
  }
}