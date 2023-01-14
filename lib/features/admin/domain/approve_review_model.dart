class ApproveReview {
  bool status;
  int reviewId;

  ApproveReview({required this.status, required this.reviewId});

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'reviewId': reviewId,
    };
  }
}
