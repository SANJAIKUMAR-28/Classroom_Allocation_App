
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart' as db;
import 'package:firebase_database/ui/firebase_animated_list.dart';
/*import 'package:newlogin/admin/pdf/pdf.dart';
import 'package:newlogin/admin/pdf/pdfpreview.dart';
import 'package:newlogin/screens/responsescrn.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';*/
class report extends StatefulWidget {
  final String clsname;
  final String frmdate;
  final String todate;
  const report({Key? key, required this.clsname, required this.frmdate, required this.todate}) : super(key: key);

  @override
  State<report> createState() => _reportState();
}

class _reportState extends State<report> {
  db.Query dbRef = db.FirebaseDatabase.instance.ref().child('REQUEST');

  Widget listItem({required Map request}) {
    return SingleChildScrollView(
          child:((widget.clsname==request['CLASS NAME'])&& ((date(request['FROM DATE'])==date(widget.frmdate)&&day(request['FROM DATE'])>=day(widget.frmdate))&&(date(request['TO DATE'])==date(widget.todate)&&day(request['TO DATE'])<=day(widget.todate))))?
        Container(
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
              ],
            ),
          ):null,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("REPORT", style: TextStyle(
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
        ),

        /*floatingActionButtonLocation:` FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton:FloatingAct`ionButton(onPressed: (){
          Navigator.push(context,MaterialPageRoute(
              builder : (context) => pdfpreview(name: widget.clsname, frm: widget.frmdate, to: widget.todate))
          );
        },
        backgroundColor: Color.fromRGBO(77,0,114,1),
    child: const Icon(Icons.picture_as_pdf,color: Colors.white,),
    ),*/
    );
  }
  int day(String day){
    final Day = day;
    String slice= Day.substring(0,2) ;
    var num1=int.parse(slice);
    return num1;
  }
  int date(String date){
    final Date = date;
    String slice= Date.substring(3,5) ;
    var num=int.parse(slice);
    return num;
  }

}
