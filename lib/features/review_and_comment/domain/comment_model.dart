class CommentModel {
  int? commentId;
  String? commentText;
  int? reviewId;

  CommentModel(
      {required this.commentId,
      required this.commentText,
      required this.reviewId});

  CommentModel.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    commentText = json['commentText'];
    reviewId = json['reviewId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentId'] = this.commentId;
    data['commentText'] = this.commentText;
    data['reviewId'] = this.reviewId;
    return data;
  }

  @override
  String toString() {
    return ''' CommentModel(commentId -> $commentId, commentText -> $commentText, reviewId -> $reviewId) ''';
  }
}
