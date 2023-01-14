class ReviewModel {
  int? reviewId;
  String? reviewText;
  int? placeId;
  String? placeName;
  String userName = '';
  bool status = false;

  ReviewModel(
      {required this.status,
      required this.reviewText,
      required this.placeId,
      required this.placeName});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    reviewId = json['reviewId'];
    reviewText = json['reviewText'];
    placeId = json['placeId'];
    placeName = json['placeName'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reviewId'] = 0;
    data['reviewText'] = this.reviewText;
    data['placeId'] = this.placeId;
    data['placeName'] = this.placeName;
    data['status'] = this.status;
    return data;
  }
}

class ReviewData {
  bool status;
  int reviewId;
  String reviewText;
  String reviewUserName;

  ReviewData(
      {required this.status,
      required this.reviewUserName,
      required this.reviewId,
      required this.reviewText});

  factory ReviewData.emptyData() {
    return ReviewData(
        reviewUserName: '', reviewId: 0, reviewText: '', status: false);
  }

  factory ReviewData.fromJson(Map<String, dynamic> json) {
    print('JSON REVIEW -> $json');

    return ReviewData(
      status: json['status'] ?? false,
      reviewUserName: json['userName'] ?? '',
      reviewId: json['reviewId'] ?? '',
      reviewText: json['reviewText'] ?? '',
    );
  }
}
