import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_plugin.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:pdf/pdf.dart';

class Pdf_Viewer extends StatelessWidget {
  final String path;
  const Pdf_Viewer({Key key, this.path}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.pink[200],
        centerTitle: true,
        title: new Text("Nota"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          )
        ],
      ),
      path: path,
    );
    // return 
  }
}

// PDFDocument _generateDocument(){
//   final pdf = new PDFDocument(deflate: zlib.encode);
//   final page = new PDFPage(pdf, pageFormat: PDFPageFormat.a4);
//   final gnrte = page.getGraphics();
//   final font = new PDFFont(pdf);
//   final top = page.pageFormat.height;

//   gnrte.setColor(new PDFColor(0.0, 1.0, 1.0));
//   gnrte.setColor(new PDFColor(0.3, 0.3, 1.3));

//   for (var prop in word){
//     height += 20.0;
//     gnrte.drawString(font, 30.0, prop, 10.0 * PDFPageFormat.MM, top - (height+20.0)*PDFPageFormat.MM);

//   }
//   return pdf;

// }