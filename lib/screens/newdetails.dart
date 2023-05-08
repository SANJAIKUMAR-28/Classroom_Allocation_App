import 'package:firebase_database/firebase_database.dart' as db;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newlogin/model/user_model.dart' ;
import 'package:newlogin/screens/responsescrn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'holdings.dart';

class newdetail extends StatefulWidget {
  final String name1;
  final String totalstrength;
  const newdetail({Key? key,required this.name1, required this.totalstrength}) : super(key: key);

  @override
  State<newdetail> createState() => _newdetailState();
}

class _newdetailState extends State<newdetail> {
  final  usernofsController = TextEditingController();
  final  userfromdateController= TextEditingController();
  final  usertodateController =TextEditingController();
  final userdescController = TextEditingController();
  final stscontroller=TextEditingController();
  static final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final User? user=FirebaseAuth.instance.currentUser;
  DateTime dateTime = DateTime(2022,11,30,8,45);
  TimeOfDay time=TimeOfDay(hour: 12, minute: 00);
  late db.DatabaseReference dbRef;
  late db.DatabaseReference dbRef1;
  TextEditingController timeinput=TextEditingController();
  TextEditingController timeinput2=TextEditingController();
  UserModel loggedinuser=UserModel();
  late int count;
  @override
  void initState() {
    timeinput.text="";
    timeinput2.text="";
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedinuser = UserModel.fromMap(value.data());
      setState(() {

      });
    });
    dbRef = db.FirebaseDatabase.instance.ref().child('REQUEST');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("DETAILS",style: TextStyle(fontFamily: 'Arimo',color: Colors.white,fontSize:15,fontWeight: FontWeight.bold),),
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20),),),
      ),
      body: SingleChildScrollView(
          child:Container(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child:Form(
                  key: _formkey,
                  child: Column(
                    children: [
                  InkWell(
                  child:Padding(
                  padding: EdgeInsets.only(left:190),
                  child: Text("Check availability",style: TextStyle(fontSize:15,fontWeight:FontWeight.bold,decoration:TextDecoration.underline,fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1),),),
                ),
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>holdings(clsname: widget.name1)));
                },
              ),
                      SizedBox(height: 5,),
                      TextFormField(
                        autofocus: false,
                        controller: usernofsController,
                        style: TextStyle(fontFamily: 'Arimo'),
                        keyboardType: TextInputType.number,
                        validator: (value){
                          if(value!.isEmpty){
                            return("Please enter total no. of. students");
                          }
                          if(int.parse(value)>=(int.parse(widget.totalstrength)+1)){
                            return("Strength should be less than ${widget.totalstrength}");
                          }
                          return null;
                        },
                        onSaved: (value)
                        {
                          usernofsController.text=value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            prefixIcon:Icon(Icons.person,color: Color.fromRGBO(77,0,114,1),),
                            contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                            hintText: "No. of. students",
                            hintStyle: TextStyle(fontFamily: 'Arimo'),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: userfromdateController,
                        autofocus: false,
                        style: TextStyle(fontFamily: 'Arimo'),
                        onTap: ()async {
                          DateTime ? pickdate2 = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now().subtract(Duration(days: 0)),
                              lastDate: DateTime(2050));
                          if (pickdate2 != null) {
                            setState(() {
                              userfromdateController.text =
                                  DateFormat('dd-MM-yyyy').format(pickdate2);
                            });
                          };
                        },
                        validator: (value){
                          if(value!.isEmpty){
                            return("Please select FROM date");
                          }

                          return null;
                        },
                        onSaved: (value)
                        {

                          userfromdateController.text=value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            prefixIcon:Icon(Icons.date_range,color: Color.fromRGBO(77,0,114,1),),
                          suffixIcon: Icon(Icons.arrow_drop_down,color: Color.fromRGBO(77,0,114,1),),
                            contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                            hintText: "From date",
                            hintStyle: TextStyle(fontFamily: 'Arimo'),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: usertodateController,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(fontFamily: 'Arimo'),
                        onTap: ()async {
                          DateTime ? pickdate2 = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now().subtract(Duration(days: 0)),
                              lastDate: DateTime(2050));
                          if (pickdate2 != null) {
                            setState(() {
                              usertodateController.text =
                                  DateFormat('dd-MM-yyyy').format(pickdate2);
                            });
                          };
                        },
                        validator: (value){
                          if(value!.isEmpty){
                            return("Please select TO date");
                          }
                          return null;
                        },
                        onSaved: (value)
                        {
                          usertodateController.text=value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            prefixIcon:Icon(Icons.date_range,color: Color.fromRGBO(77,0,114,1),),
                          suffixIcon: Icon(Icons.arrow_drop_down,color: Color.fromRGBO(77,0,114,1),),
                            contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                            hintText: "To date",
                            hintStyle: TextStyle(fontFamily: 'Arimo'),


                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autofocus: false,
                        controller: timeinput,
                        style: TextStyle(fontFamily: 'Arimo',),
                        keyboardType: TextInputType.number,
                        onTap: () async {
                          TimeOfDay ? picktime2= await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay(hour: time.hour, minute: time.minute),
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(
                                      alwaysUse24HourFormat: false),
                                  child: child!,
                                );
                              }
                          );
                          if(picktime2!=null) {
                            setState(() {
                              timeinput.text=picktime2.format(context);
                            });
                          }
                        },
                        validator: (value){
                          if(value!.isEmpty){
                            return("Please select FROM time");
                          }
                          return null;
                        },
                        onSaved: (value)
                        {
                          timeinput.text=value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                            prefixIcon: Icon(Icons.access_time,color: Color.fromRGBO(77,0,114,1),),
                            suffixIcon: Icon(Icons.arrow_drop_down,color: Color.fromRGBO(77,0,114,1),),
                            hintText: "From time",
                            hintStyle: TextStyle(fontFamily: 'Arimo',),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autofocus: false,
                        controller: timeinput2,
                        style: TextStyle(fontFamily: 'Arimo',),
                        keyboardType: TextInputType.number,
                        onTap: () async {
                         final TimeOfDay ? picktime= await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay(hour: time.hour, minute: time.minute,),
                          builder: (BuildContext context, Widget? child) {
                            return MediaQuery(
                              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                              child: child!,
                            );
                          }
                          );
                          if(picktime!=null) {
                            setState(() {
                              timeinput2.text=picktime.format(context);
                            });
                          }
                        },
                        validator: (value){
                          if(value!.isEmpty){
                            return("Please select TO time");
                          }
                          return null;
                        },
                        onSaved: (value)
                        {
                          timeinput2.text=value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                            prefixIcon: Icon(Icons.access_time,color: Color.fromRGBO(77,0,114,1),),
                            suffixIcon: Icon(Icons.arrow_drop_down,color: Color.fromRGBO(77,0,114,1),),
                            hintText: "To time",
                            hintStyle: TextStyle(fontFamily: 'Arimo',),

                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        maxLines: null,
                        autofocus: false,
                        controller: userdescController,
                        style: TextStyle(fontFamily: 'Arimo'),
                        keyboardType: TextInputType.text,
                        autovalidateMode:
                        AutovalidateMode.onUserInteraction,
                        validator: (value){
                          if(value!.isEmpty){
                            return("Please enter description");
                          }
                          return null;
                        },
                        onSaved: (value)
                        {
                          userdescController.text=value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            prefixIcon:Icon(Icons.description,color: Color.fromRGBO(77,0,114,1),),
                            contentPadding: EdgeInsets.fromLTRB(10,15,10,50),
                            hintText: "Description of the event",
                            hintStyle: TextStyle(fontFamily: 'Arimo'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )
                        ),
                      ),
                      SizedBox(height: 50,),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(8,47,72,1),
                        child:MaterialButton(
                          padding: EdgeInsets.fromLTRB(20,15,20,15),
                          minWidth: MediaQuery.of(context).size.width,
                          splashColor: Colors.black.withOpacity(0.2),
                          onPressed: () {
                          if(_formkey.currentState!.validate()) {
                            showDialog(context: context, builder: (context) {
                              return AlertDialog(
                                title: Text("Confrim booking", style: TextStyle(
                                    fontFamily: 'Arimo',
                                    color: Color.fromRGBO(8, 47, 72, 1),
                                    fontWeight: FontWeight.bold)),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: const<Widget>[
                                      Text(
                                          "Are you sure want to request venue?",
                                          style: TextStyle(
                                              fontFamily: 'Arimo')),
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
                                    Navigator.of(context).pop();
                                    savedetails(usernofsController.text,
                                        userfromdateController.text,
                                        usertodateController.text,
                                        userdescController.text);
                                  },
                                      child: const Text('Yes', style: TextStyle(
                                          fontFamily: 'Arimo',
                                          color: Color.fromRGBO(8, 47, 72, 1),
                                          fontWeight: FontWeight.bold)))
                                ],
                              );
                            });
                          }
                          },
                          child: Text("REQUEST VENUE",textAlign: TextAlign.center,
                            style:TextStyle(fontSize: 15,fontFamily: 'Arimo',color: Colors.white,fontWeight: FontWeight.bold) ,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              )
          ),
        ),
    );
  }
  void savedetails(String noofstudents,String fromdate,String todate,String description,) async
  {
    if(_formkey.currentState!.validate()){
      passDetailtoFirestore();
    }
  }
  passDetailtoFirestore() async{
    Map<dynamic, dynamic> REQUEST = {
      'FACULTY NAME':loggedinuser.firstname.toString(),
      'LAST NAME':loggedinuser.lastname.toString(),
      'CLASS NAME':widget.name1.toString(),
      'NO OF STUDENTS': usernofsController.text,
      'STATUS':'Initiated',
      'VALUE':'1',
      'ALTERNATE':'0',
      'REASON':'NIL',
      'FROM DATE': userfromdateController.text,
      'TO DATE': usertodateController.text,
      'FROM TIME':timeinput.text,
      'TO TIME':timeinput2.text,
      'DESCRIPTION': userdescController.text,
      'REMARKS':'NILL',
      'MAIL ID': loggedinuser.email.toString(),
    };
    dbRef.push().set(REQUEST);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>response()));
  }
}
