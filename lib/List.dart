import 'package:flutter/material.dart';
import 'package:myanmar_dica_law_2/pdf_viewer.dart';

class ListScreen extends StatefulWidget {
  final List testList;

  const ListScreen({this.testList});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: widget.testList.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              print(
                  "${widget.testList[index].id}+${widget.testList[index].name}+${widget.testList[index].pdfname}+${widget.testList[index].path}");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PdfViewer(
                            pdf: widget.testList[index].pdfname,
                            title: widget.testList[index].name,
                            path: widget.testList[index].path,
                          )));
              print(widget.testList[index].pdfname);
            },
            trailing: Text("${widget.testList[index].id}"),
            title: Text(widget.testList[index].name),
          );
        },
      ),
    );
  }
}
