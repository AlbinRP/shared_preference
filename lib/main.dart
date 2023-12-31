import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SharedPreferences',
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _sharedPrefrencesTextValue = new TextEditingController();
  String _savedData = "";
  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  _loadSavedData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? savedData = sharedPreferences.getString('data');
    setState(() {
      if (savedData != null && savedData.isNotEmpty) {
        _savedData = savedData;
      } else {
        _savedData = "Empty SP";
      }
    });
  }

  _saveData(String message) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("data", message);

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('SharedPreferences'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),

      body: new Container(
        padding: const EdgeInsets.all(13.4),
        alignment: Alignment.topCenter,
        child: new ListTile(
          title: new TextField(
            controller: _sharedPrefrencesTextValue,
            decoration: new InputDecoration(labelText: 'Write Something'),
          ),
          subtitle: TextButton(
            onPressed: () {
              _saveData(_sharedPrefrencesTextValue.text);
            },
            child: Column(
              children: <Widget>[
                Text('Save Data'),
                Padding(padding: EdgeInsets.all(14.5)),
                Text(_savedData),
              ],
            ),
          )
        ),
      ),

    );
  }
}