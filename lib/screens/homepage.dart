import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newlogin/blocks/asblock.dart';
import 'package:newlogin/blocks/audi.dart';
import 'package:newlogin/blocks/ibblock.dart';
import 'package:newlogin/blocks/lib.dart';
import 'package:newlogin/screens/loginpage.dart';
import 'package:newlogin/blocks/mechblock.dart';
import 'package:newlogin/screens/navbar.dart';
import 'package:newlogin/blocks/sfblock.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    final ibbutton=  Material(
      color: Colors.white,
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10,15,10,15),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ibBlock()));
        },
        child:Column(
          mainAxisSize: MainAxisSize.min,
        children:[
          SizedBox(height: 6,),
          Image.asset("assets/IB.png",fit: BoxFit.cover,),
          SizedBox(height: 6,),
          Text(
            'IB-BLOCK',style: TextStyle(fontWeight: FontWeight.w900,fontFamily: 'Arimo',color: Color.fromRGBO(77, 0, 114, 1),fontSize: 24),
          )

      ],
        ),
      ),
    );
    final asbutton=  Material(
      color: Colors.white,
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10,15,10,15),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>asBlock()));
        },
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children:[
            SizedBox(height: 6,),
            Image.asset("assets/AS.png",fit: BoxFit.cover,),
            SizedBox(height: 6,),
            Text(
              'AS-BLOCK',style: TextStyle(fontWeight: FontWeight.w900,fontFamily: 'Arimo',color: Color.fromRGBO(77, 0, 114, 1),fontSize: 24),
            )

          ],
        ),
      ),
    );
    final sfbutton=  Material(
      color: Colors.white,
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10,15,10,15),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>sfBlock()));
        },
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children:[
            SizedBox(height: 6,),
            Image.asset("assets/SF.jpg",fit: BoxFit.cover,),
            SizedBox(height: 6,),
            Text(
              'SF-BLOCK',style: TextStyle(fontWeight: FontWeight.w900,fontFamily: 'Arimo',color: Color.fromRGBO(77, 0, 114, 1),fontSize: 24),
            )

          ],
        ),
      ),
    );
    final mechbutton=  Material(
      color: Colors.white,
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10,15,10,15),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>mechBlock()));
        },
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children:[
            SizedBox(height: 6,),
            Image.asset("assets/MECH.png",fit: BoxFit.cover,),
            SizedBox(height: 6,),
            Text(
              'MECH-BLOCK',style: TextStyle(fontWeight: FontWeight.w900,fontFamily: 'Arimo',color: Color.fromRGBO(77, 0, 114, 1),fontSize: 24),
            )

          ],
        ),
      ),
    );
    final libbutton=  Material(
      color: Colors.white,
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10,15,10,15),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>lib()));
        },
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children:[
            SizedBox(height: 6,),
            Image.asset("assets/LIB.jpg",fit: BoxFit.cover,),
            SizedBox(height: 6,),
            Text(
              'LIBRARY',style: TextStyle(fontWeight: FontWeight.w900,fontFamily: 'Arimo',color: Color.fromRGBO(77, 0, 114, 1),fontSize: 24),
            )

          ],
        ),
      ),
    );
    final audibutton=  Material(
      color: Colors.white,
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10,15,10,15),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>auditorium()));
        },
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children:[
            SizedBox(height: 6,),
            Image.asset("assets/AUDITORIUM.JPG",fit: BoxFit.fill,),
            SizedBox(height: 6,),
            Text(
              'AUDITORIUMS',style: TextStyle(fontWeight: FontWeight.w900,fontFamily: 'Arimo',color: Color.fromRGBO(77, 0, 114, 1),fontSize: 24),
            )

          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: navbar(),
      appBar: AppBar(title: Text("VENUES",style: TextStyle(fontFamily: 'Arimo',color: Colors.white,fontSize:15,fontWeight: FontWeight.bold),
      ),
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20),),),
      ),

      body:SingleChildScrollView(
        child:Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 6,),
          ibbutton,
          SizedBox(height: 6,),
          asbutton,
          SizedBox(height: 6,),
          sfbutton,
          SizedBox(height: 6,),
          mechbutton,
          SizedBox(height: 6,),
          libbutton,
          SizedBox(height: 6,),
          audibutton,

        ],
          ),
      ),
      ),
      );

  }
  Future<void> logout(BuildContext context) async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SignInscrn()));
  }
}

