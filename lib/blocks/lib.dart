import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:newlogin/screens/newdetails.dart';

class lib extends StatefulWidget {
  const lib({Key? key}) : super(key: key);

  @override
  State<lib> createState() => _libState();
}

class _libState extends State<lib> {
  @override
  Query dbRef = FirebaseDatabase.instance.ref().child('LIBCLASS');
  Widget listItem({required Map request}) {
    return SingleChildScrollView(
      child:Padding(
        padding: EdgeInsets.only(left:20,top:6,right: 20,bottom: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if(request['CLASS-TYPE']=='Conference Hall')
              conferencehall(request['CLASS-NAME'], request['STRENGTH'], request['SPEAKER-PROJECTOR'], request['COMPUTER'],request['FLOOR']),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("LIBRARY",style: TextStyle(fontFamily: 'Arimo',color: Colors.white,fontSize:15,fontWeight: FontWeight.bold),),
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20),),),
      ),
      body: FirebaseAnimatedList(
        query: dbRef,
        itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {

          Map request = snapshot.value as Map;
          request['key'] = snapshot.key;

          return listItem(request: request);
        },
      ),
    );
  }
  Material conferencehall(String classnum1,String strength1,String speakerAndprojector1,String ac1,String floor) {
    return Material(
      elevation: 4,
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10,15,10,15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>newdetail(name1:classnum1,totalstrength: strength1,)));

        },
        child: Row(
          children: [
            SizedBox(height: 100,width: 130,
              child: Image.asset('assets/confhall.png',),
            ),
            SizedBox(width: 5,),
        Flexible(child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text(classnum1,style: TextStyle(fontWeight: FontWeight.w900,fontFamily: 'Arimo',color: Colors.black,fontSize: 15),),
                SizedBox(height: 5,),
                Row(
                  children:[
                    Text('Strength:',style: TextStyle(fontWeight: FontWeight.normal,fontFamily: 'Arimo',color: Colors.black,fontSize: 10),),
                    SizedBox(width: 5,),
                    Text(strength1,style: TextStyle(fontWeight: FontWeight.normal,fontFamily: 'Arimo',color: Colors.black,fontSize: 10),),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children:[
                    Text('Speaker/projector:',style: TextStyle(fontWeight: FontWeight.normal,fontFamily: 'Arimo',color: Colors.black,fontSize: 10),),
                    SizedBox(width: 5,),
                    Text(speakerAndprojector1,style: TextStyle(fontWeight: FontWeight.normal,fontFamily: 'Arimo',color: Colors.black,fontSize: 10),),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children:[
                    Text('Computer:',style: TextStyle(fontWeight: FontWeight.normal,fontFamily: 'Arimo',color: Colors.black,fontSize: 10),),
                    SizedBox(width: 5,),
                    Text(ac1,style: TextStyle(fontWeight: FontWeight.normal,fontFamily: 'Arimo',color: Colors.black,fontSize: 10),),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text('Floor:', style: TextStyle(fontWeight: FontWeight.normal,
                        fontFamily: 'Arimo',
                        color: Colors.black,
                        fontSize: 10),),
                    SizedBox(width: 5,),
                    Text(floor, style: TextStyle(fontWeight: FontWeight.normal,
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
