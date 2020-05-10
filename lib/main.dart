import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Blockchain App',),
      title: 'Blockchain App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        accentColor: Colors.black,
        buttonTheme: ButtonThemeData(
            buttonColor: Colors.black,
            shape: StadiumBorder(),
            textTheme: ButtonTextTheme.accent),
        appBarTheme: AppBarTheme(color: Colors.black,
        textTheme: TextTheme(
            title: TextStyle(color: Colors.white, fontSize: 26),
            headline: TextStyle(color: Colors.white, fontSize: 40)))));
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
  final myController1= TextEditingController(text: "admin");
  final myController2= TextEditingController(text: "password");
  hash(foo) => sha256.convert(utf8.encode(foo));
  authorize(){
    final checkuser = hash("admin");
    final checkpass = hash("password");
    var username = hash(myController1.text);
    var password = hash(myController2.text);
    if(checkuser == username && checkpass == password){
      return SimpleDialog(
        title: const Text('Select one.'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () { Navigator.pop(context); },
            child: FloatingActionButton(
              child: Icon(Icons.arrow_downward),
            ),
          ),
          SimpleDialogOption(
            onPressed: () { Navigator.pop(context); },
            child: FloatingActionButton(
              child: Icon(Icons.arrow_upward),),
          ),
    ]);
    } else{
      print('no');
      print(hash("admin"));
      print(hash(myController1.text));
    }

  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController1.dispose();
    myController2.dispose();
    super.dispose();
  }}

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
            Padding(
              padding: EdgeInsets.only(left: 50, right: 50, top: 20),
              child:  TextFormField(
                controller: myController1,
                obscureText: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Login'),)
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 50, right: 50),
              child:  TextFormField(
                controller: myController2,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',),)
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child:
              FloatingActionButton(
              onPressed: authorize,
              tooltip: 'Authorize me!',
              child: Icon(Icons.check_circle_outline, color: Colors.white,),
            ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
