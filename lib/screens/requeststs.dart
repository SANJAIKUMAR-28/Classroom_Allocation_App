import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart' as db;
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newlogin/model/user_model.dart';

class requeststatus extends StatefulWidget {
  const requeststatus({Key? key,}) : super(key: key);
  @override
  State<requeststatus> createState() => _requeststatusState();
}
class _requeststatusState extends State<requeststatus> {
  User? user=FirebaseAuth.instance.currentUser;
  UserModel loggedInUser=UserModel();
  String sts="Initiated";
  Color stscolor=Colors.yellowAccent;
  void stsfunc(){
    sts="Approved";
    stscolor=Colors.white;
  }
  db.Query dbRef = db.FirebaseDatabase.instance.ref().child('REQUEST');
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
  Widget listItem({required Map request}) {
    return SingleChildScrollView(
      child:
      (request['FACULTY NAME']==loggedInUser.firstname)?
      Container(
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
            Text(request['CLASS NAME'],style: TextStyle(fontSize: 20,fontFamily: 'Arimo',fontWeight: FontWeight.bold),),
            SizedBox(height: 6,),
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
              children:[
                Text('From date:',style: TextStyle(fontSize: 17,fontFamily: 'Arimo',fontWeight: FontWeight.bold),),
                SizedBox(width: 5,),
                Row(
                  children:[
                    Text(
                      request['FROM DATE'],
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,fontFamily: 'Arimo'),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      request['FROM TIME'],
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900,fontFamily: 'Arimo',),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children:[
                Text('To date:',style: TextStyle(fontSize: 17,fontFamily: 'Arimo',fontWeight: FontWeight.bold),),
                SizedBox(width: 5,),
                Row(
                  children:[
                    Text(
                      request['TO DATE'],
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,fontFamily: 'Arimo'),
                    ), SizedBox(width: 5,),
                    Text(
                      request['TO TIME'],
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900,fontFamily: 'Arimo'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5,),
            if(request['STATUS']=="Rejected")
            Row(
              children: [
                Text('Remarks:', style: TextStyle(fontSize: 17,
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.bold),),
                SizedBox(width: 5,),
                Text(
                  request['REMARKS'],
                  style: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Arimo'),
                ),
              ],
            ),
            SizedBox(height: 6,),
            Container(
              height: 30,
              width: 120,
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(77,0,114,1),
              ),
              child: Row(
                children:[
                  if(request['STATUS']=="Initiated")
                      initiatedicon(),
                  if(request['STATUS']=="Accepted")
                      approvededicon(),
                  if(request['STATUS']=="Rejected")
                      rejectedicon(),

              ],
              ),
            ),
          ],
        ),
      ): null,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("REQUEST STATUS",style: TextStyle(fontFamily: 'Arimo',color: Colors.white,fontSize:15,fontWeight: FontWeight.bold),),
          centerTitle: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20),),),
        ),
        body:
        Container(
          height: double.infinity,
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, db.DataSnapshot snapshot, Animation<double> animation, int index) {
              Map request = snapshot.value as Map;
              request['key'] = snapshot.key;
              return listItem(request: request);

            },
          ),
        )
    );
  }
  Row initiatedicon(){
    return Row(
      children:[
    Icon(Icons.history_toggle_off, color: Colors.yellow, size: 20,),
    SizedBox(width: 5,),
    Text(sts, textAlign: TextAlign.center,
    style: TextStyle(fontSize: 15,
    fontWeight: FontWeight.bold,
    fontFamily: 'Arimo',
    color: Colors.yellow))
    ],
    );
  }
  Row approvededicon(){
    return Row(
      children:[
        Icon(Icons.check, color: Colors.green, size: 20,),
        SizedBox(width: 5,),
        Text('Approved', textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: 'Arimo',
                color: Colors.green))
      ],
    );
  }
  Row rejectedicon(){
    return Row(
      children:[
        Icon(Icons.close, color: Colors.red, size: 20,),
        SizedBox(width: 5,),
        Text('Rejected', textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: 'Arimo',
                color: Colors.red))
      ],
    );
  }
}
