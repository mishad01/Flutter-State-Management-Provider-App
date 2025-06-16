import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:rest_api_crud_app/model/vote_candidate/candidate_model.dart';

class VotingViewModel with ChangeNotifier {
  List<CandidateModel> _candidates = [
    CandidateModel(id: "1", name: "Candidate 1"),
    CandidateModel(id: "2", name: "Candidate 2"),
    CandidateModel(id: "3", name: "Candidate 3"),
    CandidateModel(id: "4", name: "Candidate 4"),
  ];

  List<CandidateModel> get candidates => _candidates;

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

  List<CandidateModel> get winner {
    if (_candidates.isEmpty) return [];
    int highestVotes = _candidates
        .map((e) => e.votes)
        .reduce((value, element) => value > element ? value : element);

    if (highestVotes == 0) return [];
    List<CandidateModel> topCandidate =
        _candidates.where((element) => element.votes == highestVotes).toList();

    return topCandidate;
  }

  bool get isTie => winner.length > 1;
}
