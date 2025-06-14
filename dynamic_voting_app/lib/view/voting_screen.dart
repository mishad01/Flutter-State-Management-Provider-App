import 'package:dynamic_voting_app/provider/voting_provider.dart';
import 'package:dynamic_voting_app/view/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VotingScreen extends StatelessWidget {
  const VotingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final votingProvider = Provider.of<VotingProvider>(context);
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text("Vote for a candidate"),
        backgroundColor: Colors.blue[100],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: votingProvider.candidates.length,
            itemBuilder: (context, index) {
              final candidate = votingProvider.candidates[index];
              final isVote = votingProvider.selectedCandidateId == candidate.id;
              return ListTile(
                title: Text(candidate.name),
                trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isVote == true ? Colors.green : Colors.white),
                    onPressed: () {
                      votingProvider.vote(candidate.id);
                    },
                    child: Text(
                      "Vote",
                      style: TextStyle(
                          color: isVote == true ? Colors.white : Colors.black),
                    )),
              );
            },
          )),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultScreen(),
                ),
              );
            },
            child: Text("View Result"),
          ),
          Spacer(),
          Spacer(),
        ],
      ),
    );
  }
}
