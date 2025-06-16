import 'package:flutter/cupertino.dart';
import 'package:rest_api_crud_app/model/expense_tracker/transaction_model.dart';

class TransactionViewModel with ChangeNotifier {
  final List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  double get totalIncome => _transactions
      .where((element) => element.isIncome)
      .fold(0, (previousValue, element) => previousValue + element.amount);

  double get totalExpense => _transactions
      .where((element) => !element.isIncome)
      .fold(0, (previousValue, element) => previousValue + element.amount);

  double get remainingBalance => totalIncome - totalExpense;

  void addTransacation(String title, double amount, bool isIncome) {
    TransactionModel currTransaction = TransactionModel(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
      isIncome: isIncome,
    );
    //_transactions.add(currTransaction);
    _transactions.insert(0, currTransaction);
    notifyListeners();
  }

  void removeTransaction(String id) {
    _transactions.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
