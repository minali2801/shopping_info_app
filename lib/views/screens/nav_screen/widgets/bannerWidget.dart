import 'dart:convert';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:get/get_state_manager/src/simple/get_widget_cache.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('banners').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.size == 0) {
          return Center(child: Text('No banners available'));
        }
       List<DocumentSnapshot> banners = snapshot.data!.docs;
        return CarouselSlider(
          items:
              banners.map((doc) {
                String imageString = doc["imageBase64"];
                Uint8List imageBytes = base64Decode(imageString);
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child:Container(
                    decoration: BoxDecoration(
                     boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 15.r,
                        spreadRadius: 2.r,
                        offset: Offset(1,5)
                      )
                     ]
                    ),
                    child: Image.memory(
                      imageBytes , 
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            options: CarouselOptions(
            height: 210.0.h,
            autoPlay: true,
            autoPlayInterval: Duration(seconds:3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            viewportFraction: 0.9,
            scrollPhysics: const BouncingScrollPhysics(),
            pauseAutoPlayOnTouch: true,
            aspectRatio: 16/9,
          ),
        );
      },
    );
  }
}
