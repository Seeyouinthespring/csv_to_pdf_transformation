import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pdf_widgets;

class PdfGenerator{

  static Future<String> createPdf(GlobalKey<State<StatefulWidget>> key) async {

    final doc = pdf_widgets.Document();
    final image = await WidgetWrapper.fromKey(
      key: key,
      pixelRatio: 2.0,
    );

    doc.addPage(
      pdf_widgets.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pdf_widgets.EdgeInsets.all(32),
        build: (pdf_widgets.Context context) {
          return pdf_widgets.Column(
            children: [
              pdf_widgets.Text('Results', style: pdf_widgets.TextStyle(fontSize: 28, fontWeight: pdf_widgets.FontWeight.bold)),
              pdf_widgets.Expanded(
                child: pdf_widgets.Image(image),
              ),
            ],
          );
        }
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/result.pdf");
    await file.writeAsBytes(await doc.save());
    return file.path;
  }
}