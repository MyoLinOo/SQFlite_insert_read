import 'package:flutter/material.dart';
import 'package:myanmar_dica_law_2/List.dart';

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
  final controller = TextEditingController();

  List<Tast> testList = [];
  Tast currentTast;
  final TestHelper _testHelper = TestHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DICA Law"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: controller,
            ),
          ),
          RaisedButton(
            onPressed: () {
              currentTast = Tast(name: controller.text);
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
        ],
      ),
    );
  }
}
