class ApiConstants {
  ApiConstants._();

  static const String loginUser = '$baseUrl/Token/GetToken';
  static const String registerUser = '$baseUrl/User/PostUser';
  static const String baseUrl =
      'http://stokereviewsapi-dev.eu-west-2.elasticbeanstalk.com';
  static const String getAllPlaces = '$baseUrl/Place/GetAllPlaces';
  static const String getPlacesByName = '$baseUrl/Place/GetPlacesByName';
  static const String getCommentsByReviewId =
      '$baseUrl/Comment/GetCommentsByReview';
  static const String postComment = '$baseUrl/Comment/PostComment';
  static const String postRating = '$baseUrl/Rank/PostRank';
  static const String postReview = '$baseUrl/Review/PostReview';
  static const String getAllReviews = '$baseUrl/Review/GetAllReviews';
}
