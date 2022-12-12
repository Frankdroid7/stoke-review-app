class PlacesModel {
  int placeId;
  String? placeName;
  int? imageId;
  String? imageUrl;
  int? userId;
  int rank = 1;
  List<ReviewData> reviewDtos = [];

  PlacesModel(
      {required this.rank,
      required this.placeId,
      required this.placeName,
      required this.imageId,
      required this.imageUrl,
      required this.reviewDtos});

  factory PlacesModel.emptyData() {
    return PlacesModel(
      rank: 0,
      placeId: 0,
      placeName: '',
      imageId: 0,
      imageUrl: '',
      reviewDtos: [],
    );
  }

  factory PlacesModel.fromJson(Map<String, dynamic> json) {
    List _reviewDtos = json['reviewDtos'];

    return PlacesModel(
      rank: json['rank'],
      placeId: json['placeId'],
      placeName: json['placeName'],
      imageId: json['imageId'],
      imageUrl: json['imageUrl'],
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

class ReviewData {
  int reviewId;
  String reviewText;

  ReviewData({required this.reviewId, required this.reviewText});

  factory ReviewData.fromJson(Map<String, dynamic> json) {
    return ReviewData(
        reviewId: json['reviewId'], reviewText: json['reviewText']);
  }
}
