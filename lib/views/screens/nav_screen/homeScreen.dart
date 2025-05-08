import 'package:appforhelp/views/screens/nav_screen/widgets/bannerWidget.dart';
import 'package:appforhelp/views/screens/nav_screen/widgets/category_item.dart';
import 'package:appforhelp/views/screens/nav_screen/widgets/headerWidget.dart';
import 'package:appforhelp/views/screens/nav_screen/widgets/recomended_product_widget.dart';
import 'package:appforhelp/views/screens/nav_screen/widgets/reuseble_text_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor:Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: BannerWidget(),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8,left: 8,right: 8),
              child: CategoryItem(),
            ),
            ReusebleTextWidget(title: 'Recommended for you', subtitle: 'View all'),
            RecomendedProductWidget(),
            ReusebleTextWidget(title: 'Popular Product', subtitle: 'View all'),
            ],
        ),
      ),
    );
  }
}