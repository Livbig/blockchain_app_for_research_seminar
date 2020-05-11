import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/widgets.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qrcode/qrcode.dart';
import 'package:qr/qr.dart';

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
    if(checkuser == username && checkpass == password){choice();}}
  qrGen(){
    print('yes');
    showDialog(context: context, builder: (BuildContext context){
      return SimpleDialog(
        title: Text('Your QR code.', style: TextStyle(color: Colors.black),),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: PrettyQr(
                //image: AssetImage('assets/blockchain.png'),
                typeNumber: 5,
                size: 250,
                data: '${hash("password")}',
                errorCorrectLevel: QrErrorCorrectLevel.M,
                roundEdges: true),
          ),
          ],
      );
    });
  }
  choice(){
    showDialog(context: context, builder: (BuildContext context){
      return SimpleDialog(
          title: const Text('Select one.'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {},
              child: FloatingActionButton.extended(
                  label: Text("Give"),
                  icon: Icon(Icons.arrow_upward), onPressed: () {},),
            ),
            SimpleDialogOption(
              onPressed: () {},
              child: FloatingActionButton.extended(
                  label: Text("Get"),
                  icon: Icon(Icons.arrow_downward), onPressed: () {qrGen();},),
            ),]
      );
    }
    );
  }

  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController1.dispose();
    myController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
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