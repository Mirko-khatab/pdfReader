import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'SearchToolbarState.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CustomSearchPdfViewer(),
  ));
}

/// Represents the Homepage for navigation.
class CustomSearchPdfViewer extends StatefulWidget {
  @override
  CustomSearchPdfViewerState createState() => CustomSearchPdfViewerState();
}

class CustomSearchPdfViewerState extends State<CustomSearchPdfViewer> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  final GlobalKey<SearchToolbarState> _textSearchKey = GlobalKey();

  bool? _showToast;
  bool? _showScrollHead;
  bool? _showSearchToolbar;

  // Ensure the entry history of text search.
  LocalHistoryEntry? _localHistoryEntry;

  @override
  void initState() {
    _showToast = false;
    _showScrollHead = true;
    _showSearchToolbar = false;
    super.initState();
  }

  void _ensureHistoryEntry() {
    if (_localHistoryEntry == null) {
      final ModalRoute<Object?>? route = ModalRoute.of(context);
      if (route != null) {
        _localHistoryEntry =
            LocalHistoryEntry(onRemove: _handleHistoryEntryRemoved);
        route.addLocalHistoryEntry(_localHistoryEntry!);
      }
    }
  }

  void _handleHistoryEntryRemoved() {
    _textSearchKey?.currentState?.clearSearch();
    setState(() {
      _showSearchToolbar = false;
      _localHistoryEntry != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showSearchToolbar!
          ? AppBar(
              flexibleSpace: SafeArea(
                child: SearchToolbar(
                  key: _textSearchKey,
                  showTooltip: true,
                  controller: _pdfViewerController,
                  onTap: (Object toolbarItem) async {
                    if (toolbarItem.toString() == 'Cancel Search') {
                      setState(() {
                        _showSearchToolbar = false;
                        _showScrollHead = true;
                        if (Navigator.canPop(context)) {
                          Navigator.maybePop(context);
                        }
                      });
                    }
                    if (toolbarItem.toString() == 'onSubmit') {
                      setState(() {
                        _showToast = true;
                      });
                      await Future.delayed(Duration(seconds: 2));
                      setState(() {
                        _showToast = false;
                      });
                    }
                  },
                ),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: Color(0xFFFAFAFA),
            )
          : AppBar(
              title: Text(
                'Syncfusion Flutter PDF Viewer',
                style: TextStyle(color: Colors.black87),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    setState(() {
                      _showScrollHead = false;
                      _showSearchToolbar = true;
                      _ensureHistoryEntry();
                    });
                  },
                ),
              ],
              automaticallyImplyLeading: false,
              backgroundColor: Color(0xFFFAFAFA),
            ),
      body: Stack(
        children: [
          SfPdfViewer.network(
            'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
            controller: _pdfViewerController,
            canShowScrollHead: _showScrollHead!,
          ),
          Visibility(
            visible: _showToast!,
            child: Align(
              alignment: Alignment.center,
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.only(left: 15, top: 7, right: 15, bottom: 7),
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                    child: Text(
                      'No matches found',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
