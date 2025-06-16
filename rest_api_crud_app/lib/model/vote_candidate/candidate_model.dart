class CandidateModel {
  final String id;
  final String name;
  int votes;

  CandidateModel({
    required this.id,
    required this.name,
    this.votes = 0,
  });
}
