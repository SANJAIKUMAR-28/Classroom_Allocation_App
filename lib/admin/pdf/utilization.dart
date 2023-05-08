import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newlogin/admin/pdf/report.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
class utilization extends StatefulWidget {
  const utilization({Key? key}) : super(key: key);

  @override
  State<utilization> createState() => _utilizationState();
}

class _utilizationState extends State<utilization> {
  final  clsController = TextEditingController();
  final  fromdateController= TextEditingController();
  final  todateController =TextEditingController();
  Query dbRef = FirebaseDatabase.instance.ref().child('REQUEST');
  static final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("UTILIZATION",style: TextStyle(fontFamily: 'Arimo',color: Colors.white,fontSize:15,fontWeight: FontWeight.bold),),
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20),),),
      ),
        body:SingleChildScrollView(
            child: Container(
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Form(
                        key: _formkey,
                        child: Column(
                            children: [
                              /*DropdownButtonFormField(
                decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                labelText: "Select Class",
                labelStyle: TextStyle(
                    fontFamily: 'Arimo', color: Color.fromRGBO(77, 0, 114, 1)),
              ),
              value: '${request['CLASS NAME'][0]}',
              icon: const Icon(Icons.keyboard_arrow_down),
              validator: (value) => value == null ? 'Select Yes or No' : null,
              items: (drop(request['CLASS NAME'])).map((String yesorno){
      return DropdownMenuItem(
      value:yesorno,

      child:Text(yesorno,style: TextStyle(fontWeight: FontWeight.w900,fontFamily: 'Arimo',color: Color.fromRGBO(77,0,114,1),fontSize: 15)),
      );
      }).toList(), onChanged: (String? value) {},


    ),*/
                              TextFormField(
                                autofocus: false,
                                controller: clsController,
                                style: TextStyle(fontFamily: 'Arimo'),
                                keyboardType: TextInputType.text,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return("Please enter class name");
                                  }
                                  return null;
                                },
                                onSaved: (value)
                                {
                                  clsController.text=value!;
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  prefixIcon:Icon(Icons.school,color: Color.fromRGBO(77,0,114,1),),
                                  contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
                                  hintText: "Class name",
                                  hintStyle: TextStyle(fontFamily: 'Arimo'),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
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
                              SizedBox(height: 380,),
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
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            report(clsname:clsController.text.toUpperCase(), frmdate: fromdateController.text.toString(), todate: todateController.text.toString())));
      }
      },
                                  child: Text("GENEARTE REPORT",textAlign: TextAlign.center,
                                    style:TextStyle(fontSize: 15,fontFamily: 'Arimo',color: Colors.white,fontWeight: FontWeight.bold) ,
                                  ),
                                ),
                              ),
                            ]
                        )
                    )
                )
            )
        )
        );

  }
  /*List<String> drop(String names){
    final List<String> Name = [names];
    return Name;
  }*/
}
