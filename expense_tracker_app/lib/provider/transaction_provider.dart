import 'package:expense_tracker_app/model/transaction.dart';
import 'package:flutter/widgets.dart';

class TransactionProvider with ChangeNotifier {
  final List<Transaction> _transactions = [];
  List<Transaction> get transactions => _transactions;

  //for calculating total income
  double get totalIncome => _transactions
      .where((tx) => tx.isIncome)
      .fold(0, (sum, tx) => sum + tx.amount);

  //for calculating total expense
  double get totalExpense => _transactions
      .where((tx) => !tx.isIncome) //Here !tx.isIncome means not isIncome
      .fold(0, (sum, tx) => sum + tx.amount);

  //for remaining balance
  double get remainingBalance => totalIncome - totalExpense;

  //method to add new transaction

  void addTransaction(
    String title,
    double amount,
    DateTime date,
    bool isIncome,
  ) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
      isIncome: isIncome,
    );
    _transactions.insert(0, newTransaction);
    notifyListeners();
  }

  void removeTransaction(String id) {
    _transactions.removeWhere((tx) => tx.id == id);
    notifyListeners();
  }
}
