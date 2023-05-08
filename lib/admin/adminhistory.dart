import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:intl/intl.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
@override
class adminhtry extends StatefulWidget {
  const adminhtry({Key? key}) : super(key: key);
  @override
  State<adminhtry> createState() => _adminhtryState();
}
class _adminhtryState extends State<adminhtry> {
  @override
  bool isHTML = false;
  String sts='Accepted';
  var updatests=['Accepted','Initiated','Rejected'];
  final  fromdateController= TextEditingController();
  final  todateController =TextEditingController();
  Query dbRef = FirebaseDatabase.instance.ref().child('REQUEST');
  DatabaseReference dbref2 = FirebaseDatabase.instance.ref().child('REQUEST');
  Widget listItem({required Map request}) {
    return SingleChildScrollView(
      child: request['STATUS']=="Initiated"?null:Container(
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
            SizedBox(height: 6,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
            Container(
              height: 30,
              width: 120,
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromRGBO(77, 0, 114, 1),
              ),
              child: Row(
                children: [
                  if(request['STATUS'] == "Accepted")
                    approvededicon(),
                  if(request['STATUS'] == "Rejected")
                    rejectedicon(),

                ],
              ),
            ),
                InkWell(
                    child: Text("Edit status",style: TextStyle(decoration:TextDecoration.underline,fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1),),),
                  onTap: (){
                    showDialog(context: context, builder: (context)
                    {
                      return AlertDialog(
                        title: Text("Change status", style: TextStyle(
                            fontFamily: 'Arimo',
                            color: Color.fromRGBO(8, 47, 72, 1),
                            fontWeight: FontWeight.bold)),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              TextFormField(
                                controller: fromdateController,
                                keyboardType: TextInputType.phone,
                                autofocus: false,
                                style: TextStyle(fontFamily: 'Arimo'),
                                onTap: () async {
                                  DateTime ? pickdate2 = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime(2050));
                                  if (pickdate2 != null) {
                                    setState(() {
                                      fromdateController.text =
                                          DateFormat('dd-MM-yyyy').format(
                                              pickdate2);
                                    });
                                  };
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please select FROM date");
                                  }

                                  return null;
                                },
                                onSaved: (value) {
                                  fromdateController.text = value!;
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.date_range,
                                    color: Color.fromRGBO(77, 0, 114, 1),),
                                  suffixIcon: Icon(Icons.arrow_drop_down,
                                    color: Color.fromRGBO(77, 0, 114, 1),),
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20, 15, 20, 15),
                                  hintText: "From date",
                                  hintStyle: TextStyle(fontFamily: 'Arimo'),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: todateController,
                                keyboardType: TextInputType.phone,
                                style: TextStyle(fontFamily: 'Arimo'),
                                onTap: () async {
                                  DateTime ? pickdate2 = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime(2050));
                                  if (pickdate2 != null) {
                                    setState(() {
                                      todateController.text =
                                          DateFormat('dd-MM-yyyy').format(
                                              pickdate2);
                                    });
                                  };
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("Please select TO date");
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  todateController.text = value!;
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.date_range,
                                    color: Color.fromRGBO(77, 0, 114, 1),),
                                  suffixIcon: Icon(Icons.arrow_drop_down,
                                    color: Color.fromRGBO(77, 0, 114, 1),),
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20, 15, 20, 15),
                                  hintText: "To date",
                                  hintStyle: TextStyle(fontFamily: 'Arimo'),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                                    labelText: "Status",
                                    labelStyle: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1)),
                                  ),
                                  value: '${request['STATUS']}',
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: updatests.map((String yesorno2){
                                    return DropdownMenuItem(
                                      value:yesorno2,
                                      child:Text(yesorno2,style: TextStyle(fontWeight: FontWeight.w900,fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1),fontSize: 15)),
                                    );
                                  }).toList(),
                                  onChanged:(String? newValue2){
                                    setState(() {
                                      sts=newValue2!;
                                    });
                                  }
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
                                (fromdateController.text.length==0)?
                                (dbref2.child(request['key']).update({'FROM DATE':request['FROM DATE']})):(dbref2.child(request['key']).update({'FROM DATE':fromdateController.text.toString()}));
                                  (todateController.text.length==0)?
                            dbref2.child(request['key']).update({'TO DATE':request['TO DATE']}):(dbref2.child(request['key']).update({'TO DATE':todateController.text.toString()}));
                                  dbref2.child(request['key']).update({'STATUS':sts.toString()});
                                  send('Alloted venue details has been changed, CLASS NAME: ${request['CLASS NAME']} FROM DATE: ${request['FROM DATE']}  TO DATE: ${request['TO DATE']} STATUS:${sts}','Changes in alloted venue - Reg ', request['MAIL ID']);
                                  Navigator.of(context).pop();
                          },
                              child: const Text('Alter', style: TextStyle(
                                  fontFamily: 'Arimo',
                                  color: Color.fromRGBO(8, 47, 72, 1),
                                  fontWeight: FontWeight.bold)))
                        ],
                      );
                    }
                    );
                  },
                ),
          ],
            ),
        ]
        ),
      ),
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


  Row approvededicon() {
    return Row(
      children: [
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

  Row rejectedicon() {
    return Row(
      children: [
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