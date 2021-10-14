import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simple_library/templates/custom_show_dialog.dart';

class ReadBook extends StatefulWidget {
  String url;
  String title;
  ReadBook({@required this.url, @required this.title, Key key})
      : super(key: key);

  @override
  _ReadBookState createState() => _ReadBookState();
}

class _ReadBookState extends State<ReadBook> {
  PDFDocument document;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    setState(() {
      isLoading = true;
    });

    document = await PDFDocument.fromURL(widget.url);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: (isLoading) ? SizedBox() : PDFViewer(document: document),
      ),
    );
  }
}
