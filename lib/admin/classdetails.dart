import 'package:flutter/material.dart';
import 'package:newlogin/admin/pdf/report.dart';
import 'package:newlogin/screens/holdings.dart';
import 'package:intl/intl.dart';
class classdetails extends StatefulWidget {
  final String clsname;
  const classdetails({Key? key, required this.clsname}) : super(key: key);

  @override
  State<classdetails> createState() => _classdetailsState();
}

class _classdetailsState extends State<classdetails> {
  final  fromdateController= TextEditingController();
  final  todateController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    final holdingsbtn = Material(
      elevation: 5,
      color: Color.fromRGBO(77, 0, 114, 1),
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10,15,10,15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>holdings(clsname: widget.clsname)));
        },
        child: Column(
          children: [
            SizedBox(height: 6,
              child: Icon(Icons.contact_page_outlined,color: Colors.white,size: 50,),
            ),
            SizedBox(height: 50,),
            Text('HOLDINGS',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Arimo',color: Colors.white,fontSize: 17),),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
    final reportbtn = Material(
      elevation: 5,
      color: Color.fromRGBO(77, 0, 114, 1),
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10,15,10,15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: Text("Report", style: TextStyle(
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
                      onTap: ()async {
                        DateTime ? pickdate2 = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2050));
                        if (pickdate2 != null) {
                          setState(() {
                            fromdateController.text =
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

                        fromdateController.text=value!;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon:Icon(Icons.date_range,color: Color.fromRGBO(77,0,114,1),),
                        suffixIcon: Icon(Icons.arrow_drop_down,color: Color.fromRGBO(77,0,114,1),),
                        contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                        hintText: "FROM date",
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
                      onTap: ()async {
                        DateTime ? pickdate2 = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2050));
                        if (pickdate2 != null) {
                          setState(() {
                            todateController.text =
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
                        todateController.text=value!;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon:Icon(Icons.date_range,color: Color.fromRGBO(77,0,114,1),),
                        suffixIcon: Icon(Icons.arrow_drop_down,color: Color.fromRGBO(77,0,114,1),),
                        contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                        hintText: "TO date",
                        hintStyle: TextStyle(fontFamily: 'Arimo'),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>report(clsname: widget.clsname, frmdate: fromdateController.text, todate:todateController.text)));
                },
                    child: const Text('Generate', style: TextStyle(
                        fontFamily: 'Arimo',
                        color: Color.fromRGBO(8, 47, 72, 1),
                        fontWeight: FontWeight.bold)))
              ],
            );
          },
          );
        },
        child: Column(
          children: [
            SizedBox(height: 6,
              child: Icon(Icons.print,color: Colors.white,size: 50,),
            ),
            SizedBox(height: 50,),
            Text('UTILIZATION REPORT',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Arimo',color: Colors.white,fontSize: 17),),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("DETAILS",style: TextStyle(fontFamily: 'Arimo',color: Colors.white,fontSize:15,fontWeight: FontWeight.bold),
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
              holdingsbtn,
              SizedBox(height: 20,),
              reportbtn,

            ],
          ),
        ),
      ),
    );;
  }
}
