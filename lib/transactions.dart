import 'package:bloackchainapp/main.dart';
import 'package:bloackchainapp/users.dart';

List<List<String>> transactions = [['initial', 'initial', '0', 'initial']];
addTransaction(sender, receiver, amount){
  List<String> info = [];
  info.clear();
  amount = int.parse(amount);
  var senderBalance = 0;
  var receiverBalance = 0;
  senderBalance = int.parse(users[sender][1]);
  receiverBalance = int.parse(users[receiver][1]);
  if(amount is int && senderBalance != null){
    if(users.containsKey(sender) && users.containsKey(receiver) && (senderBalance >= amount)) {
      var prevBlock = '';
      for (var item in transactions[transactions.length -1]){
        prevBlock += item;
      }
      print('PREVIOUS = $prevBlock');
      var hashcode = hash(prevBlock).toString();
      info.addAll([sender, receiver, amount.toString(), hashcode]);
      users[sender][1] = (senderBalance - amount).toString();
      users[receiver][1] = (receiverBalance + amount).toString();
      print('info = $info');
      transactions.add(info);
      print('ALL = $transactions');
      print('USERS = $users');
    }
  }
}