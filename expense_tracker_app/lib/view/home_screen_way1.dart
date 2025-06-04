import 'package:expense_tracker_app/provider/transaction_provider.dart';
import 'package:expense_tracker_app/view/add_transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreenWay1 extends StatelessWidget {
  const HomeScreenWay1({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    final transactions = provider.transactions;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTransactionScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Recent Transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: transactions.isEmpty
                    ? const Center(
                        child: Text(
                          'No transactions yet\nAdd your first transaction above!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final tx = transactions[index];
                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    tx.isIncome ? Colors.green : Colors.red,
                                child: Icon(
                                  tx.isIncome
                                      ? Icons.arrow_downward
                                      : Icons.arrow_upward,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(tx.title),
                              subtitle:
                                  Text('${tx.date.toLocal()}'.split(' ')[0]),
                              trailing: Text(
                                '${tx.isIncome ? '+' : '-'}\$${tx.amount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color:
                                      tx.isIncome ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
