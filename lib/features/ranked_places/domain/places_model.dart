import '../../review_and_comment/domain/review_model.dart';

class PlacesModel {
  int placeId;
  String placeName;
  int? imageId;
  String? imageUrl;
  int? userId;
  int rank;
  String description;
  List<ReviewData> reviewDtos = [];

  PlacesModel(
      {required this.rank,
      required this.placeId,
      required this.placeName,
      required this.imageId,
      required this.imageUrl,
      required this.description,
      required this.reviewDtos});

  factory PlacesModel.emptyData() {
    return PlacesModel(
      rank: 0,
      placeId: 0,
      placeName: '',
      imageId: 0,
      imageUrl: '',
      description: '',
      reviewDtos: [],
    );
  }

  factory PlacesModel.fromJson(Map<String, dynamic> json) {
    List _reviewDtos = json['reviewDtos'] ?? [];

    return PlacesModel(
      rank: json['rank'] != null ? json['rank'].toInt() : 0,
      placeId: json['placeId'] ?? 0,
      description: json['description'] ?? '',
      placeName: json['placeName'] ?? '',
      imageId: json['imageId'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      reviewDtos: _reviewDtos.map((e) => ReviewData.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['placeId'] = placeId;
    data['placeName'] = placeName;
    data['imageId'] = imageId;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
