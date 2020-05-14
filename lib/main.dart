import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/widgets.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr/qr.dart';
//import 'package:qrscan/qrscan.dart' as scanner;
import 'package:bloackchainapp/transactions.dart';
import 'package:bloackchainapp/users.dart';

void main() => runApp(MyApp());


hash(foo) => sha256.convert(utf8.encode(foo));

//hash(foo) => sha256.convert(utf8.encode("${sha256.convert(utf8.encode(foo))}"));

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
  final myController3= TextEditingController(text: 'user');
  final myController4= TextEditingController(text: '0');

  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController1.dispose();
    myController2.dispose();
    myController3.dispose();
    myController4.dispose();
    super.dispose();}

  qrScan() async{
    print('ok');
//    String cameraScanResult = await scanner.scan();
//    this.myController3.text = cameraScanResult;
    showDialog(context: context, builder: (BuildContext context) {
      return SimpleDialog(
          title: Text('Confirm transaction.', style: TextStyle(color: Colors.white)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                controller: myController3,
                obscureText: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Address'),)
            ),
           Padding(
             padding: EdgeInsets.all(15),
             child: TextFormField(
               controller: myController4,
               keyboardType: TextInputType.number,
               obscureText: false,
               decoration: InputDecoration(
                   border: OutlineInputBorder(),
                   labelText: 'Amount'),)
           ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: FloatingActionButton(
                onPressed: addTransaction(myController1.text, myController3.text, myController4.text),
                tooltip: 'Authorize!',
                child: Icon(Icons.check_circle_outline, color: Colors.white,),
              ),
            )
          ]
      );
    },
    );
    }


  authorize(){
    var username = myController1.text;
    var password = hash(myController2.text).toString();
    if(users.containsKey(username) && password == users[username][0]){choice();}}


  qrGen(){
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
                  icon: Icon(Icons.arrow_upward), onPressed: () {qrScan();},),
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