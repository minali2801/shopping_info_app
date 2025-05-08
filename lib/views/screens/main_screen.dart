import 'package:appforhelp/views/screens/nav_screen/accountScreen.dart';
import 'package:appforhelp/views/screens/nav_screen/bottonNavItem.dart';
import 'package:appforhelp/views/screens/nav_screen/cartScreen.dart';
import 'package:appforhelp/views/screens/nav_screen/favoriteScreen.dart';
import 'package:appforhelp/views/screens/nav_screen/homeScreen.dart';
import 'package:appforhelp/views/screens/nav_screen/stroreScreen.dart';
//import 'package:appforhelp/views/screens/rivermodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart';

//import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class MainScreen extends StatefulWidget {
   const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<SMIBool> riveIconInputs = [];
  List<StateMachineController?> controllers = [];
  int selectedNavIndex = 0;
  List<Widget> pages = [
       HomeScreen(),
       CartScreen(),
       FavoriteScreen(),
       StoreScreen(),
       AccountScreen(),
  ];

  // void animateTheIcon(int index) {
  //   riveIconInputs[index].change(true);
  //   Future.delayed(
  //      Duration(seconds: 1), 
  //       () {
  //     riveIconInputs[index].change(false);
  //   });
  // }

      void animateTheIcon(int index) {
      bottomNavItems[index].rive.triggerAnimation();
     }
      void riveOnInIt (Artboard artboard, {required String stateMachineName,required int index}) {
      final controller = StateMachineController.fromArtboard(
        artboard,
        stateMachineName,
      );
      if(controller == null ) return ;
      artboard.addController(controller);
      final input = controller.findInput<bool>('active') as SMIBool?;
      bottomNavItems[index].rive.setInput(input!);
      }
  // void riveOnInIt(Artboard artboard, {required String stateMachineName}) {
  //   StateMachineController? controller = StateMachineController.fromArtboard(
  //     artboard,
  //     stateMachineName,
  //   );
  //    if (controller == null ) return ;
  //   artboard.addController(controller);
  //   controllers.add(controller);

  //   riveIconInputs.add(controller.findInput<bool>('active') as SMIBool);
  // }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedNavIndex],
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding:  EdgeInsets.only(bottom: 20.h),
          child: Container(
            padding:  EdgeInsets.all(12.h),
            // height: 58,
            margin:  EdgeInsets.symmetric(horizontal: 24.h),
            decoration: BoxDecoration(
              color: Color(0xFF17203A).withOpacity(0.8),
              borderRadius:  BorderRadius.all(Radius.circular(24.r)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF17203A).withOpacity(0.3),
                  offset:  Offset(0, 18),
                  blurRadius: 30.r,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                bottomNavItems.length, (index) {
                final riveIcon = bottomNavItems[index].rive;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedNavIndex = index;
                    });
                    animateTheIcon(index);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 25.h,
                        width: 25.w,
                        child: Opacity(
                          opacity: selectedNavIndex == index ? 1 : 0.8,
                          child: RiveAnimation.asset(
                            riveIcon.src,
                            artboard: riveIcon.artboard,
                            onInit: (artboard) {
                              riveOnInIt(
                                artboard,
                                stateMachineName: riveIcon.stateMachineName,
                                index: index,
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      AnimatedBar(isActive: selectedNavIndex == index),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedBar extends StatelessWidget {
   const AnimatedBar({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration:  Duration(milliseconds: 200),
      margin:  EdgeInsets.only(bottom: 2.h),
      height: 4.h,
      width: isActive ? 20.w : 0,
      decoration: BoxDecoration(
        color: Color(0xFF81B4FF),
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
      ),
    );
  }
}
