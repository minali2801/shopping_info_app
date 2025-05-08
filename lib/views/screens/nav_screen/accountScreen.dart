import 'package:appforhelp/views/screens/inner_screen/order_screen.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:TextButton(onPressed: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=> OrderScreen()));
      }, child: Text('My oder'))),
    );
  }
}