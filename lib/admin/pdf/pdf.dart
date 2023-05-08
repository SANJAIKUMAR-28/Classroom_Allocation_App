import 'dart:async';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:newlogin/model/data_model.dart';
import 'package:pdf/widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

Future<Uint8List> makePdf(String name,String from,String to) async {
  final pdf = Document();
  final imageLogo = MemoryImage((await rootBundle.load('assets/bitlogo.png')).buffer.asUint8List());
  pdf.addPage(
    Page(
      build: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("CLASS NAME: ${name}",style: TextStyle(fontWeight:FontWeight.bold)),
                    Text("FROM: ${from}",style: TextStyle(fontWeight:FontWeight.bold)),
                    Text("TO: ${to}",style: TextStyle(fontWeight:FontWeight.bold)),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image(imageLogo),
                )
              ],
            ),
            Container(height: 10),
            /*Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    Padding(
                      child: Text(
                        'INVOICE FOR PAYMENT',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                  ],
                ),
                ...data.keys.map(
                      (e) => TableRow(
                    children: [
                      Expanded(
                        child: PaddedText(e.description),
                        flex: 2,
                      ),
                      Expanded(
                        child: PaddedText("\$${e.cost}"),
                        flex: 1,
                      )
                    ],
                  ),
                ),
                TableRow(
                  children: [
                    PaddedText('TAX', align: TextAlign.right),
                    PaddedText('\$${(invoice.totalCost() * 0.1).toStringAsFixed(2)}'),
                  ],
                ),
                TableRow(
                  children: [PaddedText('TOTAL', align: TextAlign.right), PaddedText('\$${(invoice.totalCost() * 1.1).toStringAsFixed(2)}')],
                )
              ],
            ),
            Padding(
              child: Text(
                "THANK YOU FOR YOUR CUSTOM!",
                style: Theme.of(context).header2,
              ),
              padding: EdgeInsets.all(20),
            ),
            Text("Please forward the below slip to your accounts payable department."),
            Divider(
              height: 1,
              borderStyle: BorderStyle.dashed,
            ),*/
            Container(height: 20),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    Text('  Faculty Name',style: TextStyle(fontWeight: FontWeight.bold,)),
                    Text('  From',style: TextStyle(fontWeight: FontWeight.bold,)),
                    Text('  To',style: TextStyle(fontWeight: FontWeight.bold,)),
                    Text('  Description',style: TextStyle(fontWeight: FontWeight.bold,)),
                  ],
                ),
                /*TableRow(
                  children: [
                    PaddedText(
                      'Account Name',
                    ),
                    PaddedText(
                      'ADAM FAMILY TRUST',
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Total Amount to be Paid',
                    ),

                  ],
                )*/
              ],
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                'Bannari Amman Institute Of Technology',
                style: Theme.of(context).header3.copyWith(
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        );
      },
    ),
  );
  return pdf.save();
}

Widget PaddedText(
    final String text, {
      final TextAlign align = TextAlign.left,
    }) =>
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
      ),
    );




