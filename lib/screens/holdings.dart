import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';

class holdings extends StatefulWidget {
  final String clsname;
  const holdings({Key? key, required this.clsname}) : super(key: key);

  @override
  State<holdings> createState() => _holdingsState();
}

class _holdingsState extends State<holdings> {
  Query dbRef = FirebaseDatabase.instance.ref().child('REQUEST');
  Widget listItem({required Map request}) {
    return SingleChildScrollView(
      child: ((request['STATUS']=='Accepted'&&request['CLASS NAME']==widget.clsname&& ((date(request['FROM DATE'])==DateTime.now().month&&day(request['FROM DATE'])>=DateTime.now().day)||(request['CLASS NAME']==widget.clsname&& date(request['FROM DATE'])>DateTime.now().month))))?Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromRGBO(242, 232, 255, 1),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(request['CLASS NAME'], style: TextStyle(fontSize: 25,
                fontFamily: 'Arimo',
                fontWeight: FontWeight.bold),),
            SizedBox(height: 6,),
            Row(
              children: [
                Text('Faculty Name:', style: TextStyle(fontSize: 17,
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.bold),),
                SizedBox(width: 5,),
                Row(
                  children: [
                    Text(
                      request['FACULTY NAME'],
                      style: TextStyle(fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Arimo'),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      request['LAST NAME'],
                      style: TextStyle(fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Arimo'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Text('Number of students:', style: TextStyle(fontSize: 17,
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.bold),),
                SizedBox(width: 5,),
                Text(
                  request['NO OF STUDENTS'],
                  style: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Arimo'),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text('From date:', style: TextStyle(fontSize: 17,
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.bold),),
                SizedBox(width: 5,),
                Row(
                  children: [
                    Text(
                      request['FROM DATE'],
                      style: TextStyle(fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Arimo'),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      request['FROM TIME'],
                      style: TextStyle(fontSize: 16,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Arimo',),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text('To date:', style: TextStyle(fontSize: 17,
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.bold),),
                SizedBox(width: 5,),
                Row(
                  children: [
                    Text(
                      request['TO DATE'],
                      style: TextStyle(fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Arimo'),
                    ), SizedBox(width: 5,),
                    Text(
                      request['TO TIME'],
                      style: TextStyle(fontSize: 16,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Arimo'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Text('Description:', style: TextStyle(fontSize: 17,
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.bold),),
                SizedBox(width: 5,),
                Flexible(
                  child:
                  Text(
                    request['DESCRIPTION'],
                    style: TextStyle(fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Arimo'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ):null,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("HOLDINGS", style: TextStyle(
            fontFamily: 'Arimo',
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold),),
          centerTitle: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),),),
        ),
        body: Container(
          height: double.infinity,
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map request = snapshot.value as Map;
              request['key'] = snapshot.key;
              return listItem(request: request);
            },
          ),
        )
    );
  }
  int date(String date){
    final Date = date;
    String slice= Date.substring(3,5) ;
    var num=int.parse(slice);
    return num;
  }
  int day(String day){
    final Day = day;
    String slice= Day.substring(0,2) ;
    var num1=int.parse(slice);
    return num1;
  }
}
