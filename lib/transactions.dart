import 'package:bloackchainapp/main.dart';
import 'package:bloackchainapp/users.dart';

List<List<String>> transactions = [['initial', 'initial', '0', 'initial']];
List<String> info = new List(4);
addTransaction(sender, receiver, amount){
  print(amount);
  print(amount.runtimeType);
  amount = int.parse(amount);
  var senderAmount = 0;
  senderAmount = int.parse(users[sender][1]);
  if(amount is int && senderAmount != null){
    if(users.containsKey(sender) && users.containsKey(receiver) && (senderAmount >= amount)) {
      var prevBlock = '';
      for (var transaction in transactions){
        for (var item in transaction){
          prevBlock += item;
        }
      }
      print(prevBlock);
      var hashcode = hash(prevBlock).toString();
      info[0] = sender;
      info[1] = receiver;
      info[2] = amount.toString();
      info[3] = hashcode;
      print(info);
      transactions.add(info);
      print(transactions);
    }
  }
}