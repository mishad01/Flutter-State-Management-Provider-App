import 'package:flutter/material.dart';
import 'package:rest_api_crud_app/utils/custom_app_bar.dart';

class VoteCandidateHome extends StatefulWidget {
  const VoteCandidateHome({super.key});

  @override
  State<VoteCandidateHome> createState() => _VoteCandidateHomeState();
}

class _VoteCandidateHomeState extends State<VoteCandidateHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Vote Candidate App"),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              label: Text("Search"),
            ),
          ),
        ],
      ),
    );
  }
}
