import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../classdetails.dart';
class adminlib extends StatefulWidget {
  const adminlib({Key? key}) : super(key: key);

  @override
  State<adminlib> createState() => _adminlibState();
}

class _adminlibState extends State<adminlib> {
  @override
  Query dbRef = FirebaseDatabase.instance.ref().child('LIBCLASS');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('LIBCLASS');
  final clsname = new TextEditingController();
  final  strengthController = new TextEditingController();
  String availaiblity="Yes";
  String availaiblity2="Yes";
  String clstype="Classroom";
  var yesorno=['Yes','No'];
  Widget listItem({required Map request}) {
    return SingleChildScrollView(
      child:Padding(
        padding: EdgeInsets.only(left:20,top:6,right: 20,bottom: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if(request['CLASS-TYPE']=='Conference Hall')
              conferencehall(request['CLASS-NAME'], request['STRENGTH'], request['SPEAKER-PROJECTOR'], request['COMPUTER'],request['key'],request['FLOOR']),
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
        actions:<Widget> [Container()],
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
  Material conferencehall(String classnum1,String strength1,String speakerAndprojector1,String ac1,String key1,String floor) {
    return Material(
      elevation: 4,
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10,15,10,15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>classdetails(clsname: classnum1)));
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    InkWell(
                      child: Row(
                        children:[
                          Icon(Icons.edit,size:14,color: Color.fromRGBO(77,0,114,1),),
                          Text(" Edit",style: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1),),),
                        ],
                      ),
                      onTap: (){
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(
                            title: Text("Edit venue", style: TextStyle(
                                fontFamily: 'Arimo',
                                color: Color.fromRGBO(8, 47, 72, 1),
                                fontWeight: FontWeight.bold)),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  TextFormField(
                                    controller: clsname,
                                    style: TextStyle(fontFamily: 'Arimo',),
                                    keyboardType: TextInputType.text,
                                    onSaved: (value)
                                    {
                                      clsname.text=value!;
                                    },
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                                      hintText: "${classnum1}",
                                      hintStyle: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1)),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: strengthController,
                                    style: TextStyle(fontFamily: 'Arimo',),
                                    keyboardType: TextInputType.text,
                                    onSaved: (value)
                                    {
                                      if(value==null){
                                        strengthController.text=strength1;
                                      }
                                      if(value!=null){
                                        strengthController.text=value;}
                                    },
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                                      hintText: "${strength1}",
                                      hintStyle: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1)),
                                    ),
                                  ),
                                  DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                                        labelText: "Speaker/projector availabilty",
                                        labelStyle: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1)),
                                      ),
                                      value:"${speakerAndprojector1}",
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
                                  DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                                        labelText: "Computer availabilty",
                                        labelStyle: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1)),
                                      ),
                                      value:"${ac1}",
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
                                if(clsname.text.length==0){
                                  reference.child(key1).update({'CLASS-NAME':classnum1.toUpperCase()});}
                                else{
                                  reference.child(key1).update({'CLASS-NAME':clsname.text.toUpperCase()});}
                                if(strengthController.text.length==0){
                                  reference.child(key1).update({'STRENGTH':strength1.toString()});}
                                else{
                                  reference.child(key1).update({'STRENGTH':strengthController.text.toString()});}
                                reference.child(key1).update({'SPEAKER-PROJECTOR':availaiblity.toString()});
                                reference.child(key1).update({'COMPUTER':availaiblity2.toString()});
                                Navigator.of(context).pop();
                                Fluttertoast.showToast(msg: "Updated");
                              },
                                  child: const Text('Update', style: TextStyle(
                                      fontFamily: 'Arimo',
                                      color: Color.fromRGBO(8, 47, 72, 1),
                                      fontWeight: FontWeight.bold)))
                            ],
                          );

                        });
                      },
                    ),
                    InkWell(
                      child: Row(
                        children:[
                          Icon(Icons.delete,size:14,color: Color.fromRGBO(77,0,114,1),),
                          Text(" Delete",style: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1),),),
                        ],
                      ),
                      onTap: (){
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(
                            title: Text("Delete venue", style: TextStyle(
                                fontFamily: 'Arimo',
                                color: Color.fromRGBO(8, 47, 72, 1),
                                fontWeight: FontWeight.bold)),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const<Widget>[
                                  Text(
                                      "Are you sure want to delete venue?",
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
                                reference.child(key1).remove();
                                Navigator.of(context).pop();
                                Fluttertoast.showToast(msg: "Deleted");
                              },
                                  child: const Text('Yes', style: TextStyle(
                                      fontFamily: 'Arimo',
                                      color: Color.fromRGBO(8, 47, 72, 1),
                                      fontWeight: FontWeight.bold)))
                            ],
                          );

                        });
                      },
                    ),
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
