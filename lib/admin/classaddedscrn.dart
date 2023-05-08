import 'package:flutter/material.dart';

class classadded extends StatefulWidget {
  const classadded({Key? key}) : super(key: key);

  @override
  State<classadded> createState() => _classaddedState();
}

class _classaddedState extends State<classadded> {
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
            Text('New class has been added !!',style: TextStyle(fontFamily: 'Arimo',fontWeight: FontWeight.bold),)

          ],
        ),
      ),

    );
  }
}
