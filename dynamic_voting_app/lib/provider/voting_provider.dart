import 'dart:async';

import 'package:dynamic_voting_app/model/model.dart';
import 'package:flutter/cupertino.dart';

class VotingProvider with ChangeNotifier {
  List<Candidate> _candidates = [
    Candidate(id: "1", name: "Candidate 1"),
    Candidate(id: "2", name: "Candidate 2"),
    Candidate(id: "3", name: "Candidate 3"),
    Candidate(id: "4", name: "Candidate 4"),
  ];
  List<Candidate> get candidates => _candidates;

  String? selectedCandidateId;

  void vote(String candidateId) {
    _candidates = candidates.map((e) {
      if (e.id == candidateId) {
        e.votes += 1;
      }
      return e;
    }).toList();
    selectedCandidateId = candidateId;
    notifyListeners();
    Timer(Duration(seconds: 1), () {
      selectedCandidateId = null;
      notifyListeners();
    });
  }
}
