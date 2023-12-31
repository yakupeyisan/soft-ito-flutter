import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soft_ito_fake_api/models/post.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Fake Api',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Fake Api'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> _postList = [];
  String _error="";
  Future<void> _fetchData() async{
    try{
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      setState(() {
        _error='';
        List<dynamic> jsonList = jsonDecode(response.body);
        var posts = jsonList.map((json) => Post.fromJson(json)).toList();
        _postList=posts;
      });
    }catch(e){
      setState(() {
        _postList=[];
        _error='Error: $e';

      });
    }
  }
  Future<void> _postData() async {
  String res="";
    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        body: {'title': 'Add ', 'body': 'Post Request', 'userId': '1'},
      );

      res=response.body;
      setState(() {
        _error="";
        Map<String, dynamic> map = jsonDecode(response.body);
        _postList = [Post.fromJson(map)];
      });

    } catch (e) {
      setState(() {
        _postList=[];
        _error='Error: $e $res';
      });
    }
  }
  Future<void> _putData() async {
    try {
      final response = await http.put(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/15'),
        body: {'id': '1', 'title': 'Update', 'body': 'Put Request', 'userId': '1'},
      );
      setState(() {
        _error='';
        Map<String, dynamic> map = jsonDecode(response.body);
        _postList = [Post.fromJson(map)];
      });

    } catch (e) {
      setState(() {
        _error='Error: $e';
        _postList=[];
      });
    }
  }
  Future<void> _deleteData() async {
    try {
      final response = await http.delete(Uri.parse('https://jsonplaceholder.typicode.com/posts/15'));
      setState(() {
        _error='';
        _postList = [Post(0,0,"Delete successfull","")];
      });

    } catch (e) {
      setState(() {
        _error='Error: $e';
        _postList=[];
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text('Fake Api Request'),

      ),

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[

            ElevatedButton(

              onPressed: _fetchData,

              child: Text('GET Request'),

            ),

            ElevatedButton(

              onPressed: _postData,

              child: Text('POST Request'),

            ),

            ElevatedButton(

              onPressed: _putData,

              child: Text('PUT Request'),

            ),

            ElevatedButton(

              onPressed: _deleteData,

              child: Text('DELETE Request'),

            ),

            SizedBox(height: 20),
            Text(_error),
            Container(
              height: 220,
              child: ListView.builder(itemCount: _postList.length, itemBuilder: (context,i){
              final post = _postList[i];
              return Card(
                  color: Colors.amber[100],
                  child: Padding(
                  padding: EdgeInsets.all(1),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Id     : "+post.id.toString()),
                        Text("User Id: "+post.userId.toString()),
                        Text("Title  : "+post.title),
                        Text("Body   : "+post.body),
                        ]
                  )
                )
              );
            },)

            )
          ],

        ),

      ),

    );  }
}
