class PerformerModel {
  final String profile;
  final String name;
  final String id;
  PerformerModel({
    required this.profile,
    required this.name,
    required this.id,
  });
  factory PerformerModel.fromJson(json) {
    return PerformerModel(
      name: json['name'] ?? "",
      profile: json['profile_path'] != null
          ? "https://image.tmdb.org/t/p/w500" + json['profile_path']
          : "https://images.unsplash.com/photo-1503249023995-51b0f3778ccf?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=311&q=80",
      id: json['id'].toString(),
    );
  }
}

class PerformerModelList {
  final List<PerformerModel> peoples;
  PerformerModelList({
    required this.peoples,
  });
  factory PerformerModelList.fromJson(json) {
    return PerformerModelList(
      peoples: (json as List)
          .map((people) => PerformerModel.fromJson(people))
          .toList(),
    );
  }
}
