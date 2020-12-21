import 'dart:io';

import 'dart:typed_data';
import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myanmar_dica_law_2/List.dart';
import 'package:pdf_flutter/pdf_flutter.dart';

import 'Test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final idcontroller = TextEditingController();
  final controller = TextEditingController();
  final filecontroller = TextEditingController();
  

  File file;
  Future<File> imageFile;
  Image image;
  List<Tast> images;
  String pdfString = '';

  List<Tast> testList = [];
  Tast currentTast;
  TestHelper _testHelper = TestHelper();

  @override
  void initState() {
    super.initState();

    _testHelper = TestHelper();
  }

  _getfile(BuildContext context) async {
    try {
      File pickedFile = await FilePicker.getFile(
        allowedExtensions: ['pdf'],
        type: FileType.custom,
      );
      if (pickedFile != null) {
        setState(() {
          file = pickedFile;
          pdfString = file.path;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(FontAwesomeIcons.user),
        title: Text("DICA Law"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: idcontroller,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: controller,
            ),
          ),
          RaisedButton(
            onPressed: () {
              idcontroller.clear();
              controller.clear();
              file = null;
              currentTast = Tast(
                  id: int.parse(idcontroller.text),
                  name: controller.text,
                  pdfname: pdfString);
              _testHelper.insertTest(currentTast);
            },
            child: Text("Add"),
          ),
          SizedBox(height: 30),
          RaisedButton(
            onPressed: () async {
              List<Tast> list = await _testHelper.getAllTest();
              setState(() {
                testList = list;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListScreen(
                              testList: testList,
                            )));
              });
            },
            child: Text("get All Data"),
          ),
          RaisedButton(
            onPressed: () {
              _getfile(context);
            },
            child: Text("select file"),
          ),
          file != null
              ? PDF.file(
                  file,
                  height: 200,
                 width: double.infinity,
                )
              : Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey,
                  child: Center(child: Text("NoFile")),
                )
        ],
      ),
    );
  }
}
