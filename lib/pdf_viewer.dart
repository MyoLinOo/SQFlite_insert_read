import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatefulWidget {
  final String pdf;
  final String title;
  final String path;

  PdfViewer({this.pdf, this.title, this.path});
  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  if (widget.pdf != null) {
                    // _shareMixed();
                  }
                })
          ],
          title: Text("${widget.title}"),
        ),
        body: widget.path != null
            ? SfPdfViewer.asset("${widget.path}/${widget.pdf}")
            : SfPdfViewer.asset("${widget.pdf}"));
  }

  // Future<void> _shareMixed() async {
  //   try {
  //     if (widget.pdf != null) {
  //       final ByteData bytes = await rootBundle.load("assets/${widget.pdf}");
  //       await Share.file('esys image', "${widget.pdf}",
  //           bytes.buffer.asUint8List(), 'assets/pdf');
  //     }
  //   } catch (e) {
  //     print('error: $e');
  //   }
  // }
}
