import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../classdetails.dart';
class adminsf extends StatefulWidget {
  const adminsf({Key? key}) : super(key: key);

  @override
  State<adminsf> createState() => _adminsfState();
}

class _adminsfState extends State<adminsf> {
  @override
  final strengthController1 = new TextEditingController();
  int strength =0;
  bool cls=true,labs=true,sem=true,sp=false,com=false,clsvalue=true,labsvalue=true, semvalue=true, spvalue=false,comvalue=false;
  static final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _key=GlobalKey();
  Query dbRef = FirebaseDatabase.instance.ref().child('SFCLASS');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('SFCLASS');
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
            if(request['CLASS-TYPE']=='Classroom'&&((int.parse(request['STRENGTH'])>=strength)&& clsvalue==true )&&!(request['SPEAKER-PROJECTOR']=='No'&&spvalue==true)&&!(request['COMPUTER']=='No'&&comvalue==true))
              sfclass(request['CLASS-NAME'], request['STRENGTH'], request['SPEAKER-PROJECTOR'], request['COMPUTER'],request['key'],request['FLOOR']),
            if(request['CLASS-TYPE']=='Seminar Hall'&&((int.parse(request['STRENGTH'])>=strength)&& semvalue==true)&&!(request['SPEAKER-PROJECTOR']=='No'&&spvalue==true)&&!(request['COMPUTER']=='No'&&comvalue==true))
              semhall(request['CLASS-NAME'], request['STRENGTH'], request['SPEAKER-PROJECTOR'], request['COMPUTER'],request['key'],request['FLOOR']),
            if(request['CLASS-TYPE']=='Lab'&&((int.parse(request['STRENGTH'])>=strength)&& labsvalue==true)&&!(request['SPEAKER-PROJECTOR']=='No'&&spvalue==true)&&!(request['COMPUTER']=='No'&&comvalue==true))
              lab(request['CLASS-NAME'],request['STRENGTH'] ,request['SPEAKER-PROJECTOR'], request['COMPUTER'],request['key'],request['FLOOR']),
          ],
        ),
      ),
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("SF BLOCK",style: TextStyle(fontFamily: 'Arimo',color: Colors.white,fontSize:15,fontWeight: FontWeight.bold),),
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
      endDrawer: Drawer(
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(height: 50,),
                Text('FILTERS',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1),fontSize: 17,),textAlign: TextAlign.left,),
                SizedBox(height: 10,),
                Divider(),
                SizedBox(
                  width: 250,
                  child:
                  TextFormField(
                    autofocus: false,
                    controller: strengthController1,
                    style: TextStyle(fontFamily: 'Arimo'),
                    keyboardType: TextInputType.number,

                    onSaved: (value)
                    {
                      strengthController1.text=value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon:Icon(Icons.person,color: Color.fromRGBO(77,0,114,1),),
                      contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                      hintText: "No. of. students",
                      hintStyle: TextStyle(fontFamily: 'Arimo'),

                    ),
                  ),
                ),
                Divider(endIndent: 5,indent: 5,),
                CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text('Classrooms',style: TextStyle(fontWeight: FontWeight.w900,fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1),fontSize: 15)),
                    value: cls, onChanged: (cls)=>setState(() {
                  this.cls=cls!;
                })),
                Divider(endIndent: 2,indent: 2,),
                CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text('Labs',style: TextStyle(fontWeight: FontWeight.w900,fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1),fontSize: 15)),
                    value: labs, onChanged: (labs)=>setState(() {
                  this.labs=labs!;
                })),
                Divider(endIndent: 5,indent: 5,),
                CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text('Seminar halls',style: TextStyle(fontWeight: FontWeight.w900,fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1),fontSize: 15)),
                    value: sem, onChanged: (sem)=>setState(() {
                  this.sem=sem!;
                })),
                Divider(endIndent: 5,indent: 5,),
                CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text('Projector/Speaker',style: TextStyle(fontWeight: FontWeight.w900,fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1),fontSize: 15)),
                    value: sp, onChanged: (sp)=>setState(() {
                  this.sp=sp!;
                })),
                Divider(endIndent: 5,indent: 5,),
                CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text('Computer',style: TextStyle(fontWeight: FontWeight.w900,fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1),fontSize: 15)),
                    value: com, onChanged: (com)=>setState(() {
                  this.com=com!;
                })),
                Divider(),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(0,136,34,1),
                  ),
                  onPressed: () {
                    setState(() {
                      if(strengthController1.text.isNotEmpty){
                        strength=int.parse(strengthController1.text);}
                      if(strengthController1.text.isEmpty){
                        strength=0;
                      }
                      if(cls==true){
                        clsvalue=true;
                      }else{
                        clsvalue=false;
                      }
                      if(labs==true){
                        labsvalue=true;
                      }else{
                        labsvalue=false;
                      }
                      if(sem==true){
                        semvalue=true;
                      }else{
                        semvalue=false;
                      }
                      if(sp==false){

                        spvalue=false;
                      }else{
                        spvalue=true;
                      }
                      if(com==true){
                        comvalue=true;
                      }else{
                        comvalue=false;
                      }
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text("Apply",textAlign: TextAlign.center,
                    style:TextStyle(fontSize: 15,fontFamily: 'Arimo',color: Colors.white,fontWeight: FontWeight.bold) ,
                  ),
                ),
              ],
            ),

          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton:FloatingActionButton(onPressed: (){
        _key.currentState!.openEndDrawer();
      },
        backgroundColor: Color.fromRGBO(8, 47, 72, 1),
        child: const Icon(Icons.filter_alt,color: Colors.white,),
      ),
    );
  }
  Material sfclass(String classnum,String strength,String speakerAndprojector,String ac,String key,String floor) {
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
        onPressed: ()  {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>classdetails(clsname: classnum)));
        },
        child: Row(
          children: [
            SizedBox(height: 100,width: 150,
              child: Image.asset('assets/classimg.png',),
            ),
            SizedBox(width: 5,),
            Flexible(child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(classnum, style: TextStyle(fontWeight: FontWeight.w900,
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
                    Text(strength, style: TextStyle(
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
                    Text(speakerAndprojector, style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Arimo',
                        color: Colors.black,
                        fontSize: 10),),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text('Computer:', style: TextStyle(fontWeight: FontWeight.normal,
                        fontFamily: 'Arimo',
                        color: Colors.black,
                        fontSize: 10),),
                    SizedBox(width: 5,),
                    Text(ac, style: TextStyle(fontWeight: FontWeight.normal,
                        fontFamily: 'Arimo',
                        color: Colors.black,
                        fontSize: 10),),
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
                SizedBox(height: 5,),
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
                                      hintText: "${classnum}",
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
                                        strengthController.text=strength;
                                      }
                                      if(value!=null){
                                        strengthController.text=value;}
                                    },
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                                      hintText: "${strength}",
                                      hintStyle: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1)),
                                    ),
                                  ),
                                  DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                                        labelText: "Speaker/projector availabilty",
                                        labelStyle: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1)),
                                      ),
                                      value:"${speakerAndprojector}",
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
                                      value: "${ac}",
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
                                  reference.child(key).update({'CLASS-NAME':classnum.toUpperCase()});}
                                else{
                                  reference.child(key).update({'CLASS-NAME':clsname.text.toUpperCase()});}
                                if(strengthController.text.length==0){
                                  reference.child(key).update({'STRENGTH':strength.toString()});}
                                else{
                                  reference.child(key).update({'STRENGTH':strengthController.text.toString()});}
                                reference.child(key).update({'SPEAKER-PROJECTOR':availaiblity.toString()});
                                reference.child(key).update({'COMPUTER':availaiblity2.toString()});
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
                                reference.child(key).remove();
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
  Material semhall(String classnum1,String strength1,String speakerAndprojector1,String ac1,String key1,String floor1) {
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
            SizedBox(height: 100,width: 150,
              child: Image.asset('assets/seminarhall.png',),
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
                    Text(floor1, style: TextStyle(fontWeight: FontWeight.normal,
                        fontFamily: 'Arimo',
                        color: Colors.black,
                        fontSize: 10),),
                  ],
                ),
                SizedBox(height: 5,),
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
                                      value: "${ac1}",
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
  Material lab(String classnum2,String strength2,String speakerAndprojector2,String ac2,String key2,String floor2) {
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
          Navigator.push(context, MaterialPageRoute(builder: (context)=>classdetails(clsname: classnum2)));
        },
        child: Row(
          children: [
            SizedBox(height: 100,width: 150,
              child: Image.asset('assets/lab.png',),
            ),
            SizedBox(width: 5,),
            Flexible(child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(classnum2,maxLines: null, style: TextStyle(fontWeight: FontWeight.w900,
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
                    Text(strength2, style: TextStyle(
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
                    Text(speakerAndprojector2, style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Arimo',
                        color: Colors.black,
                        fontSize: 10),),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text('Computer:', style: TextStyle(fontWeight: FontWeight.normal,
                        fontFamily: 'Arimo',
                        color: Colors.black,
                        fontSize: 10),),
                    SizedBox(width: 5,),
                    Text(ac2, style: TextStyle(fontWeight: FontWeight.normal,
                        fontFamily: 'Arimo',
                        color: Colors.black,
                        fontSize: 10),),
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
                    Text(floor2, style: TextStyle(fontWeight: FontWeight.normal,
                        fontFamily: 'Arimo',
                        color: Colors.black,
                        fontSize: 10),),
                  ],
                ),
                SizedBox(height: 5,),
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
                                      hintText: "${classnum2}",
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
                                        strengthController.text=strength2;
                                      }
                                      if(value!=null){
                                        strengthController.text=value;}
                                    },
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                                      hintText: "${strength2}",
                                      hintStyle: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1)),
                                    ),
                                  ),
                                  DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                                        labelText: "Speaker/projector availabilty",
                                        labelStyle: TextStyle(fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1)),
                                      ),
                                      value:"${speakerAndprojector2}",
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
                                      value: "${ac2}",
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
                                  reference.child(key2).update({'CLASS-NAME':classnum2.toUpperCase()});}
                                else{
                                  reference.child(key2).update({'CLASS-NAME':clsname.text.toUpperCase()});}
                                if(strengthController.text.length==0){
                                  reference.child(key2).update({'STRENGTH':strength2.toString()});}
                                else{
                                  reference.child(key2).update({'STRENGTH':strengthController.text.toString()});}
                                reference.child(key2).update({'SPEAKER-PROJECTOR':availaiblity.toString()});
                                reference.child(key2).update({'COMPUTER':availaiblity2.toString()});
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
                                reference.child(key2).remove();
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
