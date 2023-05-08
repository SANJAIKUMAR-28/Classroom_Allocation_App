import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'adminholdings.dart';

class approval extends StatefulWidget {
  const approval({Key? key}) : super(key: key);
static const String status ='initiated';
  @override
  State<approval> createState() => _approvalState();
}
class _approvalState extends State<approval> {
  @override
  Query dbRef = FirebaseDatabase.instance.ref().child('REQUEST');
  Query dbRef2= FirebaseDatabase.instance.ref().child('HISTORY');
  DatabaseReference dbref3=FirebaseDatabase.instance.ref().child('REQUEST');
  DatabaseReference dbref4=FirebaseDatabase.instance.ref().child('HISTORY');
  String sts="Approved";
  final  strengthController = new TextEditingController();
  final remarks1= new TextEditingController();
  final remarks= new TextEditingController();

  Widget listItem({required Map request}) {
    return SingleChildScrollView(
      child:(request['VALUE']=='1')?Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromRGBO(242, 232, 255, 1),
        ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:[
          Flexible(child:
          Text(request['CLASS NAME'],style: TextStyle(fontSize: 25,fontFamily: 'Arimo',fontWeight: FontWeight.bold),),),
        InkWell(
          child: Icon(Icons.edit,size:25,color: Color.fromRGBO(77,0,114,1),),
          onTap: (){
            showDialog(context: context, builder: (context)
            {
              return AlertDialog(
                title: Text("Alternate Venue", style: TextStyle(
                    fontFamily: 'Arimo',
                    color: Color.fromRGBO(8, 47, 72, 1),
                    fontWeight: FontWeight.bold)),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      TextFormField(
                        controller: strengthController,
                        style: TextStyle(fontFamily: 'Arimo',),
                        keyboardType: TextInputType.text,
                        onSaved: (value)
                        {
                          if(value==null){
                            strengthController.text=request['CLASS NAME'];
                          }
                          if(value!=null){
                            strengthController.text=value;}
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                          hintText: "${request['CLASS NAME']}",
                          hintStyle: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1)),
                        ),
                      ),
                      TextFormField(
                        controller: remarks1,
                        maxLines: null,
                        style: TextStyle(fontFamily: 'Arimo',),
                        keyboardType: TextInputType.text,
                        onSaved: (value)
                        {
                          remarks1.text=value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                          hintText: "Reason",
                          hintStyle: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1)),
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
                  TextButton(onPressed: () {
                    dbref3.child(request['key']).update({'CLASS NAME':strengthController.text.toUpperCase()});
                    dbref3.child(request['key']).update({'ALTERNATE':'1'});
                    dbref3.child(request['key']).update({'REASON':remarks1.text.toString()});
                    Navigator.of(context).pop();
              },
                      child: const Text('Change', style: TextStyle(
                          fontFamily: 'Arimo',
                          color: Color.fromRGBO(8, 47, 72, 1),
                          fontWeight: FontWeight.bold)))
                ],
              );
            });
          },
        )
      ]
      ),
          SizedBox(height: 6,),
          Row(
            children:[
              Text('Faculty Name:',style: TextStyle(fontSize: 16,fontFamily: 'Arimo',fontWeight: FontWeight.bold),),
              SizedBox(width: 5,),
              Row(
                children:[
              Text(
                request['FACULTY NAME'],
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,fontFamily: 'Arimo'),
              ),
                  SizedBox(width: 5,),
                  Text(
                    request['LAST NAME'],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,fontFamily: 'Arimo'),
                  ),
        ],
      ),
            ],
          ),
          SizedBox(height: 5,),
          Row(
            children:[
              Text('Number of students:',style: TextStyle(fontSize: 16,fontFamily: 'Arimo',fontWeight: FontWeight.bold),),
              SizedBox(width: 5,),
          Text(
            request['NO OF STUDENTS'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,fontFamily: 'Arimo'),
          ),
        ],
      ),
          SizedBox(
            height: 5,
          ),
      Row(
        children:[
          Text('From date:',style: TextStyle(fontSize: 16,fontFamily: 'Arimo',fontWeight: FontWeight.bold),),
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
              Text('To date:',style: TextStyle(fontSize: 16,fontFamily: 'Arimo',fontWeight: FontWeight.bold),),
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
          Row(
            children:[
              Text('Description:',style: TextStyle(fontSize: 16,fontFamily: 'Arimo',fontWeight: FontWeight.bold),),
         SizedBox(width: 5,),
         Flexible(
           child:
         Text(
            request['DESCRIPTION'],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,fontFamily: 'Arimo'),
          ),
         ),
      ],
    ),
          SizedBox(height: 2,),
        InkWell(
          child:Padding(
            padding: EdgeInsets.only(left:190),
            child: Text("Check availability",style: TextStyle(decoration:TextDecoration.underline,fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1),),),
          ),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>adminholdings(clsname: request['CLASS NAME'], frmdate: request['FROM DATE'], todate: request['TO DATE'],)));
          },
        ),
          SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(5),
                color: Color.fromRGBO(0,136,34,1),
                child:MaterialButton(
                  height: 20,
                minWidth: 150,
                splashColor: Colors.black.withOpacity(0.1),
                onPressed: () {
                    if(request['CLASS NAME']==request['CLASS NAME'] && request['STATUS']=='Accepted' && request['VALUE']=='2'){
                      showDialog(context: context, builder: (context)
                      {
                        return AlertDialog(
                          title: Text("Alert", style: TextStyle(
                              fontFamily: 'Arimo',
                              color: Color.fromRGBO(8, 47, 72, 1),
                              fontWeight: FontWeight.bold)),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: const<Widget>[
                                Text(
                                    "Venue already booked !",
                                    style: TextStyle(
                                        fontFamily: 'Arimo')),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(onPressed: () {
                              Navigator.of(context).pop();
                            },
                                child: const Text('Ok', style: TextStyle(
                                    fontFamily: 'Arimo',
                                    color: Color.fromRGBO(8, 47, 72, 1),
                                    fontWeight: FontWeight.bold)))
                          ],
                        );
                      }
                      );
                    }
                    else{
                  savedetails(request['CLASS NAME'],request['NO OF STUDENTS'] ,request['FACULTY NAME'],request['LAST NAME'],request['FROM DATE'],request['TO DATE'],request['FROM TIME'],request['TO TIME'],request['REMARKS'],"Accepted",request['DESCRIPTION'],request['REASON'],request['ALTERNATE'],request['MAIL ID']);
                  dbref3.child(request['key']).remove();
                  Fluttertoast.showToast(msg: "Approved");
                  }
                },
                child: Text("Confirm",textAlign: TextAlign.center,
                  style:TextStyle(fontSize: 15,fontFamily: 'Arimo',color: Colors.white,fontWeight: FontWeight.bold) ,
                ),
              ),
                ),
        SizedBox(width: 10,),
        Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(5),
          color: Color.fromRGBO(255,0,0,1),
          child:
        MaterialButton(
          height: 20,
          minWidth: 150,
          splashColor: Colors.black.withOpacity(0.1),
          onPressed: () {
            showDialog(context: context, builder: (context) {
              return AlertDialog(
                title: Text("Reject request", style: TextStyle(
                    fontFamily: 'Arimo',
                    color: Color.fromRGBO(8, 47, 72, 1),
                    fontWeight: FontWeight.bold)),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      TextFormField(
                        controller: remarks,
                        maxLines: null,
                        style: TextStyle(fontFamily: 'Arimo',),
                        keyboardType: TextInputType.text,
                        onSaved: (value)
                        {
                          remarks.text=value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                          hintText: "Remarks",
                          hintStyle: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1)),
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
                  TextButton(onPressed: () {
                    savedetails(request['CLASS NAME'],request['NO OF STUDENTS'] ,request['FACULTY NAME'],request['LAST NAME'],request['FROM DATE'],request['TO DATE'],request['FROM TIME'],request['TO TIME'],remarks.text,"Rejected",request['DESCRIPTION'],request['REASON'],request['ALTERNATE'],request['MAIL ID']);
                    Navigator.of(context).pop();
                    dbref3.child(request['key']).remove();

                  },
                      child: const Text('Reject', style: TextStyle(
                          fontFamily: 'Arimo',
                          color: Color.fromRGBO(8, 47, 72, 1),
                          fontWeight: FontWeight.bold)))
                ],
              );

            });

          },
          child: Text("Cancel",textAlign: TextAlign.center,
            style:TextStyle(fontSize: 15,fontFamily: 'Arimo',color: Colors.white,fontWeight: FontWeight.bold) ,
          ),
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
        appBar: AppBar(title: Text("APPROVAL",style: TextStyle(fontFamily: 'Arimo',color: Colors.white,fontSize:15,fontWeight: FontWeight.bold),),
          centerTitle: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20),),),
        ),
        body: Container(
          height: double.infinity,
          child: FirebaseAnimatedList(
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
              Map request = snapshot.value as Map;
              request['key'] = snapshot.key;
              return listItem(request: request);
            },
          ),
        )
    );
  }
  void savedetails(String clsname,String stds,String facultyname,String lastname,String frmdte,String todte,String frmtime,String totime,String remarks,String sts,String desc,String reason,String alt,String mail)async{

    Map<dynamic, dynamic> REQUEST = {
      'FACULTY NAME':facultyname,
      'LAST NAME':lastname,
      'CLASS NAME':clsname,
      'NO OF STUDENTS': stds,
      'STATUS':sts,
      'VALUE':'2',
      'ALTERNATE':alt,
      'REASON':reason,
      'FROM DATE': frmdte,
      'TO DATE': todte,
      'FROM TIME':frmtime,
      'TO TIME':totime,
      'DESCRIPTION': desc,
      'REMARKS':remarks,
      'MAIL ID': mail,
    };
    dbref3.push().set(REQUEST);
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
