import 'package:flutter/material.dart';

import '../classdetails.dart';

class adminaudi extends StatefulWidget {
  const adminaudi({Key? key}) : super(key: key);

  @override
  State<adminaudi> createState() => _adminaudiState();
}

class _adminaudiState extends State<adminaudi> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("AUDITORIUMS",style: TextStyle(fontFamily: 'Arimo',color: Colors.white,fontSize:15,fontWeight: FontWeight.bold),),
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20),),),
      ),
      body: SingleChildScrollView(
        child:Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 6,),
              auditoriumhall('MAIN AUDITORIUM', '1000','Yes','Yes'),
              SizedBox(height: 6,),
              auditoriumhall('VEDNAYAGAM AUDITORIUM', '500','Yes','Yes'),
            ],
          ),
        ),
      ),
    );
  }
  Material auditoriumhall(String classnum1,String strength1,String speakerAndprojector1,String ac1) {
    return Material(
      elevation: 4,
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
        minWidth: MediaQuery
            .of(context)
            .size
            .width,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>classdetails(clsname: classnum1)));
        },
        child: Row(
          children: [
            SizedBox(height: 100, width: 130,
              child: Image.asset('assets/audiimg.png',),
            ),
            SizedBox(width: 5,),
            Flexible(child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(classnum1,style: TextStyle(fontWeight: FontWeight.w900,
                    fontFamily: 'Arimo',
                    color: Colors.black,
                    fontSize: 15),),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text('Strength:', style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Arimo',
                        color: Colors.black,
                        fontSize: 10),),
                    SizedBox(width: 5,),
                    Text(strength1, style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Arimo',
                        color: Colors.black,
                        fontSize: 10),),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text('Speaker/projector:', style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Arimo',
                        color: Colors.black,
                        fontSize: 10),),
                    SizedBox(width: 5,),
                    Text(speakerAndprojector1, style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Arimo',
                        color: Colors.black,
                        fontSize: 10),),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text('AC:', style: TextStyle(fontWeight: FontWeight.normal,
                        fontFamily: 'Arimo',
                        color: Colors.black,
                        fontSize: 10),),
                    SizedBox(width: 5,),
                    Text(ac1, style: TextStyle(fontWeight: FontWeight.normal,
                        fontFamily: 'Arimo',
                        color: Colors.black,
                        fontSize: 10),),
                  ],
                ),
              ],
            ),
            ),
          ],
        ),
      ),
    );
  }
}
