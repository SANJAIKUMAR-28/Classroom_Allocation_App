import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:newlogin/screens/newdetails.dart';

 class sfBlock extends StatefulWidget {
   const sfBlock({Key? key}) : super(key: key);

   @override
   State<sfBlock> createState() => _sfBlockState();
 }

 class _sfBlockState extends State<sfBlock> {
   @override
   final strengthController = new TextEditingController();
   int strength =0;
   bool cls=true,labs=true,sem=true,sp=false,com=false,clsvalue=true,labsvalue=true, semvalue=true, spvalue=false,comvalue=false;
   static final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
   final GlobalKey<ScaffoldState> _key=GlobalKey();
   Query dbRef = FirebaseDatabase.instance.ref().child('SFCLASS');
   Widget listItem({required Map request}) {
     return SingleChildScrollView(
       child:Padding(
         padding: EdgeInsets.only(left:20,top:6,right: 20,bottom: 6),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             if(request['CLASS-TYPE']=='Classroom'&&((int.parse(request['STRENGTH'])>=strength)&& clsvalue==true )&&!(request['SPEAKER-PROJECTOR']=='No'&&spvalue==true)&&!(request['COMPUTER']=='No'&&comvalue==true))
               sfclass(request['CLASS-NAME'], request['STRENGTH'], request['SPEAKER-PROJECTOR'], request['COMPUTER'],request['FLOOR']),
             if(request['CLASS-TYPE']=='Seminar Hall'&&((int.parse(request['STRENGTH'])>=strength)&& semvalue==true)&&!(request['SPEAKER-PROJECTOR']=='No'&&spvalue==true)&&!(request['COMPUTER']=='No'&&comvalue==true))
               semhall(request['CLASS-NAME'], request['STRENGTH'], request['SPEAKER-PROJECTOR'], request['COMPUTER'],request['FLOOR']),
             if(request['CLASS-TYPE']=='Lab'&&((int.parse(request['STRENGTH'])>=strength)&& labsvalue==true)&&!(request['SPEAKER-PROJECTOR']=='No'&&spvalue==true)&&!(request['COMPUTER']=='No'&&comvalue==true))
               lab(request['CLASS-NAME'],request['STRENGTH'] ,request['SPEAKER-PROJECTOR'], request['COMPUTER'],request['FLOOR']),
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
                     controller: strengthController,
                     style: TextStyle(fontFamily: 'Arimo'),
                     keyboardType: TextInputType.number,

                     onSaved: (value)
                     {
                       strengthController.text=value!;
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
                       if(strengthController.text.isNotEmpty){
                         strength=int.parse(strengthController.text);}
                       if(strengthController.text.isEmpty){
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
   Material sfclass(String classnum,String strength,String speakerAndprojector,String ac,String floor) {
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
           Navigator.push(
               context, MaterialPageRoute(builder: (context) =>newdetail(name1:classnum,totalstrength: strength,)));
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
               ],
             ),
         ),
           ],
         ),
       ),
     );
   }
   Material semhall(String classnum1,String strength1,String speakerAndprojector1,String ac1,String floor1) {
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
             SizedBox(height: 100,width: 150,
               child: Image.asset('assets/seminarhall.png',),
             ),
             SizedBox(width: 5,),
         Flexible(child:
             Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children:[
                 Text(classnum1,maxLines:2,style: TextStyle(fontWeight: FontWeight.w900,fontFamily: 'Arimo',color: Colors.black,fontSize: 15),),

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
               ],
             ),
         ),
           ],
         ),
       ),
     );
   }
   Material lab(String classnum2,String strength2,String speakerAndprojector2,String ac2,String floor2) {
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
           Navigator.push(
               context, MaterialPageRoute(builder: (context) => newdetail(name1:classnum2,totalstrength: strength2,)));
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
                 Text(classnum2, style: TextStyle(fontWeight: FontWeight.w900,
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
               ],
             ),
         ),
           ],
         ),
       ),
     );
   }
 }
