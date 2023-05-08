/*import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newlogin/admin/pdf/pdf.dart';
import 'package:newlogin/model/data_model.dart';
import 'package:printing/printing.dart';

class pdfpreview extends StatelessWidget {
  final String name;
  final String frm;
  final String to;
  const pdfpreview({Key? key, required this.name, required this.frm, required this.to,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PREVIEW", style: TextStyle(
        fontFamily: 'Arimo',
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.bold),),
    centerTitle: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(20),
    bottomRight: Radius.circular(20),),),
    ),
      body: PdfPreview(
        build: (context) => makePdf(this.name,this.frm,this.to,),
      ),
    );
  }
}
*/
