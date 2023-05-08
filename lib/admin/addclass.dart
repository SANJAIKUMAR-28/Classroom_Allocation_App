import 'package:flutter/material.dart';
import 'package:newlogin/admin/classaddedscrn.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
class addingclass extends StatefulWidget {
  const addingclass({Key? key}) : super(key: key);


  @override
  State<addingclass> createState() => _addingclassState();
}

class _addingclassState extends State<addingclass> {
  final  clsnameController= new TextEditingController();
  final  strengthController = new TextEditingController();
  final _formkey= GlobalKey<FormState>();
  final _auth=FirebaseAuth.instance;
  late DatabaseReference dbRef;
  late DatabaseReference dbRef1;
  late DatabaseReference dbRef2;
  late DatabaseReference dbRef3;
  late DatabaseReference dbRef4;

  String dropdownvalue="IB-BLOCK";
  String availaiblity="Yes";
  String availaiblity2="Yes";
  String clstype="Classroom";
  String flr='Ground';
  var floor=['Ground','I','II','III'];
  var types=['Classroom','Seminar Hall','Lab','Conference Hall'];
  var yesorno=['Yes','No'];
  var blocks=['IB-BLOCK','AS-BLOCK','SF-BLOCK','MECH-BLOCK','LIBRARY'];
  @override
  void initState() {

      setState(() {
      });
    dbRef = FirebaseDatabase.instance.ref().child('IBCLASS');
      dbRef1 = FirebaseDatabase.instance.ref().child('ASCLASS');
      dbRef2 = FirebaseDatabase.instance.ref().child('SFCLASS');
      dbRef3 = FirebaseDatabase.instance.ref().child('MECHCLASS');
      dbRef4 = FirebaseDatabase.instance.ref().child('LIBCLASS');

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("DETAILS",style: TextStyle(fontFamily: 'Arimo',color: Colors.white,fontSize:15,fontWeight: FontWeight.bold),),
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20),),),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(10),
              child:Form(
                key: _formkey,
              child: Column(
                children: [
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                        labelText: "Select block",
                        labelStyle: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1)),
                      ),
                      value: dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      validator: (value) => value == null ? 'Select block' : null,
                      items: blocks.map((String blocks){
                        return DropdownMenuItem(
                        value:blocks,

                        child:Text(blocks,style: TextStyle(fontWeight: FontWeight.w900,fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1),fontSize: 15)),
                        );
                      }).toList(),

                      onChanged:(String? newValue){
                      setState(() {
                        dropdownvalue=newValue!;
                      });
                      }

                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: false,
                    controller: clsnameController,
                    style: TextStyle(fontFamily: 'Arimo',),
                    keyboardType: TextInputType.text,
                    validator: (value){
                      if(value!.isEmpty){
                        return("Please enter class name");
                      }

                      return null;
                    },
                    onSaved: (value)
                    {
                      clsnameController.text=value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                      hintText: "Enter class name",
                      hintStyle: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofocus: false,
                    controller: strengthController,
                    style: TextStyle(fontFamily: 'Arimo',),
                    keyboardType: TextInputType.number,
                    validator: (value){
                      if(value!.isEmpty){
                        return("Please enter class strength");
                      }

                      return null;
                    },
                    onSaved: (value)
                    {
                      strengthController.text=value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                      hintText: "Enter class strength",
                      hintStyle: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                        labelText: "Floor",
                        labelStyle: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1)),
                      ),
                      value: flr,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      validator: (value) => value == null ? 'Select Yes or No' : null,
                      items: floor.map((String yesorno2){
                        return DropdownMenuItem(
                          value:yesorno2,
                          child:Text(yesorno2,style: TextStyle(fontWeight: FontWeight.w900,fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1),fontSize: 15)),
                        );
                      }).toList(),
                      onChanged:(String? newValue2){
                        setState(() {
                          flr=newValue2!;
                        });
                      }
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                        labelText: "Venue type",
                        labelStyle: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1)),
                      ),
                      value: clstype,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      validator: (value) => value == null ? 'Select Yes or No' : null,
                      items: types.map((String type){
                        return DropdownMenuItem(
                          value:type,

                          child:Text(type,style: TextStyle(fontWeight: FontWeight.w900,fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1),fontSize: 15)),
                        );
                      }).toList(),

                      onChanged:(String? newValue3){
                        setState(() {
                          clstype=newValue3!;
                        });
                      }
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                        labelText: "Speaker/projector availabilty",
                        labelStyle: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1)),
                      ),
                      value: availaiblity,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      validator: (value) => value == null ? 'Select Yes or No' : null,
                      items: yesorno.map((String yesorno){
                        return DropdownMenuItem(
                          value:yesorno,

                          child:Text(yesorno,style: TextStyle(fontWeight: FontWeight.w900,fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1),fontSize: 15)),
                        );
                      }).toList(),

                      onChanged:(String? newValue){
                        setState(() {
                          availaiblity=newValue!;
                        });
                      }

                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                        labelText: "Computer availabilty",
                        labelStyle: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1)),
                      ),
                      value: availaiblity2,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      validator: (value) => value == null ? 'Select Yes or No' : null,
                      items: yesorno.map((String yesorno2){
                        return DropdownMenuItem(
                          value:yesorno2,
                          child:Text(yesorno2,style: TextStyle(fontWeight: FontWeight.w900,fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1),fontSize: 15)),
                        );
                      }).toList(),
                      onChanged:(String? newValue2){
                        setState(() {
                          availaiblity2=newValue2!;
                        });
                      }
                  ),

                  SizedBox(height: 80,),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(8,47,72,1),
                    child:MaterialButton(
                      padding: EdgeInsets.fromLTRB(20,15,20,15),
                      minWidth: MediaQuery.of(context).size.width,
                      splashColor: Colors.black.withOpacity(0.2),
                      onPressed: () {
                        savedetails( clsnameController.text, strengthController.text );
                      },
                      child: Text("ADD VENUE",textAlign: TextAlign.center,
                        style:TextStyle(fontSize: 15,fontFamily: 'Arimo',color: Colors.white,fontWeight: FontWeight.bold) ,
                      ),
                    ),
                  ),
                ],
              ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void savedetails(String classname,String strengthdetails) async
  {
    if(_formkey.currentState!.validate()) {
      if(dropdownvalue=='IB-BLOCK') {
        passIBDetailtoFirestore();
      }
      else if(dropdownvalue=='AS-BLOCK'){
        passASDetailtoFirestore();
      }
      else if(dropdownvalue=='SF-BLOCK'){
        passSFDetailtoFirestore();
      }
      else if(dropdownvalue=='MECH-BLOCK'){
        passMECHDetailtoFirestore();
      }
      else if(dropdownvalue=='LIBRARY'){
        passLIBDetailtoFirestore();
      }
    }
  }
  passIBDetailtoFirestore() async{
    Map<String, String> IBCLASS = {
      'BLOCK':dropdownvalue.toString(),
      'CLASS-NAME':clsnameController.text.toUpperCase(),
      'STRENGTH': strengthController.text,
      'CLASS-TYPE': clstype.toString(),
      'SPEAKER-PROJECTOR': availaiblity.toString(),
      'COMPUTER':availaiblity2.toString(),
      'FLOOR':flr.toString(),
    };

    dbRef.push().set(IBCLASS);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>classadded()));
  }
  passASDetailtoFirestore() async{
    Map<String, String> ASCLASS = {
      'BLOCK':dropdownvalue.toString(),
      'CLASS-NAME':clsnameController.text.toUpperCase(),
      'STRENGTH': strengthController.text,
      'CLASS-TYPE': clstype.toString(),
      'SPEAKER-PROJECTOR': availaiblity.toString(),
      'COMPUTER':availaiblity2.toString(),
      'FLOOR':flr.toString(),
    };
    dbRef1.push().set(ASCLASS);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>classadded()));
  }
  passSFDetailtoFirestore() async{
    Map<String, String> SFCLASS = {
      'BLOCK':dropdownvalue.toString(),
      'CLASS-NAME':clsnameController.text.toUpperCase(),
      'STRENGTH': strengthController.text,
      'CLASS-TYPE': clstype.toString(),
      'SPEAKER-PROJECTOR': availaiblity.toString(),
      'COMPUTER':availaiblity2.toString(),
      'FLOOR':flr.toString(),
    };
    dbRef2.push().set(SFCLASS);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>classadded()));
  }
  passMECHDetailtoFirestore() async{
    Map<String, String> MECHCLASS = {
      'BLOCK':dropdownvalue.toString(),
      'CLASS-NAME':clsnameController.text.toUpperCase(),
      'STRENGTH': strengthController.text,
      'CLASS-TYPE': clstype.toString(),
      'SPEAKER-PROJECTOR': availaiblity.toString(),
      'COMPUTER':availaiblity2.toString(),
      'FLOOR':flr.toString(),
    };

    dbRef3.push().set(MECHCLASS);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>classadded()));
  }
  passLIBDetailtoFirestore() async{
    Map<String, String> LIBCLASS = {

      'BLOCK':dropdownvalue.toString(),
      'CLASS-NAME':clsnameController.text.toUpperCase(),
      'STRENGTH': strengthController.text,
      'CLASS-TYPE': clstype.toString(),
      'SPEAKER-PROJECTOR': availaiblity.toString(),
      'COMPUTER':availaiblity2.toString(),
      'FLOOR':flr.toString(),
    };
    dbRef4.push().set(LIBCLASS);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>classadded()));
  }
}
