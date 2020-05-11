import 'package:bloackchainapp/main.dart';

var transactions = new Map();
List<String> info = new List(4);
addTransaction(sender, receiver, amount){
  var hashcode = hash("123").toString();
  info[0] = sender;
  info[1] = receiver;
  info[2] = amount;
  info[3] = hashcode;
  print(info);
  //transactions['${transactions.length}'] =
}