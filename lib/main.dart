import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blockchain App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black26,
        accentColor: Colors.black12,
        buttonTheme: ButtonThemeData(
            buttonColor: Colors.black,
            shape: StadiumBorder(),
            textTheme: ButtonTextTheme.accent),
        appBarTheme: AppBarTheme(color: Colors.black45),
        primaryTextTheme: TextTheme(
            title: TextStyle(color: Colors.white, fontSize: 26),
            headline: TextStyle(color: Colors.white, fontSize: 40))),
      home: MyHomePage(title: 'Blackchain App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _authorize(){
    final checksum = '2e3d1a2d696a4ce5de7da89ba5755dc5df79f071daa3a9f4166569cecc3353c1';
    var firstChunk = utf8.encode(Text(myController1.text).toString());
    var secondChunk = utf8.encode(Text(myController2.text).toString());
    var output = new AccumulatorSink<Digest>();
    var input = sha256.startChunkedConversion(output);
    input.add(firstChunk);
    input.add(secondChunk); // call `add` for every chunk of input data
    input.close();
    var digest = output.events.single;
  }
  final myController1= TextEditingController();
  final myController2= TextEditingController();
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController1.dispose();
    myController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('And who are you?', style: Theme.of(context).textTheme.title),
            TextField(
              controller: myController1,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Login'),),
            TextField(
              controller: myController2,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',),)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _authorize,
        tooltip: 'Authorize me!',
        child: Icon(Icons.check_circle_outline, color: Colors.white,),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
