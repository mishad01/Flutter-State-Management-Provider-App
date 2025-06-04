import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/voting_provider.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    final votingProvider = Provider.of<VotingProvider>(context);
    final isTie = votingProvider.isTie;
    return Scaffold(
      appBar: AppBar(
        title: Text("Voting Result"),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: votingProvider.candidates.length,
            itemBuilder: (context, index) {
              final candidate = votingProvider.candidates[index];
              final isWinner = votingProvider.winners.contains(candidate);
              return ListTile(
                title: Text(
                  candidate.name,
                  style:
                      TextStyle(color: isWinner ? Colors.green : Colors.black),
                ),
                trailing: Text("Votes:${candidate.votes}"),
                subtitle: isWinner ? Text("Winnner") : null,
              );
            },
          )),
        ],
      ),
    );
  }
}
