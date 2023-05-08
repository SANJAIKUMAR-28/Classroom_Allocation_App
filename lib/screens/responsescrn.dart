import 'package:flutter/material.dart';

class response extends StatefulWidget {
  const response({Key? key}) : super(key: key);

  @override
  State<response> createState() => _responseState();
}

class _responseState extends State<response> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100,
            child: Icon(Icons.check_circle_outline,color: Color.fromRGBO(77,0,114,1),size: 100,)
            ),
            SizedBox(height: 6,),
            Text('Successfull',style: TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text('Request has been initiated !!',style: TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.bold),)

          ],
        ),
      ),

    );
  }
}
