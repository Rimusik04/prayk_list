import 'package:flutter/material.dart';
import '/models/product.dart';


class Authori extends StatefulWidget {


  @override
  State<Authori> createState() => _AuthoriState();
}

class _AuthoriState extends State<Authori> {
  @override
  
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Column(children:[
            Text("Registration")
          ]),
        ),
      ),
      body: 
      SingleChildScrollView(
        
      )
    );
  }
}

