import 'package:flutter/material.dart';

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
        itemCount: widget.testList.length,
        itemBuilder: (context, index) {
          return ListTile(
            trailing: Text("${widget.testList[index].id}"),
            title: Text(widget.testList[index].name),
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }
}
