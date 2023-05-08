import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart' as db;
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newlogin/model/user_model.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
class historyuser extends StatefulWidget {
  const historyuser({Key? key}) : super(key: key);

  @override
  State<historyuser> createState() => _historyuserState();
}

class _historyuserState extends State<historyuser> {
  @override
  final complaintcontroller= TextEditingController();
  User? user=FirebaseAuth.instance.currentUser;
  UserModel loggedInUser=UserModel();
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
      child: (request['STATUS']=="Accepted"&&request['FACULTY NAME']==loggedInUser.firstname)?Container(
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
            SizedBox(height: 5,),
           if(request['ALTERNATE']=='1')
            Row(
              children: [
                Text('Reason:', style: TextStyle(fontSize: 17,
                    fontFamily: 'Arimo',
                    fontWeight: FontWeight.bold),),
                SizedBox(width: 5,),
                Flexible(
                  child:
                  Text(
                    request['REASON'],
                    style: TextStyle(fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Arimo'),
                  ),
                ),

              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Text(''),
            InkWell(
              child: Text("Raise a complaint",style: TextStyle(decoration:TextDecoration.underline,fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1),),),
              onTap: (){
                showDialog(context: context, builder: (context)
                {
                  return AlertDialog(
                    title: Text("Raise complaint", style: TextStyle(
                        fontFamily: 'Arimo',
                        color: Color.fromRGBO(8, 47, 72, 1),
                        fontWeight: FontWeight.bold)),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          TextFormField(
                            maxLines: null,
                            autofocus: false,
                            controller: complaintcontroller,
                            style: TextStyle(fontFamily: 'Arimo'),
                            keyboardType: TextInputType.text,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,

                            onSaved: (value)
                            {
                              complaintcontroller.text=value!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(10,15,10,50),
                              hintText: "Enter your complaints",
                              hintStyle: TextStyle(fontFamily: 'Arimo'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(onPressed: () {
                        Navigator.of(context).pop();
                      },
                          child: const Text('No', style: TextStyle(
                              fontFamily: 'Arimo',
                              color: Color.fromRGBO(8, 47, 72, 1),
                              fontWeight: FontWeight.bold))),
                      TextButton(
                          onPressed: () {
                            if(complaintcontroller.text.length!=0){
                            send(complaintcontroller.text.toString(), 'Complaint raised about alloted venue (${request['CLASS NAME']}) - Reg', 'jashwanthkumar.ad21@bitsathy.ac.in');}
                            Navigator.of(context).pop();
                          },
                          child: const Text('Send', style: TextStyle(
                              fontFamily: 'Arimo',
                              color: Color.fromRGBO(8, 47, 72, 1),
                              fontWeight: FontWeight.bold)))
                    ],
                  );
                }
                );
              },
            ),
                ]
            )
          ],
        ),
      ):null,
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("HISTORY", style: TextStyle(
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
            itemBuilder: (BuildContext context, db.DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map request = snapshot.value as Map;
              request['key'] = snapshot.key;
              return listItem(request: request);
            },
          ),
        )
    );
  }
  Future<void> send(String body,String subject,String reciptent,) async {
    final Email email = Email(
      body: body,
      subject: subject,
      recipients:[reciptent],
      isHTML: false,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }
}
