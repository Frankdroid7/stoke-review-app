class RankModel {
  int? rankId;
  int? ranking;
  int? placeId;
  String? placeName;

  RankModel(
      {required this.ranking, required this.placeId, required this.placeName});

  RankModel.fromJson(Map<String, dynamic> json) {
    rankId = json['rankId'];
    ranking = json['ranking'];
    placeId = json['placeId'];
    placeName = json['placeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rankId'] = 0;
    data['ranking'] = this.ranking;
    data['placeId'] = this.placeId;
    data['placeName'] = this.placeName;
    return data;
  }
}
