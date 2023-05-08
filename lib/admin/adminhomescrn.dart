import 'package:flutter/material.dart';
import 'package:newlogin/admin/addclass.dart';
import 'package:newlogin/admin/adminhistory.dart';
import 'package:newlogin/admin/requestscrn.dart';
import 'package:newlogin/admin/scheduledbook.dart';
import 'dashboard.dart';
import 'editclass.dart';

class adminhome extends StatefulWidget {
  const adminhome({Key? key}) : super(key: key);

  @override
  State<adminhome> createState() => _adminhomeState();
}

class _adminhomeState extends State<adminhome> {
  @override
  Widget build(BuildContext context) {
    final addclass = Material(
      elevation: 5,
      color: Color.fromRGBO(77, 0, 114, 1),
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10,15,10,15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>addingclass()));

        },
        child: Column(
          children: [
            SizedBox(height: 6,
            child: Icon(Icons.add_circle,color: Colors.white,size: 70,),
            ),
            SizedBox(height: 70,),
            Text('ADD CLASS',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Arimo',color: Colors.white,fontSize: 17),),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
    final reqbtn = Material(
      elevation: 5,
      color: Color.fromRGBO(77, 0, 114, 1),
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10,15,10,15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>approval()));

        },
        child: Column(
          children: [
            SizedBox(height: 6,
              child: Icon(Icons.check_circle_rounded,color: Colors.white,size: 70,),
            ),
            SizedBox(height: 70,),
            Text('ACCEPT/REJECT REQ',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Arimo',color: Colors.white,fontSize: 17),),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
    final editbtn = Material(
      elevation: 5,
      color: Color.fromRGBO(77, 0, 114, 1),
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10,15,10,15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>editcls()));
        },
        child: Column(
          children: [
            SizedBox(height: 6,
              child: Icon(Icons.edit_outlined,color: Colors.white,size: 60,),
            ),
            SizedBox(height: 70,),
            Text('EDIT/VIEW CLASS',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Arimo',color: Colors.white,fontSize: 17),),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
    final historybtn = Material(
      elevation: 5,
      color: Color.fromRGBO(77, 0, 114, 1),
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10,15,10,15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>adminhtry()));

        },
        child: Column(
          children: [
            SizedBox(height: 6,
              child: Icon(Icons.history,color: Colors.white,size: 60,),
            ),
            SizedBox(height: 70,),
            Text('HISTORY',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Arimo',color: Colors.white,fontSize: 17),),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
    final scheduledbtn = Material(
      elevation: 5,
      color: Color.fromRGBO(77, 0, 114, 1),
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10,15,10,15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>scheduledbook()));
        },
        child: Column(
          children: [
            SizedBox(height: 6,
              child: Icon(Icons.edit_calendar_sharp,color: Colors.white,size: 60,),
            ),
            SizedBox(height: 70,),
            Text('SCHEDULED BOOKING',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Arimo',color: Colors.white,fontSize: 17),),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
    final dashboarddbtn = Material(
      elevation: 5,
      color: Color.fromRGBO(77, 0, 114, 1),
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10,15,10,15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          
        },
        child: Column(
          children: [
            SizedBox(height: 6,
              child: Icon(Icons.dashboard_outlined,color: Colors.white,size: 60,),
            ),
            SizedBox(height: 70,),
            Text('DASHBOARD',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Arimo',color: Colors.white,fontSize: 17),),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("ADMIN",style: TextStyle(fontFamily: 'Arimo',color: Colors.white,fontSize:15,fontWeight: FontWeight.bold),
      ),
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20),),),
      ),
      body:SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            reqbtn,
            SizedBox(height: 20,),
            editbtn,
            SizedBox(height: 20,),
            historybtn,
            SizedBox(height: 20,),
            addclass,
            SizedBox(height: 20,),
            scheduledbtn,
        ],
      ),
    ),
      ),
    );
  }
}
