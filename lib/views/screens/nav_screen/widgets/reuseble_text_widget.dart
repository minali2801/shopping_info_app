import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusebleTextWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const ReusebleTextWidget({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.5.r),
          boxShadow: [
            BoxShadow(
              offset: Offset(1,1),
              blurRadius:2.0.r,
              color: Colors.black.withOpacity(0.1),
            ),
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: GoogleFonts.roboto(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
            ),
            Text(subtitle,style: GoogleFonts.roboto(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              decoration: TextDecoration.underline,          
            ),
            ),
          ],
        ),
      ),
    );
  }
}