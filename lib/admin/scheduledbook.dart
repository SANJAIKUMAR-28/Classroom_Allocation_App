import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
class scheduledbook extends StatefulWidget {
  const scheduledbook({Key? key}) : super(key: key);

  @override
  State<scheduledbook> createState() => _scheduledbookState();
}

class _scheduledbookState extends State<scheduledbook> {
  String? filename;
  String? filecontent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("SCHEDULE BOOKING", style: TextStyle(
            fontFamily: 'Arimo',
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold),),
          centerTitle: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),),),
        ),
        body: Center(
        child:Container(
            decoration: BoxDecoration(
              color: Colors.white54,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
          height: 200,
          child:
              InkWell(
                onTap: () async {
                  fetchDataAndInsert();
                  Fluttertoast.showToast(msg: "File uploaded successfully !!");
                },
                child:
                    Column(
    children:[
           Icon(Icons.upload,size: 100,),
      Text("Upload excel sheet", style: TextStyle(
          fontFamily: 'Arimo',
          color:Color.fromRGBO(8,47,72,1),
          fontSize: 12,
          fontWeight: FontWeight.bold
      ),),
    ]
                    )
              )
          ),
        )
        );
  }
  Future<List<List<String>>> readExcelData() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      var bytes = await File(file.path!).readAsBytes();
      var excel = Excel.decodeBytes(bytes);
      var sheet = excel['Sheet1'];
      List<List<String>> data = [];
      for (var row in sheet.rows) {
        List<String> rowData = [];
        for (var cell in row) {
          rowData.add(cell!.value.toString());
        }
        data.add(rowData);
      }
      return data;
    } else {
      throw 'No file selected';
    }
  }
  Future<void> insertData(List<List<String>> data) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    for (var row in data) {
      var key = databaseReference.child('REQUEST').push().key;
      var newData = {'CLASS NAME': row[1], 'FACULTY NAME': row[2], 'FROM DATE': row[3],'TO DATE':row[4],'FROM TIME':row[5],'TO TIME':row[6],'DESCRIPTION':row[7],'ALTERNATE':'NILL','STATUS':'Accepted','REASON':'NILL','REMARKS':'NILL','NO OF STUDENTS':'50','LAST NAME':'A','VALUE':'2'};
      await databaseReference.child('REQUEST/$key').set(newData);
    }
  }
  void fetchDataAndInsert() async {
    List<List<String>> data = await readExcelData();
      await insertData(data);
  }

}
