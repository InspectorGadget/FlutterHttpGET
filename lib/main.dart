import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String url = "https://swapi.co/api/people/?page=2";
  List data;

  @override
  void initState() {
    getJSONData();
    super.initState();
  }

  Future getJSONData() async {
    var response = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrieve JSON via HTTP GET')
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Text(data[index]["name"]),
                          Text("Gender: ${data[index]['gender'] == "n/a" ? "Not Specified" : data[index]["gender"].toString().toUpperCase()}"),
                          SizedBox(height: 50.0)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}