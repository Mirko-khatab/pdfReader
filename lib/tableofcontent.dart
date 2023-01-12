import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:newapp2/main.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Table_ofContent extends StatefulWidget {
  const Table_ofContent({super.key});

  @override
  State<Table_ofContent> createState() => _Table_ofContentState();
}

class _Table_ofContentState extends State<Table_ofContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: SfPdfViewer.network(
                'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
                canShowScrollHead: false,
                canShowScrollStatus: false)));
  }
}
