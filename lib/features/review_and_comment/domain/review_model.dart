class ReviewModel {
  int? reviewId;
  String? reviewText;
  int? placeId;
  String? placeName;
  String userName = '';

  ReviewModel(
      {required this.reviewText,
      required this.placeId,
      required this.placeName});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    reviewId = json['reviewId'];
    reviewText = json['reviewText'];
    placeId = json['placeId'];
    placeName = json['placeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reviewId'] = 0;
    data['reviewText'] = this.reviewText;
    data['placeId'] = this.placeId;
    data['placeName'] = this.placeName;
    return data;
  }
}
