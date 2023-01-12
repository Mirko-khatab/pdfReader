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

Key? PageStorageKey;

class CustomSearchPdfViewerState extends State<CustomSearchPdfViewer> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  final GlobalKey<SearchToolbarState> _textSearchKey = GlobalKey();

  bool? _showToast;
  bool? _showScrollHead;
  bool? _showSearchToolbar;
  bool? showAppBar;

  int? pageNum;

  // Ensure the entry history of text search.
  LocalHistoryEntry? _localHistoryEntry;

  var boolTrue;

  @override
  void initState() {
    _showToast = false;
    _showScrollHead = true;
    _showSearchToolbar = false;
    showAppBar = false;

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
      appBar: showAppBar!
          ? (_showSearchToolbar!
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
                  backgroundColor: Color.fromARGB(255, 68, 54, 227),
                )
              : AppBar(
                  backgroundColor: Color.fromARGB(255, 68, 54, 227),
                  actions: [
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width * 0.07,
                      ),
                      onPressed: () {
                        setState(() {
                          _showScrollHead = false;
                          _showSearchToolbar = true;
                          _ensureHistoryEntry();
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.grid_3x3_sharp,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width * 0.07,
                      ),
                      onPressed: () {},
                    ),
                  ],
                  automaticallyImplyLeading: false,
                ))
          : null,
      body: Stack(
        children: [
          SfPdfViewer.asset(
            'assets/leson.pdf',
            controller: _pdfViewerController,
            canShowScrollHead: _showScrollHead!,
            canShowPaginationDialog: true,
            key: PageStorageKey,
            // key: pageNum,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                showAppBar = !showAppBar!;
                print('its workoing');
              });
            },
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
