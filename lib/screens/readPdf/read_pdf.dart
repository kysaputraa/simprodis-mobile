import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ReadPdf extends StatefulWidget {
  String? file;
  String? link;
  ReadPdf({super.key, this.file, this.link});

  @override
  _ReadPdf createState() => _ReadPdf();
}

class _ReadPdf extends State<ReadPdf> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? baseUrl = dotenv.env['BASE_URL_HOME'];
    print('${baseUrl}${widget.link}${widget.file}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        '${baseUrl}${widget.link}${widget.file}',
        key: _pdfViewerKey,
      ),
    );
  }
}
