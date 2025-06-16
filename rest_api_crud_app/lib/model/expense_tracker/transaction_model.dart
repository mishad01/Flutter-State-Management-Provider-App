class TransactionModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final bool isIncome;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.isIncome,
  });
}
