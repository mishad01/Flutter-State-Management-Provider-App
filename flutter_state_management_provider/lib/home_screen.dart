import 'package:flutter/material.dart';
import 'package:flutter_state_management_provider/number_list_provider.dart';
import 'package:flutter_state_management_provider/second.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NumberListProvider>(
      builder: (context, numbersProviderModel, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              numbersProviderModel.add();
            },
            child: Icon(Icons.add),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                numbersProviderModel.numbers.isNotEmpty
                    ? numbersProviderModel.numbers.last.toString()
                    : "No numbers",
                style: TextStyle(fontSize: 30),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: numbersProviderModel.numbers.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          numbersProviderModel.numbers[index].toString(),
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          Second(), // if `Second` accepts numbers, update accordingly
                    ),
                  );
                },
                child: Text("Next Screen"),
              ),
            ],
          ),
        );
      },
    );
  }
}
