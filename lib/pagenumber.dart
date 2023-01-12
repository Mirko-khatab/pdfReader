import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class PDFViewerPage extends StatefulWidget {
  // const PDFViewerPage(this.pdf, {Key? key}) : super(key: key);
  // final PDF pdf;

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  late PdfViewerController _pdfViewerController;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  PdfTextSearchResult? _searchResult;
  
  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("PDF Viewer"),
          actions: <Widget>[
            /* IconButton(
            icon: Icon(Icons.search, color: Colors.white,),
            onPressed: () async {
              _searchResult = await _pdfViewerController?.searchText('xu');
              setState(() {});
            },
          ),
          Visibility(
            visible: _searchResult?.hasResult ?? false,
            child: IconButton(icon: Icon(Icons.clear, color: Colors.white,),
              onPressed: () {
                setState(() {
                });
              },
            ),
          ),
          Visibility(
            visible: _searchResult?.hasResult ?? false,
            child: IconButton(icon: Icon(Icons.keyboard_arrow_up, color: Colors.white,),
              onPressed: () {
                _searchResult?.previousInstance();
              },
            ),
          ),
          Visibility(
            visible: _searchResult?.hasResult ?? false,
            child: IconButton(icon: Icon(Icons.keyboard_arrow_down, color: Colors.white,),
              onPressed: () {
                _searchResult?.nextInstance();
              },
            ),
          ),*/
            IconButton(
              icon: Icon(
                Icons.bookmark,
                color: Colors.white,
              ),
              onPressed: () {
                _pdfViewerKey.currentState?.openBookmarkView();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_up,
                color: Colors.white,
              ),
              onPressed: () {
                _pdfViewerController.previousPage();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
              onPressed: () {
                _pdfViewerController.nextPage();
              },
            )
          ],
        ),
        body: Container(
          child: SfPdfViewer.network('https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
              controller: _pdfViewerController,
              key: _pdfViewerKey,
              currentSearchTextHighlightColor: Colors.yellow,
              otherSearchTextHighlightColor: Colors.yellow.shade50),
        ));
  }
}

// reference https://pub.dev/packages/syncfusion_flutter_pdfviewer



class PDF {
  PDF(this.name, this.ref);

  String name;
  String ref;

  

}
