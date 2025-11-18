import 'package:flutter/material.dart';


class Authori extends StatefulWidget {


  @override
  State<Authori> createState() => _AuthoriState();
}

class _AuthoriState extends State<Authori> {
  @override
  
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Column(children:[
            Text("Registration")
          ]),
        ),
      ),
      body: 
      Center(
        child: Column(
          children: [
            Text("Write your E-mail."),
            TextField(),
            Row(children: [
              Text("I accept with all rulse"),
              SizedBox(),
              // Checkbox(value: , onChanged: onChanged)
            ],),
            ElevatedButton(
                    onPressed: () {
                     
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      // side:isPressed ? BorderSide(color: Colors.red, width: 1):BorderSide(color: Colors.grey, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Done'),
                  ),
            
          ],
        ),
        
      )
    );
  }
}

