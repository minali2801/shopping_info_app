import 'package:appforhelp/controller/imagePickForCaterory.dart';
import 'package:appforhelp/controller/imagePickforFirebaseStore.dart';
//import 'package:appforhelp/views/screens/nav_screen/widgets/bannerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width.w,
      height: 130.h,
      child: Stack(
        children: [
          Image.asset(
            'assets/images/searchBanner2.jpg',
            width: MediaQuery.of(context).size.width.w,
            height:130.h,
            fit: BoxFit.cover,
            ),
            Positioned(
             left:34,
             top:70,
             child:Container(
              width: 250.w,
              height: 45.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4.r,
                    offset: Offset(0, 2),
                  ),
                ]
              ),
              child:TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Text',
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12),
                  prefixIcon: Image.asset(
                    'assets/images/SearchIcon2.png',
                    scale: 18,
                    ),
                  suffixIcon: Image.asset('assets/images/icons8-camera-100.png',
                  scale: 3.5,
                  
                  // width: 5,
                  // height:5,
                  ),
                  filled: true,
                  fillColor:Color(0xFFF5F5F5),
                  focusColor: Colors.white,
                ),
              ),
              ),
              ),
            Positioned(
              left: 312,
              top:78,
              child:Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => StoreImageToFirestoState()));
                  },
                  overlayColor: WidgetStateProperty.all(
                    const Color(0x000c7f7f),
                  ),
                  child: Ink(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:AssetImage("assets/images/bell2.png",
                        ),
                        ),
                       ),
                  ),
                ),
              ),
              ),
              Positioned(
                left: 358,
                top: 78,
                child:Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryImageAndNamePick()));
                    },
                    overlayColor: WidgetStateProperty.all(
                      const Color(0x000c7f7f),
                    ),
                    child: Ink(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:AssetImage("assets/images/msg0.png"),
                          ),
                      ),
                    ),
                  ),
                ) )
        ],
      ),

    );
  }
}